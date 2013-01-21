"""
This is for the inner loop of the kmeans.

For compilation instructions see
http://docs.cython.org/src/reference/compilation.html
For example:
$ cython -a pyvqcore.pyx
$ gcc -shared -pthread -fPIC -fwrapv -O2 -Wall -fno-strict-aliasing \
      -I/usr/include/python2.7 -o pyvqcore.so pyvqcore.c
"""

from cython.view cimport array as cvarray
import numpy as np
cimport numpy as np
cimport cython

np.import_array()

__all__ = [
        'update_centroids',
        'update_labels',
        ]

@cython.boundscheck(False)
@cython.wraparound(False)
def update_centroids(
        np.float64_t [:, :] data_points,
        np.float64_t [:, :] centroids,
        np.int_t [:] labels,
        ):
    cdef long npoints = data_points.shape[0]
    cdef long ndims = data_points.shape[1]
    cdef long ncentroids = centroids.shape[0]
    cdef long i, k
    if centroids.shape[1] != ndims:
        raise ValueError(
                'the dimension of the centroid vectors does not match '
                'the dimension of the data vectors')
    for i in range(npoints):
        if not 0 <= labels[i] < ncentroids:
            raise ValueError('one of the labels is not valid')
    for i in range(npoints):
        for k in range(ndims):
            centroids[labels[i], k] += data_points[i, k]
    return None


@cython.boundscheck(False)
@cython.wraparound(False)
def update_labels(
        np.float64_t [:, :] data_points,
        np.float64_t [:, :] centroids,
        np.int_t [:] labels,
        np.int_t [:] cluster_mask,
        np.int_t [:] cluster_sizes,
        ):
    """
    @param data_points: each row is an observation
    @param centroids: each row is a centroid
    @param labels: update these assignments
    @param cluster_mask: disregard clusters whose mask value is zero
    @param cluster_sizes: accumulate cluster counts into this array
    @return: residual sum of squares
    """
    cdef long npoints = data_points.shape[0]
    cdef long ndims = data_points.shape[1]
    cdef long ncentroids = centroids.shape[0]
    cdef long i, j, k
    cdef long best_centroid_index
    cdef double best_centroid_dsquared
    cdef double dsquared
    cdef double delta
    cdef double rss = 0
    if centroids.shape[1] != ndims:
        raise ValueError(
                'the dimension of the centroid vectors does not match '
                'the dimension of the data vectors')
    if labels.shape[0] != npoints:
        raise ValueError(
                'the number of labels does not match '
                'the number of data points')
    if cluster_mask.shape[0] != ncentroids:
        raise ValueError(
                'the cluster mask vector length does not match '
                'the number of centroids')
    if cluster_sizes.shape[0] != ncentroids:
        raise ValueError(
                'the cluster size vector length does not match '
                'the number of centroids')
    for i in range(npoints):
        best_centroid_index = -1
        best_centroid_dsquared = -1
        for j in range(ncentroids):
            if not cluster_mask[j]:
                continue
            dsquared = 0
            for k in range(ndims):
                delta = data_points[i, k] - centroids[j, k]
                dsquared += delta * delta
            if best_centroid_index == -1 or dsquared < best_centroid_dsquared:
                best_centroid_index = j
                best_centroid_dsquared = dsquared
        rss += best_centroid_dsquared
        labels[i] = best_centroid_index
        cluster_sizes[best_centroid_index] += 1
    return rss

