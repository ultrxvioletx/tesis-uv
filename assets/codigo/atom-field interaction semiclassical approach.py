from openket import *
from scipy.integrate import odeint
from numpy import linspace
from sympy import var, I
import matplotlib.pyplot as plt

h = 1
E0 = 1
dab = 2

rabi = 1/2 #dab*E0/h #frecuencia de Rabi
delta = 1 #detuning 
base = [Ket(0), Ket(1)]
rho = Operator("rho")

H = h/2 * (-delta*Ket(0)*Bra(0) + -rabi*Ket(0)*Bra(1) + -rabi*Ket(1)*Bra(0) + delta*Ket(1)*Bra(1))
rdot = -(I/h)*comm(H, rho)

y0 = [1,0, 0,0, 0,0, 0,0]
t = linspace(0,10,1000)

solution = build_ode(rho=rho, rdot=rdot, basis=base, y0=y0, t=t, filetype=None)
print(solution.shape)
plt.plot(t, solution[:,0], label="⟨0|rho|0⟩")
plt.plot(t, solution[:,6], label="⟨1|rho|1⟩")
plt.xlabel('tiempo (s)')
plt.ylabel('Probabilidad P(t)')
plt.legend()
plt.title('Oscilaciones de Rabi en átomo de dos niveles, Detuning='+str(delta))
plt.grid(True)
plt.show()