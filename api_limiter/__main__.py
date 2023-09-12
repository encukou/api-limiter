import sys
from pathlib import Path
import subprocess

from api_limiter.context import Context
from api_limiter.static_to_dynamic import static_to_dynamic

converted_type_names = []

DRY_RUN = False

for filename in sys.argv[1:]:
    filepath = Path(filename)
    ctx = Context(filepath=filepath, cpp_args=['-D_POSIX_THREADS'])
    #ctx.ast.show(showcoord=True)
    converted_type_names.extend(static_to_dynamic(ctx))
    for line in ctx.gen_diff(colors=True):
        print(line, end='')
    if not DRY_RUN:
        ctx.write_back(filepath)

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

        output(f'@@')
        output(f'identifier T = {type_name};')
        output(f'fresh identifier S = T ## "_Spec";')
        output(f'@@')
        output(f'- extern PyTypeObject T;')
        output(f'+ extern PyTypeObject* T;')
        output(f'+ extern PyType_Spec S;')
        output()

        output(f'@@')
        output(f'@@')
        output(f'+ PyTypeObject* {type_name};')
        output(f'  PyType_Spec {type_name}_Spec = {{')
        output('  ...')
        output('  };')
        output()


proc_args = [
    'spatch',
    '--smpl-spacing',
    '-I', '.',
    '--preprocess',
    '--sp-file',
    'replacer.cocci',
    *[
        p for p in sys.argv[1:]
        if not p.endswith('rpmmodule.c')
    ],
    *Path('~/dev/rpm/python/').expanduser().glob('*.h'),
]
if not DRY_RUN:
    proc_args.append('--in-place')
subprocess.run(proc_args)

