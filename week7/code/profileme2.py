
#convert the loop to a list comprehension
def my_squares(iters):
    out = [i** 2 for i in range (iters)]
    return out

#replaced the .join with an explict string concatenation
def my_join(iters, string):
    out= ", "
    for i in range(iters):
        out += ", " + string
    return out

def run_myfuncs(x,y):
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0


run_myfuncs(10000000, "my string")

#run -p profileme2.py

#different functions about output the time
#run -p -s cumtime profileme2.py      ## allow sorting by certain column

#run without python bash
#python3 -m cProfile profileme2.py
#python3 -m cProfile -o profires myscript.py
















