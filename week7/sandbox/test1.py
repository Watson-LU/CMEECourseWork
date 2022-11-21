import numpy as np
a = np.array(range(5))
a
%whos

print(type(a))
print(type(a[0]))

##set the array from python code
a = np.array(range(5),float)
a
a.dtype

x=np.arange(5)
x   
x.shape
?x.shape

##set the list 
b = np.array([i for i in range(10) if i %2 ==1])
b

c=b.tolist()  ##convert back to the nomal list
c

mat= np.array([[0,1], [2,3]])
mat
mat.shape

mat[1]
mat[0]

mat[:,1]
mat[0,0]
mat[1,0]

mat[:,0]

###manipulating arrays-----more efficient method to run the code
# replacing adding or deleting elements
mat[0,0] = -1
mat
mat[:,0] = [12,12] #replace whole column
mat
np.append(mat, [[12,12]], axis = 0) #append row, note axis specification, 0 = new row
np.append(mat, [[12],[12]], axis = 1) #append column, 1 = new column
newRow = [[12,12]] #create new row
mat = np.append(mat, newRow, axis = 0) #append that existing row
mat
np.delete(mat, 2, 0) #Delete 3rd row

#concatenation
mat= np.array([[0,1], [2,3]])
mat0 = np.array([[0,10],[-1,3]])
np.concatenate((mat,mat0), axis = 0)

# flattening or reshping arrays  都是以行为初始操作
mat.ravel()    #压扁

mat.reshape(4,1)   #重塑
mat.reshape(1,4)  
mat.reshape((3,1))

###pre-cllocating arrays
np.ones((4,2))
np.zeros((4,2))    #set zeros

m=np.identity(4)  #create a identity matrix, unique matrix
m

m.fill(16)   #fill all matrix with 16
m

###numpy matrices
# matrix-vector operations 矩阵-向量运算

mm=np.arange(16)     #set as array
mm=mm.reshape(4,4)   #transform it to matrix!!
mm.transpose()

mm + mm.transpose()

mm * mm.transpose() # Note that this is element-wise multiplication

mm // mm.transpose()  #note it is integer division

mm // (mm +1).transpose()

mm*np.pi

mm.dot(mm) # No this is matric multiplication, or the dot product 矩阵点乘法

mm = np.matrix(mm)   ##基本没用， 以后会被移除
mm

print(type(mm))

mm*mm

#### the sicpy package
# basically recommand using numpy for creating and manipulating datya and 
#scipy for complex numerical operation.

import scipy as sc
from scipy import stats


## sicpy.stats
sc.stats.norm.rvs(size=10)

np.random.seed
sc.stats.norm.rvs(size=10)

sc.stats.norm.rvs(size=5, random_state=1234)   #不设置全局seeds， 设置单独的seeds
sc.stats.randint.rvs(0, 10, size = 7)

sc.stats.randint.rvs(0, 10, size = 7, random_state=3445) # a different seed


#Numerical integration using scipy   ##数值积分方程
import scipy.integrate as integrate

y = np.array([5,20,18,19,18,7,4])

import matplotlib.pylab as p

p.plot(y)
p.show()
area = integrate.trapz(y, dx = 2)
print("area =", area)

area = integrate.trapz(y, dx = 1)
print("area =", area)

area = integrate.simps(y, dx = 2)
print("area =", area)

##The Lotka-Volterra model

def dCR_dt(pops, t=0):

    R = pops[0]
    C = pops[1]
    dRdt = r* R- a*R*C
    dCdt = -z *C +e*a*R*C

    return np.array([dRdt, dCdt])

type(dCR_dt)

r =1.
a=0.1
z = 1.5
e = 0.75

t = np.linspace(0,15,1000)

R0=10
C0=5
RC0 = np.array([R0,C0])

pops, infodict= integrate.odeint(dCR_dt, RC0, t, full_output=True)
pops

#store in the dictionary
type(infodict)
infodict.keys()

infodict['message']

import matplotlib.pylab as p
f1 = p.figure()

p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')
p.show()# To display the figure

f1.savefig('../results/LV_model.pdf')

###The need for speed: profiling code??
#%run -p your_function_name  !!! to check the operating time


#Quick profiling with timeit

##############################################################################
# loops vs. list comprehensions: which is faster?
##############################################################################

iters = 1000000

import timeit

from profileme import my_squares as my_squares_loops

from profileme2 import my_squares as my_squares_lc

##############################################################################
# loops vs. the join method for strings: which is faster?
##############################################################################

mystring = "my string"

from profileme import my_join as my_join_join

from profileme2 import my_join as my_join



###### an example on calculating vectorization revisited

# calculate the loop-based function and a vevtorized function to check speeed

def loop_product(a,b):
    N = len(a)
    c = np.zeros(N)
    for i in range(N):
        c[i] = a[i] *b[i]
    return c

def vect_product(a,b):
    return np.multiply(a,b)

## comparing in the increasingly large randomly-generated 1D arrays

import numpy as np

    
import timeit

array_lengths = [1, 100, 10000, 1000000, 10000000]
t_loop = []
t_vect = []

for N in array_lengths:
    print(f"\nSet {N=}")
    #randomly generate our 1D arrays of length N
    a = np.random.rand(N)
    b = np.random.rand(N)
    
    # time loop_product 3 times and save the mean execution time.
    timer = timeit.repeat('loop_product(a, b)', globals=globals().copy(), number=3)
    t_loop.append(1000 * np.mean(timer))
    print(f"Loop method took {t_loop[-1]} ms on average.")
    
    # time vect_product 3 times and save the mean execution time.
    timer = timeit.repeat('vect_product(a, b)', globals=globals().copy(), number=3)
    t_vect.append(1000 * np.mean(timer))
    print(f"vectorized method took {t_vect[-1]} ms on average.")    
    
#then compare timings on a plot
import matplotlib.pylab as p

p.figure()
p.plot(array_lengths, t_loop, label="loop method")
p.plot(array_lengths, t_vect, label="vect method")
p.xlabel("arrat length")
p.ylabel("execution time(ms")
p.legend()
p.show()

#####Using Python to build workflows

### using subprocess
reset
import subprocess

## running processes
P = subprocess.Popen(["echo","I;m taking to tyou, bash!"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = P.communicate()
stderr
stdout
print(stdout.decode())
# the code: universal_newlines = True will allow to returned as encoded text UTF-8

#allow using bash command
P = subprocess.Popen(["ls", "-l"], stdout=subprocess.PIPE)
stdout, stderr = P.communicate()
print(stdout.decode())

#call python itself from bash?
P = subprocess.Popen(["python3", "boilerplate.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = P.communicate()
print(stdout.decode())

#to compile a latex document
subprocess.os.system("pdflatex yourlatexdoc.tex")


## running R

subprocess.Popen("Rscript --verbose Test.R > ../results/Test.Rout 2> ../results/Test_errFile.Rout", shell=True).wait()


#Handling directory and file paths

subprocess.os.path.join("directory", "subdirectory", "file")
MyPath = subprocess.os.path.join('directory', 'subdirectory', 'file')
MyPath
    
    
    
    
    
    