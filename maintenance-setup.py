"""
Use this setup file to generate the C code.

$ python maintenance-setup.py build_ext --inplace
"""

from distutils.core import setup
from Cython.Build import cythonize

my_ext_name = 'pyvqcore'

setup(
        name = my_ext_name,
        version = '0.1',
        ext_modules = cythonize(my_ext_name + '.pyx')
        )
