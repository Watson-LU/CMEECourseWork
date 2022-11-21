""" this code run compare two LV model and test their running times"""
import numpy as np
import scipy.integrate as integrate

def dCR_dt1(pops1, t=0):
    """ normal LV model """
    R = pops1[0]
    C = pops1[1]
    dRdt = r * R - a * R * C 
    dCdt = -z * C + e * a * R * C
    
    return np.array([dRdt, dCdt])


def dCR_dt2(pops2, t=0):
    """ LV model with recource population"""
    R = pops2[0]
    C = pops2[1]
    dRdt = r * R*(1-R/K) - a * R * C 
    dCdt = -z * C + e * a * R * C
    
    return np.array([dRdt, dCdt])

""" setted constant parameters"""
r = 1
a = 0.1
z = 1.5
e = 0.75
K= 100

""" time steps"""
t = np.linspace(0,300, 1000)

R0 = 10
C0 = 5 
RC0 = np.array([R0, C0])

""" ode functions setted"""
pops1, infodict = integrate.odeint(dCR_dt1, RC0, t, full_output=True)
pops2, infodict = integrate.odeint(dCR_dt2, RC0, t, full_output=True)

pops1
pops2

""" use command to test the running time and compare those two models"""
%timeit (dCR_dt1(pops1,t=0))
%timeit (dCR_dt2(pops2,t=0))


#the LV1 is less time consume than LV2 since LV2 calculate more complex

#two methods to spped up the time
# one is pre-allocate the list, or change the list with setted arrays.
# another one is setting the appropriate time and time steps to find the less time consume.

























