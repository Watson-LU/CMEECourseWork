# Project name: Week7 python2 practice 
## Brief Description
It's for the week7 python2 practices 

There are total Three practices in this section.

The first one is to create the LV model figure with a new consumer VS resource graph together in one pdf file.

The second task is firstly write the model of adjusted by recource population. then run a py file to compare lv1 model and lv2 model's operating time.

The third assignment is to apply Rscript into python environment.

## Languages
Generally use bash and python3 that work in the both terminal and VSC.


## Dependencies and installation
Under this paractice, more modules are required in python.
1. the module numpy.
```python
import numpy as np
```
2. the module integrate
```python
import scipy.integrate as integrate
```
3. the module matplotlib
```python
import matplotlib.pylab as p
```
4. the module PdfPages
```python
from matplotlib.backends.backend_pdf import PdfPages
```
5. the module sys
```python
import sys
```
6. the module subprocess
```python
import subprocess
```

## Project stucture and Usage

1. In the first practice, the orignal LV model is set as :
```python
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)
```
then, the two figure is drawn and set into one pdf file:
```python
f1 = p.figure()
f2 = p.figure()
pp = PdfPages("../results/lv1.pdf")
pp.savefig(f1)
pp.savefig(f2)
```

2. In this practice, adjusted LV model is definded as below:
```python
def dCR_dt(pops, t=0):
    """ the adjusted LV model with resource population"""
    R = pops[0]
    C = pops[1]
    dRdt = r * R*(1-R/K) - a * R * C 
    dCdt = -z * C + e * a * R * C
    
    return np.array([dRdt, dCdt]) 
```
the parameter was set by the arguments outside the script:
```python
r = float(sys.argv[1])
a = float(sys.argv[2])
z = float(sys.argv[3])
e = float(sys.argv[4])
```

3. In the last practice, the goal is to runing R script in the python envoronment by applying subprocess module.
```python
import subprocess
p = subprocess.Popen(["Rscript", "fmr.R"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr = p.communicate()
print(stdout.decode())
```


Finished

## Author name and Contact
Author name: Jintao Lu

Contact: jl8722@ic.ac.uk
