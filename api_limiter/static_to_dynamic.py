import sys
from pathlib import Path
from dataclasses import dataclass

from pycparser.c_ast import Node, Decl, TypeDecl, IdentifierType, Constant, ID
from pycparser.c_ast import NamedInitializer, InitList, UnaryOp, Cast, BinaryOp
from pycparser.c_ast import Typename

from api_limiter.context import Context

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
        match node:
            case Decl(
                name=declname,
                type=TypeDecl(type=IdentifierType(names=[decltype])),
            ) if declname == name and decltype == typename:
                ctx.remove_struct_at(node.coord.file, node.coord.line)
                return get_fields(node.init, SUBTABLE_FIELDS[typename])

def convert_static_type(ctx, decl):
    filename = decl.coord.file
    start_line = decl.coord.line
    ctx.remove_struct_at(filename, start_line)
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
    ctx.add_lines(filename, start_line, *slots_lines, '', *spec_lines)

def static_to_dynamic(ctx):
    """Convert static types to dynamic ones in the given context.

    Return a list of the converted type names.
    """
    names = []
    for node in ctx.ast:
        match node:
            case Decl(
                type=TypeDecl(type=IdentifierType(names=['PyTypeObject'])),
                init=InitList(),
            ):
                convert_static_type(ctx, node)
                names.append(node.name)
    return names
