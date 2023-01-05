import sys
import subprocess
import pycparser
from pathlib import Path
from dataclasses import dataclass
from itertools import count
import re

from pycparser import parse_file, c_ast
from pycparser.c_ast import Node, Decl, TypeDecl, IdentifierType, Constant, ID
from pycparser.c_ast import NamedInitializer, InitList, UnaryOp, Cast, BinaryOp
from pycparser.c_ast import Typename

INTERESTING_CHARS = re.compile(r'''[][(){}"]|\\.''')
OPENERS = dict(('}{', ')(', '][', '""'))

# Stable enough to hardcode for now...:
PYTYPEOBJECT_FIELDS = tuple("""
    ob_base
    tp_name tp_basicsize tp_itemsize tp_dealloc tp_vectorcall_offset tp_getattr
    tp_setattr tp_compare tp_repr tp_as_number tp_as_sequence tp_as_mapping
    tp_hash tp_call tp_str tp_getattro tp_setattro tp_as_buffer tp_flags tp_doc
    tp_traverse tp_clear tp_richcompare tp_weaklistoffset tp_iter tp_iternext
    tp_methods tp_members tp_getset tp_base tp_dict tp_descr_get tp_descr_set
    tp_dictoffset tp_init tp_alloc tp_new tp_free tp_is_gc
    tp_bases tp_mro tp_cache tp_subclasses tp_weaklist tp_del tp_version_tag
    tp_finalize tp_vectorcall tp_watched
""".split())
SUBTABLE_FIELDS = {
    'PySequenceMethods': [
        'sq_length', 'sq_concat', 'sq_repeat', 'sq_item', 'WAS!_sq_slice',
        'sq_ass_item', 'WAS!_sq_ass_slice','sq_contains', 'sq_inplace_concat',
        'sq_inplace_repeat',
    ],
    'PyMappingMethods': [
        'mp_length', 'mp_subscript', 'mp_ass_subscript',
    ],
    'PyNumberMethods': [
        'nb_add', 'nb_subtract', 'nb_multiply', 'nb_remainder', 'nb_divmod',
        'nb_power', 'nb_negative', 'nb_positive', 'nb_absolute', 'nb_bool',
        'nb_invert', 'nb_lshift', 'nb_rshift', 'nb_and', 'nb_xor', 'nb_or',
        'nb_int', 'nb_reserved', 'nb_float',
        'nb_inplace_add', 'nb_inplace_subtract', 'nb_inplace_multiply',
        'nb_inplace_remainder', 'nb_inplace_power', 'nb_inplace_lshift',
        'nb_inplace_rshift', 'nb_inplace_and', 'nb_inplace_xor',
        'nb_inplace_or',
        'nb_floor_divide', 'nb_true_divide', 'nb_inplace_floor_divide',
        'nb_inplace_true_divide',
        'nb_index',
        'nb_matrix_multiply', 'nb_inplace_matrix_multiply',
    ],
}
SUBTABLES = {
    'tp_as_sequence': 'PySequenceMethods',
    'tp_as_mapping': 'PyMappingMethods',
    'tp_as_number': 'PyNumberMethods',
}
TYPE_FLAGS = {
    # key is the shift value
    10: 'Py_TPFLAGS_BASETYPE',
}

cpp_args = [
    '-E',
    '-D__attribute__(x)=',
    '-D_Atomic(x)=x',
    '-D_POSIX_THREADS',
    '-I', Path(__file__).parent / 'pycparser/utils/fake_libc_include',
]
#subprocess.run(['cpp', *cpp_args, sys.argv[1]])

