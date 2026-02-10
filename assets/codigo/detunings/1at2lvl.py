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
detuning_al = args.detuning
idx = args.idx
filename = f"1at2lvl_d{idx}"


rho = Operator("R")
a = AnnihilationOperator("cavidad", nmax-1)
aa = CreationOperator("cavidad", nmax-1)

base_cavidad = [Ket(i,"cavidad") for i in range(nmax)] # base de Fock para la cavidad
base_atomo = [Ket(0,"atomo"), Ket(1,"atomo")] # base de niveles de energía del átomo: 0=ground, 1=excited
base = [ka*kc for ka in base_atomo for kc in base_cavidad]
lenbase = len(base)

sigma_ge = Ket(0,"atomo") * Bra(1,"atomo") # operador de bajada átomico
sigma_eg = Ket(1,"atomo") * Bra(0,"atomo") # operador de subida atómico
sigma_gg = Ket(0,"atomo") * Bra(0,"atomo") # operador de nivel base
sigma_ee = Ket(1,"atomo") * Bra(1,"atomo") # operador de nivel excitado

hbar = 1.
# cavidad
g = 2.0 # fuerza de acoplamiento átomo-cavidad
kappa = 1.0 # tasa de disipación de la cavidad
# atomo
gamma = 0.1 # tasa de decaimiento espontáneo del átomo
# laseres
rabi_b = 0.7 # intesidad del bombeo
rabi_l = 0.1 # intesidad del láser, proporcional a la amplitud del campo eléctrico del láser de control
# detunings
detuning_bc = 0. # detuning entre frecuencia del bombeo y frecuencia de la cavidad
detuning_ca = 0. # detuning entre frecuencia de la cavidad y frecuencia del átomo
# detuning_al = 0. # detuning entre frecuencia del átomo y frecuencia del láser de control

tau = 1.0 / min(kappa, gamma)
nt = 1000
t0, t1 = 0, 5*tau
t = np.linspace(t0, t1, nt)

parametros = {
    'id': idx,
    't': [t0, t1, nt],
    'n': nmax,
    'g': g,
    'kappa': kappa,
    'gamma': gamma,
    'rabi_b': rabi_b,
    'rabi_l': rabi_l,
    'detuning_bc': detuning_bc,
    'detuning_ca': detuning_ca,
    'detuning_al': detuning_al
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

print("building ODE...")
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
nfotones0 = 0 # número promedio de fotones iniciales dentro de la cavidad
nestado0 = 0 # estado inicial del átomo
ket0 = Ket(nfotones0,"cavidad") * Ket(nestado0,"atomo")
rho0 = ket0*dag(ket0)
print("condiciones iniciales...")
init_conditions = init_state(rho=rho, rho0=rho0, basis=base, dic=dic)

# solución numérica (GSL)
symbexprs = []
labels = []
# probabilidades
for i in range(2):
    proyector = Ket(i,"atomo")*Bra(i,"atomo")
    proyector_symb = sub_qexpr(qexpr=trace(rho * proyector, basis=base), dic=dic)
    symbexprs.append(proyector_symb)
    labels.append("g" if i == 0 else "e") # g=ground=0, e=excited=1
parametros["probs_label"] = labels
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

print("finalizado")