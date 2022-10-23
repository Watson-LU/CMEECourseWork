#!/user/bin/env ipython3
"""Some functions exemplifying the use of control statements"""
__author__ ='Jintao Lu (jl8722@ic.ac.uk)'
__version__ ='0.0.1'

import sys

def foo_1(x):                                       #the first function calculate simple mathematics calculation 
    """Claculate the square root of x """
    return f"the square root of {x} is {x ** 0.5}"

def foo_2(x, y):
    """ Find which variables is larger in numerical"""  #find out which value is larger
    if x >y:
        return f"{x} is the larger one"
    return f"{y} is the larger one"

def foo_3(x,y,z):
    """ compare the three variables and resort them into a new list"""
    if x>y:                                           #compare each variable and readjust the sequence
        tmp =y
        y=x
        x=tmp
    if y>z:
        tmp = y
        y = z
        z = tmp
    return f"change the sequence of otiginal sequence to {[x,y,z]}"

def foo_4(x):
    """show how the ilterial counter work"""        #show the ilterial counter work
    result = 1
    for i in range (1,x +1):
        result = result +1
    return f"after loop for {x} times, the result turns to {result}"

def foo_5(x): 
    """a recursive fuction that calculates the factorial of x"""
    if x == 1:                                      #show the process and results of a recursive function
        return 1
    print("gcalculates the factorial of ", x, "is" ,x *foo_5(x-1) )
    return x * foo_5(x-1)

def foo_6(x):
    """ Calculate the factorial of x in a different way; no if statement involved"""
    facto = 1                                       #another method to show the process and results of a recursive function
    while x>= 1:
        facto = facto *x
        x = x -1
    return f"results for factorial of x is {facto}"

def main(argv):                          #test by some values
    print(foo_1(9))
    print(foo_2(6,7))
    print(foo_2(2,9))
    print(foo_3(9,3,6))
    print(foo_4(4))
    print(foo_5(3))
    print(foo_5(4))
    print(foo_6(3))

if (__name__ == "__main__"):            #must include in the code to let it run by itself
    status = main(sys.argv)
    sys.exit(status)
















