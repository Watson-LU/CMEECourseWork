""" this work is for checking the relationship between
    Resource density with consumer"""
import numpy as np
import scipy.integrate as integrate
import matplotlib.pylab as p
from matplotlib.backends.backend_pdf import PdfPages


def dCR_dt(pops, t=0):
    """ the function that defined LV model"""
    R = pops[0]
    C = pops[1]
    dRdt = r * R - a * R * C 
    dCdt = -z * C + e * a * R * C
    
    return np.array([dRdt, dCdt])

""" the constant parameters that given here"""
r = 1.
a = 0.1 
z = 1.5
e = 0.75

""" time steps"""
t = np.linspace(0, 15, 1000)

""" initial setting values"""
R0 = 10
C0 = 5 
RC0 = np.array([R0, C0])

""" to operate with the ode function and store results into dictionaries"""
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)
pops

""" to create the original figure """
f1 = p.figure()
p.plot(t, pops[:,0], 'g-', label='Resource density') # 
p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
p.grid()
p.legend(loc='best')
p.xlabel('Time')
p.ylabel('Population density')
p.title('Consumer-Resource population dynamics')


""" to create the consumer vs resource"""
f2 = p.figure()
p.plot(pops[:,0], pops[:,1] ,'r-' )# 
p.grid()
p.xlabel("Consumer density")
p.ylabel("Resource density")
p.title("Consumer-Resource population dynamics")

""" create two figures into a pdf and output"""
pp = PdfPages("../results/lv1.pdf")
pp.savefig(f1)
pp.savefig(f2)
pp.close()

