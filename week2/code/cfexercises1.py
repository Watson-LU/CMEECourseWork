

def foo_1(x):
    return x ** 0.5

def foo_2(x, y):
    if x >y:
        return x
    return y

def foo_3(x,y,z):
    if x>y:
        tmp =y
        y=x
        x=tmp
    if y>z:
        tmp = y
        y = z
        z = tmp
    return [x,y,z]

def foo_4(x):
    result = 1
    for i in range (1,x +1):
        result = result +1
    return result

def foo_5(x):  #a recursive fuction that calculates the factorial of x
    if x == 1:
        return 1
    return x * foo_5(x-1)

def foo_6(x):
    facto = 1
    while x>= 1:
        facto = facto *x
        x = x -1
    return facto



























