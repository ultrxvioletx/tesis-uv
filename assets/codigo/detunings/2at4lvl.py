import sys
import os
import time
import importlib
import argparse
import numpy as np
import math
from scipy.integrate import odeint
from sympy import var, I

# le decimos donde está openket para que lo lea
path_openket = "//home//ultrxioletx//openket"
if path_openket not in sys.path:
    sys.path.append(path_openket)

from openket.core.diracobject import Ket, Bra, Operator, AnnihilationOperator, CreationOperator
from openket.core.evolution import build_ode, gsl_main, sym2num, init_state
from openket.core.metrics import dag, comm, ptrace, trace, normalize, sub_qexpr, op2dict, qmatrix


parser = argparse.ArgumentParser()
parser.add_argument('--nmax', type=int, required=True)
parser.add_argument('--detuning', type=float, required=True)
parser.add_argument('--idx', type=int, required=True)
args = parser.parse_args()

nmax = args.nmax
detuning = args.detuning
idx = args.idx
filename = f"2at4lvl_d{idx}"


rho = Operator("R")
a = AnnihilationOperator("cavidad", nmax-1)
aa = CreationOperator("cavidad", nmax-1)

base_cavidad = [Ket(i,"cavidad") for i in range(nmax)] # base de Fock para la cavidad
base_atomo1 = [Ket(i,"atomo1") for i in range(4)] # base de niveles de energía del átomo: 0:g, 1:e, 2:s, 3:p
base_atomo2 = [Ket(i,"atomo2") for i in range(4)] # base de niveles de energía del átomo: 0:g, 1:e, 2:s, 3:p
base = [k1*k2*kc for k1 in base_atomo1 for k2 in base_atomo2 for kc in base_cavidad]
lenbase = len(base)


hbar = 1.0

# laseres
rabi_b = 1.0 # intesidad del bombeo
rabi_c = 2.0 # intesidad del control

# tasas de disipación
kappa = 1.0 # disipación de la cavidad
gamma_e = 1.0 # decaimiento espontáneo |e> -> |g> (referencia)
gamma_s = 0.01 # decaimiento espontáneo |s> -> |e>
gamma_12 = 0.0 # decaimiento de decaimiento colectivo

# acoplamientos
g = 1.0 # fuerza de acoplamiento átomo-cavidad
Omega_DR = 0.0 # fuerza del intercambio resonante |e,g> <-> |g,e|
Omega_EE = 1*(rabi_c**2 / gamma_e) # fuerza del intercambio/bloqueo |p,s> <-> |s,p|

# detunings
detuning_bc = detuning # detuning entre frecuencia del bombeo y frecuencia de la cavidad
detuning_ca = 0.0 # detuning entre frecuencia de la cavidad y frecuencia del átomo
detuning_al = 0.0 # detuning entre frecuencia del átomo y frecuencia del láser de control

tau = 50#1.0 / min(kappa, gamma_s, gamma_e)
nt = 1000
t0, t1 = 0, 1*tau
t = np.linspace(t0, t1, nt)

parametros = {
    'id': idx,
    't': [t0, t1, nt],
    'n': nmax,
    'g': g,
    'Omega_DR': Omega_DR,
    'Omega_EE': Omega_EE,
    'kappa': kappa,
    'gamma_s': gamma_s,
    'gamma_e': gamma_e,
    'gamma_12': gamma_12,
    'rabi_b': rabi_b,
    'rabi_c': rabi_c,
    'detuning_bc': detuning_bc,
    'detuning_ca': detuning_ca,
    'detuning_al': detuning_al
}
# print(parametros)

# operadores de transición atómicos
def sigma1(i,j): return Ket(i,"atomo1") * Bra(j,"atomo1")
def sigma2(i,j): return Ket(i,"atomo2") * Bra(j,"atomo2")

def H_A(sigma):
    E_g = 0
    E_e = hbar * (detuning_bc + detuning_ca)
    E_s = E_e + hbar * detuning_al
    E_p = E_s + hbar
    return  E_g*sigma(0,0) + E_e*sigma(1,1) + E_s*sigma(2,2) + E_p*sigma(3,3)

H_atomos = H_A(sigma1) + H_A(sigma2) # Hamiltoniano atómico
H_cavidad = hbar * detuning_bc * (aa*a + 1/2) #Hamiltoniano de la cavidad
H_bombeo = I*hbar * rabi_b * (aa - a) # Hamiltoniano del bombeo

