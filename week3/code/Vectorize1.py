#!/usr/bin/env python3

""" This script is the transfered version of Vectorise1.R"""

__appname__ = 'Vectorize1'
__author__ = '01_Awesome_Aardvarks'
__version__ = '0.0.1'
__license__ = 'None'

import numpy as np
import time
#create the random matrix
T = np.mat(np.random.randint(1000000,size=(1000,1000)))


def sumallelements(T):
    """Paremeters:
    T(matrix): the given matrix
    Returns:
        sum(float): sum all elements in M
    """
    dimension = T.shape
    Sum = 0
    for i in range(0,dimension[0]): #loop rows
        for j in range(0,dimension[1]): # loop columns
                Sum = Sum + T[i,j]
    return Sum

# time sumallelements
start = time.time()
sumallelements(T)  
end = time.time()
print("after the loop, time is:", end-start) 

# time sum function in numpy
start = time.time()
np.sum(T) # vectorized function
end = time.time()
print("after the vectorized function in numpy, the time is:", end - start)

print("vectorise1.py is done")