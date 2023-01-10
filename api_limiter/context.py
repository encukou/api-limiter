from pathlib import Path
from dataclasses import dataclass
from itertools import count
import re

from pycparser import parse_file
from pycparser.c_ast import Node

INTERESTING_CHARS = re.compile(r'''[][(){}"]|\\.''')
OPENERS = dict(('}{', ')(', '][', '""'))

class Context:
    files: dict[Path, 'FileContext']

    def __init__(self, filename, cpp_args):
        self.file_contexts = {}
        self.ast = parse_file(
            filename,
            use_cpp=True,
            cpp_args=[
                '-E',
                '-D__attribute__(x)=',
                '-D_Atomic(x)=x',
                '-I', Path(__file__).parent.parent / 'pycparser/utils/fake_libc_include',
                *cpp_args
            ],
        )
        self[filename]

    def __getitem__(self, path):
        path = Path(path)
        try:
            return self.file_contexts[path]
        except KeyError:
            self.file_contexts[path] = FileContext(path)
            return self.file_contexts[path]

    def gen_diff(self, *args, **kwargs):
        for file_context in self.file_contexts.values():
            yield from file_context.gen_diff(*args, **kwargs)

    def remove_struct_at(self, filename, orig_lineno):
        self[filename].remove_struct_at(orig_lineno)

    def add_lines(self, filename, orig_lineno, *lines):
        self[filename].add_lines(orig_lineno, *lines)

class FileContext:
    filename: Path
    original_lines: tuple[str]
    _removed_lines: set[int]
    _added_lines: dict[int, list[str]]

    def __init__(self, filename):
        self.filename = filename
        with filename.open() as f:
            self.original_lines = tuple(f)
        self._removed_lines = set()
        self._added_lines = {}

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
