
from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

my_ext = Extension(
        'pyvqcore',
        ['pyvqcore.pyx'],
        )

setup(
        name = 'pyvqcore',
        version = '0.1',
        cmdclass = { 'build_ext' : build_ext },
        ext_modules = [my_ext],
        )
