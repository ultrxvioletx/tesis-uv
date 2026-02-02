import sys
import os
import time
import importlib
import numpy as np
import math
from scipy.integrate import odeint
from sympy import var, I

# extraemos el nombre del archivo actual
current_file = __file__
filename = os.path.splitext(os.path.basename(current_file))[0]
# le decimos donde está openket para que lo lea
path_openket = "//home//ultrxioletx//openket"
if path_openket not in sys.path:
    sys.path.append(path_openket)

from openket.core.diracobject import Ket, Bra, Operator, AnnihilationOperator, CreationOperator
from openket.core.evolution import build_ode, gsl_main, sym2num, init_state
from openket.core.metrics import dag, comm, ptrace, trace, normalize, sub_qexpr, op2dict, qmatrix


nmax = 5 # truncación del espacio de Hilbert (número de estados de Fock)
if len(sys.argv) > 1:
    nmax = int(sys.argv[1])
nt = 1000
t0, t1 = 0, 15
t = np.linspace(t0, t1, nt)

rho = Operator("R")
a = AnnihilationOperator("cavidad", nmax-1)
aa = CreationOperator("cavidad", nmax-1)

base_cavidad = [Ket(i,"cavidad") for i in range(nmax)] # base de Fock para la cavidad
base_atomo1 = [Ket(i,"atomo1") for i in range(2)] # base de niveles de energía del átomo: 0=ground, 1=excited
base_atomo2 = [Ket(i,"atomo2") for i in range(2)] # base de niveles de energía del átomo: 0=ground, 1=excited
base = [k1*k2*kc for k1 in base_atomo1 for k2 in base_atomo2 for kc in base_cavidad]
lenbase = len(base)

# operadores para el átomo 1
sigma_ge1 = Ket(0,"atomo1") * Bra(1,"atomo1") # operador de bajada átomico
sigma_eg1 = Ket(1,"atomo1") * Bra(0,"atomo1") # operador de subida atómico
sigma_gg1 = Ket(0,"atomo1") * Bra(0,"atomo1") # operador de nivel base
sigma_ee1 = Ket(1,"atomo1") * Bra(1,"atomo1") # operador de nivel excitado

# operadores para el átomo 2
sigma_ge2 = Ket(0,"atomo2") * Bra(1,"atomo2") # operador de bajada átomico
sigma_eg2 = Ket(1,"atomo2") * Bra(0,"atomo2") # operador de subida atómico
sigma_gg2 = Ket(0,"atomo2") * Bra(0,"atomo2") # operador de nivel base
sigma_ee2 = Ket(1,"atomo2") * Bra(1,"atomo2") # operador de nivel excitado

J_menos = sigma_ge1 + sigma_ge2
J_mas = sigma_eg1 + sigma_eg2

hbar = 1.
# cavidad
g = 2.0 # fuerza de acoplamiento átomo-cavidad
kappa = 1.0 # tasa de disipación de la cavidad
# atomos
Omega12 = 0.2 # fuerza de acoplamiento dipolo-dipolo
gamma = 0.1 # tasa de decaimiento espontáneo del átomo
# laseres
rabi_b = 0.7 # intesidad del bombeo
rabi_l = 0.1 # intesidad del láser, proporcional a la amplitud del campo eléctrico del láser de control
# detunings
detuning_bc = 0. # detuning entre frecuencia del bombeo y frecuencia de la cavidad
detuning_ca = 0. # detuning entre frecuencia de la cavidad y frecuencia del átomo
detuning_al = 0. # detuning entre frecuencia del átomo y frecuencia del láser de control

parametros = {
    'n': nmax,
    'g': g,
    'kappa': kappa,
    'gamma': gamma,
    'Omega12': Omega12,
    'rabi_b': rabi_b,
    'rabi_l': rabi_l,
    'detuning_bc': detuning_bc,
    'detuning_ca': detuning_ca,
    'detuning_al': detuning_al
}
print(parametros)

