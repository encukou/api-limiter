import sys
from pathlib import Path
import subprocess

from api_limiter.context import Context
from api_limiter.static_to_dynamic import static_to_dynamic

converted_type_names = []

for filename in sys.argv[1:]:
    filepath = Path(filename)
    ctx = Context(filepath=filepath, cpp_args=['-D_POSIX_THREADS'])
    #ctx.ast.show(showcoord=True)
    converted_type_names.extend(static_to_dynamic(ctx))
    for line in ctx.gen_diff(colors=True):
        print(line, end='')
    #ctx.write_back(filepath)

with Path('replacer.cocci').open('w') as outfile:
    def output(*pieces):
        print(*pieces)
        print(*pieces, file=outfile)

    for type_name in converted_type_names:
        output(f'@@')
        output(f'identifier T = {type_name};')
        output(f'@@')
        output(f'- &T')
        output(f'+ T')
        output()

        output(f'@ spek_{type_name} @')
        output(f'identifier T = {type_name};')
        output(f'fresh identifier S = T ## "_Spec";')
        output(f'@@')
        output(f'- extern PyTypeObject T;')
        output(f'+ extern PyTypeObject* T;')
        output(f'+ extern PyType_Spec S;')
        output()

        output(f'@@')
        output(f'identifier spek_{type_name}.T;')
        output(f'identifier spek_{type_name}.S;')
        output(f'@@')
        output('+ PyTypeObject* T;')
        output('  PyType_Spec S = {')
        output('  ...')
        output('  };')
        output()

subprocess.run([
    'spatch',
    '--smpl-spacing',
    '-I', '.',
    #'--include', 'Python.h',
    '--preprocess',
    '--sp-file',
    'replacer.cocci',
    *sys.argv[1:],
    *Path('~/dev/rpm/python/').expanduser().glob('*.h'),
])

