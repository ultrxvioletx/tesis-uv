import sys
import os
import time
import importlib
import numpy as np
import math
from scipy.integrate import odeint
from sympy import var, I, sqrt, sympify, Rational
from auxiliares import create_file, exec_c

itotal = time.time()

# le decimos donde está openket para que lo lea
path_openket = "//home//ultrxioletx//openket"
if path_openket not in sys.path:
    sys.path.append(path_openket)
# elimina el caché de func.py para que no lea los datos anteriores
if 'func' in sys.modules:
    del sys.modules['func']
if os.path.exists('func.py'):
    os.remove('func.py')

from openket.core.diracobject import Ket, Bra, Operator, AnnihilationOperator, CreationOperator
from openket.core.evolution import build_ode, gsl_main, sym2num, init_state
from openket.core.metrics import dag, comm, ptrace, trace, normalize, sub_qexpr, op2dict, qmatrix



nmax = 30 # truncación del espacio de Hilbert (número de estados de Fock)
dt = 1000
t0, t1 = 0, 15
t = np.linspace(t0, t1, dt)

base_cavidad = [Ket(i,"cavidad") for i in range(nmax)] # base de Fock para la cavidad
base_atomo = [Ket(0,"atomo"), Ket(1,"atomo")] # base de niveles de energía del átomo: 0=ground, 1=excited
base = [ka*kc for ka in base_atomo for kc in base_cavidad]
lenbase = len(base)

sigma_ge = Ket(0,"atomo") * Bra(1,"atomo") # operador de bajada átomico
sigma_eg = Ket(1,"atomo") * Bra(0,"atomo") # operador de subida atómico
sigma_gg = Ket(0,"atomo") * Bra(0,"atomo") # operador de nivel base
sigma_ee = Ket(1,"atomo") * Bra(1,"atomo") # operador de nivel excitado

hbar = 1.
g = 1.0 # constante de acoplamiento, mide qué tan fuerte es la interacción entre el átomo y un fotón en la cavidad
kappa = 1.0 # tasa de disipación de la cavidad
gamma = 0.5 # tasa de decaimiento espontáneo del átomo
rabi_b = 1.5 # intesidad del bombeo
rabi_l = 1.0 # intesidad del láser, proporcional a la amplitud del campo eléctrico del láser de control
detuning_bc = 0. # detuning entre frecuencia del bombeo y frecuencia de la cavidad
detuning_ca = 0. # detuning entre frecuencia de la cavidad y frecuencia del átomo
detuning_al = 0. # detuning entre frecuencia del átomo y frecuencia del láser de control

rho = Operator("R")
a = AnnihilationOperator("cavidad", nmax-1)
aa = CreationOperator("cavidad", nmax-1)

parametros = {
    'g': g,
    'kappa': kappa,
    'gamma': gamma,
    'rabi_b': rabi_b,
    'rabi_l': rabi_l,
    'detuning_bc': detuning_bc,
    'detuning_ca': detuning_ca,
    'detuning_al': detuning_al,
}
print(parametros)
H_cavidad = hbar * detuning_bc * (aa*a + 1/2) # Hamiltoniano del oscilador armónico cuántico (cavidad)
H_bombeo = I*hbar * rabi_b * (aa - a) # Hamiltoniano del bombeo
H_atomo = (hbar/2) * detuning_al * (sigma_ee - sigma_gg) # Hamiltoniano del átomo libre (RWA)
H_atomo_laser = -(hbar/2) * rabi_l * (sigma_ge + sigma_eg) # Hamiltoniano de interacción átomo-láser (RWA)
H_atomo_cavidad = hbar * g * (aa*sigma_ge + a*sigma_eg) # Hamiltoniano de la interacción átomo-cavidad (jaynes-cummings) (RWA)

# Hamiltoniano total
H = H_cavidad + H_bombeo + H_atomo + H_atomo_laser + H_atomo_cavidad
# ecuación de movimiento de Lindblad
rdot = I/hbar * comm(H,rho) \
        + (kappa/2)*(2*a*rho*aa - aa*a*rho - rho*aa*a) \
        + (gamma/2)*(2*sigma_ge*rho*sigma_eg - sigma_eg*sigma_ge*rho - rho*sigma_eg*sigma_ge)

filename = f"func(n={nmax})"
ilocal = time.time()
build_ode(rho=rho, rdot=rdot, basis=base, filetype="Scipy", filename=f"{filename}.py")
flocal = time.time()
print(f"create func.py: {flocal-ilocal} s")

"""
ilocal = time.time()
build_ode(rho=rho, rdot=rdot, basis=base, filetype="GSL", filename=f"{filename}.c")
flocal = time.time()
print(f"create func.c: {flocal-ilocal} s")
"""

# leer módulo func.py
spec = importlib.util.spec_from_file_location("func", f"./{filename}.py")
func = importlib.util.module_from_spec(spec)
spec.loader.exec_module(func)
dic, f, = func.dic, func.f

# convertir condiciones iniciales simbólicas -> numéricas
nfotones0 = 0 # número promedio de fotones iniciales dentro de la cavidad
nestado0 = 0 # estado inicial del átomo
ket0 = Ket(nfotones0,"cavidad") * Ket(nestado0,"atomo")
rho0 = ket0*dag(ket0)
init_conditions = init_state(rho=rho, rho0=rho0, basis=base, dic=dic)

# solución numérica
# odeint
ilocal = time.time()
rho_solution = odeint(f, init_conditions, t)
flocal = time.time()
print(f"run odeint: {flocal-ilocal} s")
# gsl
"""
ilocal = time.time()
gsl_main(odefile=f"{filename}.c", y0=init_conditions, tspan=(t0,t1), step=(t1-t0)/dt, outfile="funcMain.c")
resultado = exec_c("funcMain.c")
flocal = time.time()
print(f"run funcMain.c: {flocal-ilocal} s")
print(resultado)
"""


# Probabilidad
ilocal = time.time()
probs = []
for i in range(len(base_atomo)):
    proyector = Ket(i,"atomo") * Bra(i,"atomo")
    proyector_symb = sub_qexpr(qexpr=trace(rho * proyector, basis=base), dic=dic)
    proyector_expect = sym2num(sol=rho_solution, symbexpr=proyector_symb)
    probs.append(proyector_expect)
probs = np.array(probs)
flocal = time.time()
print(f"calcular probabilidad: {flocal-ilocal} s")

# Valores esperados numéricos
ilocal = time.time()
# definición simbólica de los observables
N = aa * a # operador de número
X = (1/sqrt(2)) * (a+aa) # cuadratura X adimensional
P = (I*(aa-a)) / sqrt(2) # cuadratura P adimensional

N_symb = sub_qexpr(qexpr=trace(rho * N, basis=base), dic=dic)
X_symb = sub_qexpr(qexpr=trace(rho * X, basis=base), dic=dic)
P_symb = sub_qexpr(qexpr=trace(rho * P, basis=base), dic=dic)

N_expect = sym2num(sol=rho_solution, symbexpr=N_symb)
X_expect = sym2num(sol=rho_solution, symbexpr=X_symb)
P_expect = sym2num(sol=rho_solution, symbexpr=P_symb)
flocal = time.time()
print(f"calcular valores esperados: {flocal-ilocal} s")

create_file(filename=f'cavidad+atomo+bombeo+control+k{"y" if gamma>0 else ""}.csv', t=t, probs=probs, expects=(N_expect,X_expect,P_expect), params=parametros)

# elimina el caché de func.py para que no lea los datos anteriores
if 'func' in sys.modules:
    del sys.modules['func']

ftotal = time.time()
print(f"Total: {ftotal-itotal} s")