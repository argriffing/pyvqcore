pyvqcore
========

A Cython module for the internals of a kmeans algorithm.

The point of this module is to provide a fast
double precision independent implementation of something like
http://docs.scipy.org/doc/scipy/reference/generated/scipy.cluster.vq.vq.html
which will depend on numpy but not on scipy.

Requirements
------------

 * Python 2.7+
 * Numpy
 * Cython
 * infrastructure to build object library files from C code


Install
-------

`pip install --user https://github.com/argriffing/pyvqcore/zipball/master`

