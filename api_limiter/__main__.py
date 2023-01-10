import sys

from api_limiter.context import Context
from api_limiter.static_to_dynamic import static_to_dynamic

for filename in sys.argv[1:]:
    ctx = Context(filename=filename, cpp_args=['-D_POSIX_THREADS'])
    ctx.ast.show(showcoord=True)
    type_names = static_to_dynamic(ctx)
    for line in ctx.gen_diff(colors=True):
        print(line, end='')