def H_AL(sigma):
    H_atcon = -(hbar/2) * rabi_c * (sigma(1,2) + sigma(2,1)) # interacción átomo-control (RWA)
    H_atcav = hbar*g * (sigma(0,1)*aa + sigma(1,0)*a) # interacción átomo-cavidad (RWA)
    return H_atcon + H_atcav

H_atomo_laser_cavidad = H_AL(sigma1) + H_AL(sigma2) # Hamiltoniano de interacción átomo-láser

# interaccion de intercambio de energía para DR (e-g)
dr1 = sigma1(1,0) * sigma2(0,1) # at1 sube |g>->|e>, at2 baja |e>->|g>
dr2 = sigma1(0,1) * sigma2(1,0) # at1 baja |e>->|g>, at2 sube |g>->|e>
# interaccion de intercambio de energía para EE (s-p)
ee1 = sigma1(3,2) * sigma2(2,3) # at1 sube |e>->|s>, at2 baja |s>->|e>
ee2 = sigma1(2,3) * sigma2(3,2) # at1 baja |s>->|e>, at2 sube |e>->|s>

H_dr = hbar * Omega_DR * (dr1 + dr2) # Hamiltoniano de interacción entre los dipolos de la transición |g>->|e> (RWA)
H_ee = hbar * Omega_EE * (ee1 + ee2) # Hamiltoniano de interacción entre los dipolos de la transición |s>->|p> (RWA)

# Hamiltoniano total
H = H_cavidad + H_bombeo + H_atomos + H_atomo_laser_cavidad + H_dr + H_ee

# ecuación de movimiento de Lindblad
def L(A):
    if A == a:
        dagA = aa
    else:
        dagA = dag(A)
    return 2*A*rho*dagA - dagA*A*rho - rho*dagA*A

rdot = -I/hbar * comm(H,rho)
rdot += (kappa/2) * L(a) # disipación de la cavidad
# Átomo 1
rdot += (gamma_s/2) * L(sigma1(0,1)) # decaimiento |e>->|g>
rdot += (gamma_s/2) * L(sigma1(1,2)) # decaimiento |s>->|e>
# Átomo 2
rdot += (gamma_s/2) * L(sigma2(0,1)) # decaimiento |e>->|g>
rdot += (gamma_s/2) * L(sigma2(1,2)) # decaimiento |s>->|e>
# Átomos 1 y 2
y = sigma1(0,1) + sigma2(0,1)
rdot += (gamma_12/2) * L(y) # decaimiento colectivo

build_ode(
    rho=rho,
    rdot=rdot,
    basis=base,
    filetype="GSL",
    filename=f"func{filename}.c",
    dictname=f"dic{filename}.py"
)

# leer módulo dic.py
dictname=f"dic{filename}"
if dictname in sys.modules:
    del sys.modules[dictname]
modulo = importlib.import_module(dictname)
modulo = importlib.reload(modulo)
dic = modulo.dic

# convertir condiciones iniciales simbólicas -> numéricas
ket0 = Ket(0,"cavidad") * Ket(0,"atomo1") * Ket(0,"atomo2")
rho0 = ket0*dag(ket0)
init_conditions = init_state(rho=rho, rho0=rho0, basis=base, dic=dic)

# solución numérica (GSL)
symbexprs = []
def label(i): return ["g", "e", "s", "p"][i]
labels = []
# probabilidades de los 16 estados atómicos posibles |i,j> con i,j in {g,e,s,p}
for i in range(4):
    for j in range(4):
        proyector = sigma1(i,i) * sigma2(j,j)
        proyector_symb = sub_qexpr(qexpr=trace(rho * proyector, basis=base), dic=dic)
        symbexprs.append(proyector_symb)
        labels.append(f"{label(i)}{label(j)}")
parametros["probs_label"] = labels

# valores esperados
N = aa * a # operador de número
N_symb = sub_qexpr(qexpr=trace(rho * N, basis=base), dic=dic)
symbexprs.append(N_symb)

gsl_main(
    odefile=f"func{filename}.c",
    y0=init_conditions,
    tspan=(t0,t1),
    step=nt,
    outfile=f"{filename}",
    datafile=f"{filename}",
    symbexprs=symbexprs,
    options={"output_format": "hdf5"},
    metadata=parametros
)
