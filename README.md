pyvqcore
========

A Python C-extension module for the internals of a kmeans algorithm.

The point of this module is to provide a fast
double-precision independent implementation of something like
http://docs.scipy.org/doc/scipy/reference/generated/scipy.cluster.vq.vq.html
but which depends only on Numpy and not on SciPy or Cython.


Requirements
------------

 * [Python](http://python.org/) 2.7+ (but it is not tested on 3.x)
 * [NumPy](http://www.numpy.org/)
 * a computing environment that knows how to compile C code


Installation
------------

The easiest way to install this module is to use
[pip](http://www.pip-installer.org/).
to install directly from github.

`pip install --user https://github.com/argriffing/pyvqcore/zipball/master`

This does not not require administrator privileges,
and it can be easily reverted using the command

`pip uninstall pyvqcore`

The installation should be very easy with Linux-based operating systems,
more difficult with OS X,
and probably not worth attempting on Windows.