@dataclass
class Context:
    filename: str
    ast: Node
    original_lines: list[str]
    _removed_lines: set[int]
    _added_lines: dict[int, list[str]]

    def remove_lines(self, start, stop):
        self._removed_lines.update(range(start, stop))

    def remove_struct_at(self, orig_lineno):
        # Removing code is a bit tricky, since pycparser doesn't give us an
        # end coordinate. So we use a simple algorithm that scans for a
        # matchig brace.
        # Limitations:
        # - Only whole lines can be removed
        # - The removed struct can't share lines with any other code
        # - The opening brace must be at 'orig_lineno'
        # - The semicolon must be at the line with the closing brace
        # - And more?
        stack = []
        def _add_to_stack(c, lineno):
            if opener := OPENERS.get(c):
                if stack and stack[-1] == opener:
                    stack.pop()
                    return
                elif opener != c:
                    raise NotImplementedError(f"{self.filename}:{lineno}: unexpected '{c}'")
            stack.append(c)
        should_end = False
        for lineno in count(start=orig_lineno):
            self._removed_lines.add(lineno)
            line = self.original_lines[lineno-1]
            for c in INTERESTING_CHARS.findall(line):
                if c.startswith('\\'):
                    continue
                _add_to_stack(c, lineno)
                if not stack:
                    should_end = True
            if should_end:
                if not line.strip().endswith('};'):
                    raise NotImplementedError(f"{self.filename}:{lineno}: expected semicolon at end, {line=}")
                if stack:
                    raise NotImplementedError(f"{self.filename}:{lineno}: unexpected situation, {stack=} {c=}")
                break

    def add_lines(self, after_orig_line, *lines, end='\n'):
        for line in lines:
            line = line.rstrip() + end
            self._added_lines.setdefault(after_orig_line, []).append(line)

    def iter_lines(self):
        for number, line in enumerate(self.original_lines, start=1):
            if number not in self._removed_lines:
                yield line
            for extra_line in self._added_lines.get(number, ()):
                yield extra_line

    def gen_diff(self, context_size=3, colors=False):
        if colors:
            REMOVED = '\x1b[31m-{}\x1b[m'
            ADDED = '\x1b[32m+{}\x1b[m'
            CONTEXT = ' {}'
            HEADER = '\x1b[36m{}\x1b[m'
        else:
            REMOVED = '-{}'
            ADDED = '+{}'
            CONTEXT = ' {}'
            HEADER = '{}'
        affected = self._removed_lines | self._added_lines.keys()
        if affected:
            yield HEADER.format(f'--- {self.filename}\n')
            yield HEADER.format(f'+++ {self.filename}\n')
        last_lineno = None
        new_lineno = 1
        for number, line in enumerate(self.original_lines, start=1):
            if (
                number in affected
                or any(
                    n in affected
                    for n in range(number-context_size, number+1+context_size)
                )
            ):
                for extra_line in self._added_lines.get(number, ()):
                    yield ADDED.format(extra_line)
                    new_lineno += 1
                if last_lineno != number - 1:
                    yield HEADER.format(f'@@ -{number} +{new_lineno} @@\n')
                if number in self._removed_lines:
                    yield REMOVED.format(line)
                else:
                    yield CONTEXT.format(line)
                    new_lineno += 1
                last_lineno = number
            else:
                new_lineno += 1

@dataclass
class TypeVarHead:
    metaclass: object

def undigraph(string):
    """Replace the <% and %> digraphs by { and }.

    Useful when generating code via F-strings.
    """
    return string.replace('<%', '{').replace('%>', '}')

def unparse(node):
    match node:
        case Constant():
            return node.value
        case UnaryOp(op='sizeof' as op, expr=expr):
            return f'{op}({unparse(expr)})'
        case UnaryOp(op=op, expr=expr) if len(op) == 1:
            return '(' + op + unparse(expr) + ')'
        case Typename(quals=[], type=typenode):
            return unparse(typenode)
        case TypeDecl(quals=[], type=typenode):
            return unparse(typenode)
        case IdentifierType(names=[name]):
            return name
        case ID(name=name):
            return name
        case _:
            raise ValueError((type(node), node))

def get_fields(initializers, field_names):
    result = {}
    field_index = -1
    def get_field(initializer):
        nonlocal field_index
        match initializer:
            case Constant(value='0'):
                # Can be skipped
                return None
            case NamedInitializer(name=[ID(name=name)], expr=inner):
                field_index = field_names.index(name)
                return get_field(inner)
            case InitList(exprs=[
                InitList(exprs=[
                    Constant(value='1'),
                    Node() as metaclass,
                ]),
                Constant(value='0'),
            ]):
                return TypeVarHead(metaclass)
            case Cast(expr=expr):
                # Casts can be ignored
                return get_field(expr)
            case Constant() | UnaryOp() | ID() | BinaryOp():
                return initializer
            case _:
                raise NotImplementedError(initializer)
    for initializer in initializers:
        field_index += 1
        field_value = get_field(initializer)
        if field_value is not None:
            field_name = field_names[field_index]
            if field_name in result:
                raise ValueError(f'duplicate slot name {field_name}')
            result[field_name] = field_value
    return result

