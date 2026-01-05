from openket import *
from scipy.integrate import odeint
from sympy import I
import numpy as np
import matplotlib.pyplot as plt
import math

hbar = 1.
omega = 1.
k = 0.01
m = 1

n = 5
base = [Ket(i,"campo") for i in range(n)]
rho = Operator("R")
a = AnnihilationOperator("campo",n-1)
aa = CreationOperator("campo",n-1)
H = hbar*omega*(aa*a + 1/2)

rdot = -I/hbar * Commutator(H,rho) + (k/2)*(2*a*rho*aa - aa*a*rho - rho*aa*a)
# Qeq(R=rho, Rdot=rdot, basis=base, file="Scipy", filename="~/Documents/GitHub/ejemplos-andrea/openket/func")
from func import dic,f

#condiciones iniciales: estados coherentes
alpha = 1
state_alpha = 0
for i in range(n):
        state_alpha = state_alpha + ((alpha**2) / math.sqrt(math.factorial(i))) * Ket(i,"campo")
state_alpha = np.exp(-(np.abs(alpha)**2)/2) * state_alpha
rho0 = state_alpha * Adj(state_alpha)

init_conditions = yinit(R=rho, R0=rho0, basis=base, dic=dic)
t = np.linspace(0 ,15 ,100)
solution = odeint(f, init_conditions, t)

diagonal_indices = [2*k for k in range(n**2)]
estados = ['<0_campo|R|0_campo>','<1_campo|R|1_campo>','<2_campo|R|2_campo>','<3_campo|R|3_campo>','<4_campo|R|4_campo>']
for i in diagonal_indices:
        probabilidad = [*dic][int(i / 2)]
        if probabilidad in estados:
                plt.plot(t, solution[:, i], label=probabilidad)
plt.xlabel('t')
plt.ylabel('p(t)')
plt.title('Probabilidad de encontrar al sistema en el estado a través del tiempo')
plt.grid(True)
plt.legend()
plt.show()