H_cavidad = hbar * detuning_bc * (aa*a + 1/2) # Hamiltoniano del oscilador armónico cuántico (cavidad)
H_bombeo = I*hbar * rabi_b * (aa - a) # Hamiltoniano del bombeo

H_atomo1 = (hbar/2) * detuning_al * (sigma_ee1 - sigma_gg1) # Hamiltoniano del átomo libre (RWA)
H_atomo2 = (hbar/2) * detuning_al * (sigma_ee2 - sigma_gg2) # Hamiltoniano del átomo libre (RWA)
H_atomo = H_atomo1 + H_atomo2 # Hamiltoniano atómico total
H_dipolar = hbar * Omega12 * (sigma_eg1*sigma_ge2 + sigma_ge1*sigma_eg2) # Hamiltoniano de interacción dipolo-dipolo entre átomos

H_atomo_cavidad = hbar * g * (aa*J_menos + a*J_mas) # Hamiltoniano de la interacción átomos-cavidad (tavis-cummings) (RWA)
H_atomo_laser = -(hbar/2) * rabi_l * (J_menos + J_mas) # Hamiltoniano de interacción átomo-láser (RWA)

# Hamiltoniano total
H = H_cavidad + H_bombeo + H_atomo + H_dipolar + H_atomo_laser + H_atomo_cavidad
# ecuación de movimiento de Lindblad
rdot = I/hbar * comm(H,rho) \
        + (kappa/2)*(2*a*rho*aa - aa*a*rho - rho*aa*a) \
        + (gamma/2)*(2*sigma_ge1*rho*sigma_eg1 - sigma_eg1*sigma_ge1*rho - rho*sigma_eg1*sigma_ge1) \
        + (gamma/2)*(2*sigma_ge2*rho*sigma_eg2 - sigma_eg2*sigma_ge2*rho - rho*sigma_eg2*sigma_ge2)

itime = time.time()
print("building ODE...")
build_ode(
    rho=rho,
    rdot=rdot,
    basis=base,
    filetype="GSL",
    filename=f"func.c"
)
ftime = time.time()
print(f"{ftime - itime} s")

# leer módulo dic.py
import dic
importlib.reload(dic)
from dic import dic

# convertir condiciones iniciales simbólicas -> numéricas
nfotones0 = 0 # número promedio de fotones iniciales dentro de la cavidad
nestado0 = 0 # estado inicial del átomo
ket0 = Ket(nfotones0,"cavidad") * Ket(nestado0,"atomo1") * Ket(nestado0,"atomo2")
rho0 = ket0*dag(ket0)
print("condiciones iniciales...")
init_conditions = init_state(rho=rho, rho0=rho0, basis=base, dic=dic)

# solución numérica (GSL)
symbexprs = []
# probabilidades
ops_atomo1 = [sigma_gg1, sigma_ee1]
ops_atomo2 = [sigma_gg2, sigma_ee2]
for i in range(2):
    for j in range(2):
        proyector = ops_atomo1[i] * ops_atomo2[j]
        proyector_symb = sub_qexpr(qexpr=trace(rho * proyector, basis=base), dic=dic)
        symbexprs.append(proyector_symb) # el orden es: P(gg), P(ge), P(eg), P(ee)
# valores esperados
N = aa * a # operador de número
X = (1/np.sqrt(2)) * (a+aa) # cuadratura X adimensional
P = (1/np.sqrt(2)) * I*(aa-a) # cuadratura P adimensional
N_symb = sub_qexpr(qexpr=trace(rho * N, basis=base), dic=dic)
X_symb = sub_qexpr(qexpr=trace(rho * X, basis=base), dic=dic)
P_symb = sub_qexpr(qexpr=trace(rho * P, basis=base), dic=dic)
symbexprs.extend([N_symb, X_symb, P_symb]) #agregar al final

print("generando archivo c...")
gsl_main(
    odefile=f"func.c",
    y0=init_conditions,
    tspan=(t0,t1),
    step=nt,
    outfile=f"{filename}",
    datafile=f"{filename}",
    symbexprs=symbexprs,
    options={"output_format": "hdf5"},
    metadata=parametros
)

print("finalizado")