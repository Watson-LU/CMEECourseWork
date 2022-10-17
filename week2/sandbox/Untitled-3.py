
from decimal import ROUND_HALF_DOWN


for i in range(x):
    if i >3:
    print(i)

a = range(10)
a

for i in range(1,6):
    print(i)


my_iterable =[1,2,3] 
type(my_iterable)

my_iterator = iter(my_iterable)
type(my_iterator)
next(my_iterator)



x = 0; y = 2
if x<y:
    print('yes')

if x:
    print('yes')

if x==0:
    print('yes')

if y:
    print('yes')

if y==2:
    print('yes') 


x = True
if x:
    print('yes') 

if x ==True:
    print('yes')

x = [ i for i in range (10)]
print(x)

x = []
for i  in range (10):
    x.append(i)
print(x)

x = [i.lower () for i in ["LIST", "COMPREHENSIONS","ARE", "COOL"]]
print(x)

x = ["LIST", "CIMOREHENSIONS", "ARE", "COOL"]
for i in range (len(x)):
    x[i]=x[i].lower()

print(x)

x = ["LIST", "CIMOREHENSIONS", "ARE", "COOL"]
x_new= []
for i in x:
    x_new.append(i.lower())

print(x_new)

matrix = [1,2,3], [4,5,6],[7,8,9]
flattened_matrix =[]
for  row  in matrix:
    for n in row:
        flattened_matrix.append(n)

print(flattened_matrix)

matrix =[1,2,3],[4,5,6],[7,8,9]
flattened_matrix=[n for row in matrix for n in row]
print(flattened_matrix)


words =(["These", "are","some", "words"])
first_letters = set()
for w in words:
    first_letters.add(w[0])

print(first_letters)

words = (["These","are", "some","words"])
first_letters={w[0]for w in words}
print(first_letters)


i =1
x =0
for i in range(10):
    x = x+1

print(i,x)
print(x)
print(i)

i=1
x=0
def a_function(y):
    x=0
    for i in range(y):
        x = x+1
    return x , y

t = a_function(10)

print(t)
print(i)


###### new test for global variables

_a_global = 10 ##this is a global variable

if _a_global >=5:
    _b_global = _a_global + 5 # also a global varialbe


print("Before calling a_function, outside the function, the value of _a_global is", _a_global)
print("Before calling a_function, outside the function, the value of _b_global is", _b_global)

def a_fuction():
    _a_global = 4   ## a local variable

    if _a_global >= 4:
        _b_global = _a_global +5  # also a local variable

    _a_local = 3
    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _b_global is", _b_global)
    print("Inside the function, the value of _a_local is", _a_local)

a_fuction()

print("After calling a_function, outside the function, the value of _a_global is (still)", _a_global)
print("After calling a_function, outside the function, the value of _b_global is (still)", _b_global)

print("After calling a_function, outside the function, the value of _a_local is ", _a_local)



_a_global =10

def a_function():
    _a_local =4

    print("Inside the function, the value _a_local is", _a_local)
    print("Inside the function, the value of _a_global is", _a_global)

a_function()

print("Outside the function, the value of _a_global is", _a_global)


############ importance of the return directive

def modify_list_1(some_list):
    print('got', some_list)
    some_list = [1,2,3,4]
    print('set to' , some_list)

my_list = [1,2,3]

print('before, my_ list =' ,my_list)

modify_list_1(my_list)


print('after, my_list =', my_list)


##change with return left

def modify_list_2(some_list):
    print('got', some_list)
    some_list=[1,2,3,4]
    print('set to', some_list)
    return some_list

my_list = modify_list_2(my_list)

print('after, my_list=', my_list)

##use append to modify the original list 

def modify_list_3(some_list):
    print('got', some_list)
    some_list.append(4) #an actual modification of the list
    print('changed to ', some_list)

my_list = [1,2,3]

print('before, my_list', my_list)

modify_list_3(my_list)

print('after,my_list =', my_list)

#####safely open files using  with open

with open ("../path/to/file.txt", 'r') as myfile:
    #do things to myfile



##########33
#file input
#######3###
#open a file for reading

with open("../sandbox/test1.txt" ,'r') as f:
#use "implicit for loop"
#if the object is a file, python will cycle over lines
    for line in f:
        print(line)

#once you drop out of the with, the file is automatically closed
with open("../sandbox/test1.txt" ,'r') as f:
    for line in f:
        if len(line.strip()) >0:
            print(line)































