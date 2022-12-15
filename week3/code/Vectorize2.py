#!/usr/bin/env python3

"""This script is the translated version of Vectorise2.py"""

__appname__ = 'Vectorize2'
__author__ = '01_Awesome_Aardvarks'
__version__ = '0.0.1'
__license__ = 'None'

import numpy as np 
import time

def stochrick(p0 = np.random.uniform(.5, 1.5, 1000), r = 1.2, K = 1, sigma = 0.2, numyears = 100):
    """Runs the stochastic Ricker equation with Gaussian fluctuations"""
    N = np.zeros((numyears, len(p0)))  #initial the empty matrix
    N[0] = p0

    # the loop 
    for pop in range(len(p0)):
        for yr in range(1, numyears):
            N[yr, pop] = N[yr - 1, pop] * np.exp(r * (1 - N[yr - 1, pop] / K) + np.random.normal(0, sigma, 1))
    return N


# Now write another function called stochrickvect that vectorizes the above function
def stochrickvect(p0 = np.random.uniform(.5, 1.5, 1000), r = 1.2, K = 1, sigma = 0.2, numyears = 100):
    """Runs vectorised version of above function"""
    N = np.zeros((numyears, len(p0)))  #same methods
    N[0] = p0 
    for yr in range(1, numyears):
        N[yr, ] = N[yr - 1, ] * np.exp(r * (1 - (N[yr - 1, ] / K)) + np.random.normal(0, sigma, size = 1))
    return N


# time stochrick
start = time.time()
stochrick()
end = time.time()
print("Non-vectorized Stochastic Ricker takes:")
print(end - start)

# time stochrickvect
start = time.time()
stochrickvect()
end = time.time()
print("Vectorized Stochastic Ricker takes:")
print(end - start)

print("vectorise2.py is done")