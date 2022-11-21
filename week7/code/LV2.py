""" This module is set to model the LV model with resource population
    by ODE model"""
import numpy as np
import scipy.integrate as integrate
import matplotlib.pylab as p
from matplotlib.backends.backend_pdf import PdfPages
import sys

def dCR_dt(pops, t=0):
    """ the adjusted LV model with resource population"""
    R = pops[0]
    C = pops[1]
    dRdt = r * R*(1-R/K) - a * R * C 
    dCdt = -z * C + e * a * R * C
    
    return np.array([dRdt, dCdt])

""" parameter was set by testing people outside the script"""
r = float(sys.argv[1])
a = float(sys.argv[2])
z = float(sys.argv[3])
e = float(sys.argv[4])
K= 100

""" normal fixed time steps"""
t = np.linspace(0,300, 1000)

""" initlal setting for r and c"""
R0 = 10
C0 = 5 
RC0 = np.array([R0, C0])

""" ODE function """
pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)
pops


def main(argv):
    """ use def and main argv to include the global variables into the
        figure plotting"""
    f1 = p.figure()
    p.plot(t, pops[:,0], 'g-', label='Resource density') 
    p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
    p.grid()
    p.legend(loc='best')
    p.text(200,12, "r={}".format(argv[1]))   # use the .format(argv[])to grab outside variables into this area
    p.text(200,11, "a={}".format(argv[2]))
    p.text(200,10, "z={}".format(argv[3]))
    p.text(200,9, "e={}".format(argv[4]))
    p.text(200,8, "K = 100")
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer-Resource population dynamics')
    
    """ normal related figure"""
    f2 = p.figure()
    p.plot(pops[:,0], pops[:,1] ,'r-' )# 
    p.grid()
    p.xlabel("Consumer density")
    p.ylabel("Resource density")
    p.title("Consumer-Resource population dynamics")
    """ add two figures into one pdf """
    pp = PdfPages("../results/lv2.pdf")
    pp.savefig(f1)
    pp.savefig(f2)
    pp.close()


if (__name__ == "__main__"):
    """ setting for the local loop"""
    status = main(sys.argv)
    sys.exit(status)
    
#just in the pyhon evriment coed with: run LV2.py argv1 argv2 argv3 argv4
#argv recommanded as: 1 0.1 1.0 1.5
    
    