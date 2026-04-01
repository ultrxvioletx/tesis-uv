##################################################
# Quantic armonic oscillator dissipation.py
# Andrea Rodríguez
##################################################


from openket import *
from scipy.integrate import odeint
import sympy as sp
import numpy as np
import matplotlib.pyplot as plt
import math

hbar = 1.
omega = 1.
kappa = 0.1
m = 1

n = 5
base = [Ket(i,"campo") for i in range(n)]
rho = Operator("R")
a = AnnihilationOperator("campo",n-1)
aa = CreationOperator("campo",n-1)
H = hbar*omega*(aa*a + 1/2)

rdot = -sp.I/hbar * comm(H,rho) + (kappa/2)*(2*a*rho*aa - aa*a*rho - rho*aa*a)

#condiciones iniciales: estados coherentes
alpha = 1
state_alpha = 0
for i in range(n):
        state_alpha = state_alpha + ((alpha**2) / math.sqrt(math.factorial(i))) * Ket(i,"campo")
state_alpha = np.exp(-(np.abs(alpha)**2)/2) * state_alpha
rho0 = state_alpha * dag(state_alpha)

build_ode(rho=rho, rdot=rdot, basis=base, filetype="Scipy", filename="func.py")
from func import dic,f
init_conditions = init_state(rho=rho, rho0=rho0, basis=base, dic=dic)
t = np.linspace(0,50,500)
solution = odeint(f, init_conditions, t)

N = aa * a
x = np.sqrt(hbar/(2*m*omega)) * (a + aa)
p = sp.I * np.sqrt(hbar*m*omega/2) * (aa - a)

N_symb = sub_qexpr(qexpr=trace(rho * N, basis=base), dic=dic)
x_symb = sub_qexpr(qexpr=trace(rho * x, basis=base), dic=dic)
p_symb = sub_qexpr(qexpr=trace(rho * p, basis=base), dic=dic)


N_expect = sym2num(sol=solution, symbexpr=N_symb)
x_expect = sym2num(sol=solution, symbexpr=x_symb)
p_expect = sym2num(sol=solution, symbexpr=p_symb)


fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(10, 8), sharex=True)
# Subplot 1: <N>
ax1.plot(t, np.real(N_expect), 'r-', label='<N>')
ax1.set_ylabel('Photon number')
ax1.legend()
ax1.grid(True)
# Subplot 2: <X> and <P>
ax2.plot(t, np.real(x_expect), 'b-', label='<X>')
ax2.plot(t, np.real(p_expect), 'g--', label='<P>')
ax2.set_xlabel('Time (s)')
ax2.set_ylabel('Expectation value')
ax2.legend()
ax2.grid(True)

plt.suptitle('Dynamics of a Dissipative Quantum Harmonic Oscillator')
plt.tight_layout()
plt.show()