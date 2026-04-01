import sys
import os
import time
import importlib
import itertools
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

Nat = 3 # número de átomos de dos niveles
nmax = 10 # truncación del espacio de Hilbert (número de estados de Fock)
if len(sys.argv) > 1:
    Nat = int(sys.argv[1])
    nmax = int(sys.argv[2])
    filename = f"{Nat}at4lvl{nmax}f"
print(f"nmax={nmax}, Nat={Nat}")
nt = 1000
t0, t1 = 0, 15
t = np.linspace(t0, t1, nt)

hbar = 1.
# cavidad
g = 2.0 # fuerza de acoplamiento átomo-cavidad
kappa = 1.0 # tasa de disipación de la cavidad
# atomos
Omega12 = 0.2 # fuerza de acoplamiento dipolo-dipolo
gamma_eg = 0.1 # tasa de decaimiento espontáneo de los niveles |e> -> |g>
gamma_se = 0.1 # tasa de decaimiento espontáneo de los niveles |s> -> |e>
gamma_ps = 0.1 # tasa de decaimiento espontáneo de los niveles |p> -> |s>
# laseres
rabi_b = 0.7 # intesidad del bombeo, acopla |g> con |e>
rabi_l = 2.0 # intesidad del láser, acopla |e> con |s>
# detunings
detuning_bc = 0. # detuning entre frecuencia del bombeo y frecuencia de la cavidad
detuning_ca = 0. # detuning entre frecuencia de la cavidad y frecuencia del átomo
detuning_al = 0. # detuning entre frecuencia del átomo y frecuencia del láser de control |e> -> |s>
parametros = {
    'n': nmax,
    'g': g,
    'kappa': kappa,
    'gamma_eg': gamma_eg,
    'gamma_se': gamma_se,
    'gamma_ps': gamma_ps,
    'Omega12': Omega12,
    'rabi_b': rabi_b,
    'rabi_l': rabi_l,
    'detuning_bc': detuning_bc,
    'detuning_ca': detuning_ca,
    'detuning_al': detuning_al
}
print(parametros)

rho = Operator("R")
a = AnnihilationOperator("cavidad", nmax-1)
aa = CreationOperator("cavidad", nmax-1)

base_cavidad = [Ket(i,"cavidad") for i in range(nmax)] # base de Fock para la cavidad
bases_atomos = [ [Ket(i, f"atomo{j+1}") for i in range(4)] for j in range(Nat) ] # bases de 2 niveles de energía de los átomos: 0=ground, 1=excited
base = base_cavidad
for base_atomo in bases_atomos:
    base = [kb*ka for ka in base_atomo for kb in base]
lenbase = len(base)

sigmas = [{} for _ in range(Nat)]
for j in range(Nat):
    label = f"atomo{j+1}"
    for i in range(4):
        for k in range(4):
            sigmas[j][(i, k)] = Ket(i,label)*Bra(k,label)

H_atomo = 0 # Hamiltoniano del átomo libre (RWA)
H_dipolar = 0 # Hamiltoniano de interacción dipolo-dipolo entre átomos
H_atomo_cavidad = 0 # Hamiltoniano de la interacción átomos-cavidad (tavis-cummings) (RWA), acopla |g> <-> |e>
H_atomo_laser = 0 # Hamiltoniano de interacción átomo-láser (RWA), acopla |e> <-> |s>
rdot_gamma = 0 # término de decaimiento de los átomos para Lindblad

