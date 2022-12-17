#!/usr/bin/env python3
from errno import WSAEHOSTDOWN


def foo(x):
    x *= x  #same as x = x*x
    print(x)
    return x  #necesssarily to add to store the results

%whos

foo(2)
y = foo(2)
y
type(y)
%whos


def foo(x):
    x *= x  #same as x = x*x
    print(x)
    #return x        

y =foo(2)
y            #can be calculate it but could not to be stored!
type(y)

































