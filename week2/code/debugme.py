def buggyfunc(x):
    y = x
    for i in range (x):
        try:
            y = y -1
            z =x/y
        except ZeroDivisionError:
            print(f"the result of dividing a number by zero is undefined")
        except:
            print(f"this didn't work ; {x=}; {y=}")
        else:
            print(f"ok, ; {x=}; {y=}, {z=}")           
    return z

buggyfunc(20)