def recover_type_flags(node):
    match node:
        case BinaryOp(op='|', left=left, right=right):
            return recover_type_flags(left) + recover_type_flags(right)
        case Constant(value='0'):
            return []
        case BinaryOp(
            op='<<',
            left=Constant(value='1UL'),
            right=Constant(type='int', value=shift),
        ):
            return [TYPE_FLAGS[int(shift)]]
        case _:
            raise NotImplementedError(node)

def absorb_subtable(ctx, typename, name):
    for node in ctx.ast:
        if node.coord.file != filename:
            continue
        match node:
            case Decl(
                name=declname,
                type=TypeDecl(type=IdentifierType(names=[decltype])),
            ) if declname == name and decltype == typename:
                ctx.remove_struct_at(node.coord.line)
                return get_fields(node.init, SUBTABLE_FIELDS[typename])

def convert_static_type(ctx, decl):
    start_line = decl.coord.line
    ctx.remove_struct_at(start_line)
    slots_lines = [
        undigraph(f'static PyType_Slot {decl.name}_Slots[] = <%'),
    ]
    spec_lines = [
        undigraph(f'PyType_Spec {decl.name}_Spec = <%'),
    ]
    fields = get_fields(decl.init, PYTYPEOBJECT_FIELDS)
    if flag_field := fields.pop('tp_flags', None):
        flags = recover_type_flags(flag_field)
    else:
        flags = []
    if 'Py_TPFLAGS_DEFAULT' not in flags:
        flags.insert(0, 'Py_TPFLAGS_DEFAULT')
    default_flags = {
        'Py_TPFLAGS_DEFAULT',
        'Py_TPFLAGS_IMMUTABLETYPE',
        'Py_TPFLAGS_DISALLOW_INSTANTIATION',
    }
    def add_slot(field_name, field_value):
        slots_lines.append(undigraph(
            f'    <%Py_{field_name}, {unparse(field_value)}%>,',
        ))
    for field_name, field_value in fields.items():
        match field_name, field_value:
            case 'ob_base', TypeVarHead(metaclass=UnaryOp(
                op='&',
                expr=ID(name='PyType_Type'),
            )):
                pass
            case 'tp_name', _:
                spec_lines.append(f'    .name = {unparse(field_value)},')
            case 'tp_basicsize', _:
                spec_lines.append(f'    .basicsize = {unparse(field_value)},')
            case (
                'tp_hash' | 'tp_dealloc' | 'tp_getattro' | 'tp_setattro'
                | 'tp_doc' | 'tp_iter' | 'tp_iternext' | 'tp_methods'
                | 'tp_init' | 'tp_getset' | 'tp_str' | 'tp_repr'
                | 'tp_richcompare'
            ), _:
                add_slot(field_name, field_value)
            case (
                field_name, UnaryOp(op='&', expr=ID(name=name))
            ) if field_name in SUBTABLES:
                subslots = absorb_subtable(ctx, SUBTABLES[field_name], name)
                for fname, fvalue in subslots.items():
                    add_slot(fname, fvalue)
            case 'tp_new', _:
                default_flags.discard('Py_TPFLAGS_DISALLOW_INSTANTIATION')
                add_slot(field_name, field_value)
            case _:
                raise ValueError((field_name, field_value))
    slots_lines.append('    {0, NULL},')
    slots_lines.append('};')
    for default_flag in default_flags:
        if default_flag not in flags:
            flags.append(default_flag)
    spec_lines.append(f'    .flags = {" | ".join(flags)},')
    spec_lines.append(f'    .slots = {decl.name}_Slots,')
    spec_lines.append('};')
    ctx.add_lines(start_line, *slots_lines, '', *spec_lines)

def limit_file(filename):
    ast = parse_file(
        filename,
        use_cpp=True,
        cpp_args=cpp_args,
    )
    with Path(filename).open() as f:
        lines = list(f)
    ctx = Context(
        filename=filename,
        ast=ast,
        original_lines=lines,
        _removed_lines=set(),
        _added_lines={},
    )
    ast.show(showcoord=True)
    for node in ast:
        if node.coord.file != filename:
            continue
        match node:
            case Decl(type=TypeDecl(type=IdentifierType(names=['PyTypeObject']))):
                convert_static_type(ctx, node)
    return ctx

for filename in sys.argv[1:]:
    ctx = limit_file(filename)
    for line in ctx.gen_diff(colors=True):
        print(line, end='')