# suma de contribuciones de cada átomo
for j in range(Nat):
    sigmas_gg = sigmas[j][(0,0)]
    sigmas_ee = sigmas[j][(1,1)]
    sigmas_ss = sigmas[j][(2,2)]
    sigmas_ge = sigmas[j][(0,1)] #|g><e|
    sigmas_eg = sigmas[j][(1,0)] #|e><g|
    sigmas_es = sigmas[j][(1,2)] #|e><s|
    sigmas_se = sigmas[j][(2,1)] #|s><e|
    sigmas_sp = sigmas[j][(2,3)] #|s><p|
    sigmas_ps = sigmas[j][(3,2)] #|p><s|

    # E_0 = 0
    H_atomo += hbar * detuning_ca * sigmas_ee # energía del estado |e>, E1, es relativa a la frecuencia de la cavidad
    H_atomo += hbar * (detuning_ca+detuning_al) * sigmas_ss # energía del estado |s>, E2, es relativa a la frecuencia del láser + E1
    # E3 no es excitado por ningún campo, su energía es irrelevante en RWA
    
    H_atomo_cavidad += hbar * g * (aa * sigmas_ge + a * sigmas_eg)
    H_atomo_laser += -(hbar/2) * rabi_l * (sigmas_se + sigmas_es)

    # decamimiento espontáneo en cascada
    rdot_gamma += (gamma_eg/2) * (2*sigmas_ge*rho*sigmas_eg - sigmas_eg*sigmas_ge*rho - rho*sigmas_eg*sigmas_ge)
    rdot_gamma += (gamma_se/2) * (2*sigmas_es*rho*sigmas_se - sigmas_se*sigmas_es*rho - rho*sigmas_se*sigmas_es)
    rdot_gamma += (gamma_ps/2) * (2*sigmas_sp*rho*sigmas_ps - sigmas_ps*sigmas_sp*rho - rho*sigmas_ps*sigmas_sp)
# suma de interacciones dipolares par a par
for i in range(Nat):
    for j in range(i + 1, Nat):
        eg_i = sigmas[i][(1,0)]
        ge_i = sigmas[i][(0,1)]
        eg_j = sigmas[j][(1,0)]
        ge_j = sigmas[j][(0,1)]
        H_dipolar += hbar * Omega12 * (eg_i*ge_j + ge_i*eg_j)



H_cavidad = hbar * detuning_bc * (aa*a + 1/2) # Hamiltoniano del oscilador armónico cuántico (cavidad)
H_bombeo = I*hbar * rabi_b * (aa - a) # Hamiltoniano del bombeo

# Hamiltoniano total
H = H_cavidad + H_bombeo + H_atomo + H_dipolar + H_atomo_laser + H_atomo_cavidad
# ecuación de movimiento de Lindblad
rdot = I/hbar * comm(H,rho) \
        + (kappa/2)*(2*a*rho*aa - aa*a*rho - rho*aa*a) \
        + rdot_gamma

itime = time.time()
print("building ODE...")
build_ode(
    rho=rho,
    rdot=rdot,
    basis=base,
    filetype="GSL",
    filename="func.c"
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
ket0 = Ket(nfotones0,"cavidad")
for j in range(Nat):
    ketj = Ket(nestado0, f"atomo{j+1}")
    ket0 = ket0 * ketj # estado del átomo j por el ket total
rho0 = ket0*dag(ket0)
print("condiciones iniciales...")
init_conditions = init_state(rho=rho, rho0=rho0, basis=base, dic=dic)

# solución numérica (GSL)
symbexprs = []
# probabilidades
# lista de listas con los operadores base para cada átomo
# ops_atomos[j][0] es sigma_gg para el átomo j+1
# ops_atomos[j][1] es sigma_ee para el átomo j+1
ops_atomos = [ [sigmas[j][(lvl,lvl)] for lvl in range(4)] for j in range(Nat) ]
labels = []
estados = itertools.product(range(4), repeat=Nat)
# (0,0), (0,1), (1,0), (0,2),... para 2 átomos
# (0,0,0), (0,0,1),... para 3 átomos, y así

# itera sobre todas las combinaciones de estados posibles
for estado in estados: 
    proyector = 1 # operador identidad
    label = ""
    for atom, state in enumerate(estado): 
        proyector = proyector * ops_atomos[atom][state] # multiplicamos los elementos diagonales
        if state == 0:
            label += "g"
        elif state == 1:
            label += "e"
        elif state == 2:
            label += "s"
        elif state == 3:
            label += "p"
    
    proyector_symb = sub_qexpr(qexpr=trace(rho * proyector, basis=base), dic=dic)
    symbexprs.append(proyector_symb)
    labels.append(label) # nos dice el orden de las probabilidades P(ij) calculadas
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