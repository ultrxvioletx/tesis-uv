// ===================================================================
// A_codigos.typ
// ===================================================================
#import "../style.typ": *


#heading(level: 2, numbering: none)[Apéndice] <apx:codigo>


El propósito de este apéndice es ofrecer ejemplos prácticos de la implementación numérica descrita en el @cap:formulacion, utilizando la paquetería OpenKet para simular los sistemas estudiados.

Los scripts presentados a continuación son versiones simplificadas y diseñadas con el objetivo de ser claras, por lo que se han omitido elementos como gestión de parámetros o personalización de gráficas, entre otros. Sin embargo, los códigos fuente completos pueden ser consultados en el siguiente repositorio disponible públicamente:

#link("https://github.com/ultrxvioletx/tesis-uv/tree/main/assets/codigo")

#v(2em)

Para las todas simulaciones a continuación descritas, se utilizaron las siguientes importaciones de paqueterías, asumiendo que están previamente instaladas:
#codly(languages: codly-languages)
```python
import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint
from sympy import I

# OpenKet
from openket.core.diracobject import Ket, Bra, Operator
from openket.core.evolution import build_ode, sym2num, init_state
from openket.core.metrics import comm, trace, sub_qexpr
```


#heading(level: 3, numbering: none)[Oscilaciones de Rabi en átomo de dos niveles]

Este primer ejemplo tiene como propósito ilustrar el sistema más básico en OpenKet, a través de la construcción del Hamiltoniano, la ecuación de movimiento de Von Neumann y su resolución numérica. El script itera sobre distintos valores de desintonía para obtener las curvas de la @fig:1at2lvl.

#codly(languages: codly-languages)
```python
# parámetros de la simulación
hbar = 1
rabi_c = 2.0 # intensidad del campo láser
detunings = [0.0, 2.0, 4.0]
t = np.linspace(0, 10, 1000) # tiempo de simulación

# base del espacio de Hilbert
base = [Ket(0), Ket(1)] # |g>: Ket(0), |e>: Ket(1)
# operador densidad simbólico 
rho = Operator("rho")

# bucle principal, uno por cada valor de detuning
for i, detuning in enumerate(detunings):
    # construcción del Hamiltoniano
    def sigma(i,j): return Ket(i)*Bra(j)
    H_atomo = hbar * detuning * sigma(1, 1)
    H_laser = -(hbar/2) * rabi_c * (sigma(0,1) + sigma(1,0))
    H = H_atomo + H_laser
    
    # ecuación de Von Neumann
    rdot = -(I/hbar) * comm(H, rho)

    # generación de ODE numérica
    build_ode(
        rho=rho,
        rdot=rdot,
        basis=base, # base para expresar la EDO
        filetype="Scipy", # se crea la EDO en lenguaje python
        filename="func.py" # almacena la EDO
    )
    from func import f, dic
    
    # convertir condiciones iniciales simbólicas -> numéricas
    rho0 = Ket(0)*Bra(0) # estado inicial: estado base |g>
    init_conditions = init_state(rho, rho0, base, dic)
    
    # resolver la EDO usando el solver de Scipy
    rho_solution = odeint(f, init_conditions, t)

    # probabilidad de excitación
    j = 1 # estado excitado
    proyector = sigma(j, j) # P_e = |e><e|
    proyector_symb = sub_qexpr(trace(rho * proyector, basis=base), dic) # valor esperado simbólico
    
    # conversión de expresión simbólica a resultado numérico
    prob = np.real(sym2num(sol=rho_solution, symbexpr=proyector_symb))

    # gráfica
    plt.plot(t, prob)
```


#pagebreak()
#heading(level: 3, numbering: none)[Inyección y disipación de fotones en la cavidad]

Este segundo ejemplo modela el siguiente componente del sistema: la cavidad como sistema cuántico abierto. A diferencia del anterior, aquí se resuelve usando la ecuación de Lindblad, y muestra el manejo de los términos no unitarios.

Se simula la evolución temporal del número de fotones dentro de la cavidad, graficada en la @fig:cavidad. Considera un código similar al anterior, pero con el espacio de Hilbert de la cavidad $HHc$, de dimensión $nmax$, y el Hamiltoniano correspondiente.

#codly(languages: codly-languages)
```python
  # parámetros de la simulación
  hbar = 1.0
  rabi_b = 1.0 # tasa del bombeo
  detuning = 0.0 # cavidad y bombeo en resonancia
  kappa = 1.0 # disipación de la cavidad, referencia
  nmax = 15 # truncación del espacio de Hilbert
  t = np.linspace(0, 15, 1000) # tiempo de simulación

  # base del espacio de Hilbert
  base = [Ket(i, "cavidad") for i in range(nmax)] # estados de Fock
  # operadores
  rho = Operator("R")
  a = AnnihilationOperator("cavidad", nmax-1)
  aa = CreationOperator("cavidad", nmax-1)

  # construcción del Hamiltoniano
  H_cavidad = hbar * detuning * (aa*a + 1/2)
  H_bombeo = I*hbar * rabi_b * (aa - a)
  H = H_cavidad + H_bombeo

  # ecuación de movimiento de Lindblad
  rdot = -I/hbar * comm(H,rho) + (kappa/2)*(2*a*rho*aa - aa*a*rho - rho*aa*a)

  # generación de ODE numérica
  build_ode(
      rho=rho,
      rdot=rdot,
      basis=base, # base para expresar la EDO
      filetype="Scipy", # se crea la EDO en lenguaje python
      filename=f"func.py", # almacena la EDO
  )
  from func import f, dic
  
  # convertir condiciones iniciales simbólicas -> numéricas
  rho0 = Ket(0,"cavidad") * dag(Ket(0,"cavidad")) # 0 fotones
  init_conditions = init_state(rho, rho0, base, dic)

  # resolver la EDO usando el solver de Scipy
  rho_solution = odeint(f, init_conditions, t)

  # operador de número simbólico
  N = aa * a
  # traza simbólica
  N_symb = sub_qexpr(qexpr=trace(rho*N, basis=base), dic=dic)
  # mapeo simbólico a numérico
  N_expect = np.real(sym2num(sol=rho_solution, symbexpr=N_symb))

  # gráfica
  plt.plot(t, N_expect)
```


#heading(level: 3, numbering: none)[Bloqueo de Rydberg en función de la intensidad de interacción]

Finalmente, como último ejemplo, se muestra el más complejo de todos, pues considera al sistema completo de los dos átomos de cuatro niveles acoplados a la cavidad e interactuando entre sí, bajo la reducción adiabática del nivel intermedio. Para simular estas interacciones, se usan todos los Hamiltonianos descritos en @sec:descripcion-sistema y la ecuación de Lindblad completa.

El espacio de Hilbert es el producto tensorial del espacio de los átomos y el de la cavidad, con dimensión $16 nmax$. La interacción de Föster, responsable del bloqueo, se introduce en el Hamiltoniano $Hee$, y se fija la frecuencia del láser de prueba en la resonancia de una sola excitación (pico izquierdo), realizando un barrido de $Oee$, como ilustra la @fig:2at4lvl_excitado_omegas.

#codly(languages: codly-languages)
```python
  # parámetros de simulación
  hbar = 1.0
  rabi_p = 0.5 # tasa de bombeo
  rabi_c = 20.0 # intensidad campo láser
  g = 15.0 # fuerza de acoplamiento
  kappa = 1.0 # disipación de la cavidad
  gamma_e = 1.0 # decaimiento de |e>
  gamma_s = 0.0 # decaimiento de |s>
  gamma_12 = 0.0 # decaimiento colectivo
  omega_DR = 0.0 # interacción d-d transición inferior
  omegas = linspace(0, 20, 18) # interacción d-d |ss> <-> |pp>
  delta = 100 # large detuning
  d_p = -0.7722 # pico izquierdo
  stark_g = (rabi_p**2) / (4*delta) # vacuum shift
  stark_s = (rabi_c**2) / (4*delta) # AC stark shift
  detuning_p = delta + stark_g + d_p # corrección de desintonía
  detuning_c = -delta + stark_s
  nt = 1000
  t0, t1 = 0, 200/kappa
  t = np.linspace(t0, t1, nt) # tiempo de simulación
  nmax = 3 # truncamiento del espacio de Hilbert

  # operadores
  rho = Operator("R")
  a = AnnihilationOperator("cavidad", nmax-1)
  aa = CreationOperator("cavidad", nmax-1)

  # base del espacio de Hilbert
  b_cavidad = [Ket(i,"cavidad") for i in range(nmax)]
  b_atomo1 = [Ket(i,"atomo1") for i in range(4)]
  b_atomo2 = [Ket(i,"atomo2") for i in range(4)]
  base = [kb*k1*k2 for k1 in b_atomo1 for k2 in b_atomo2 for kb in b_cavidad]
  lenbase = len(base)

  # operadores de transición atómicos
  def sigma1(i,j): return Ket(i,"atomo1")*Bra(j,"atomo1")
  def sigma2(i,j): return Ket(i,"atomo2")*Bra(j,"atomo2")

  # bucle principal, uno por cada valor de omega_EE
  for omega_EE in omegas:
      # construcción del hamiltoniano
      def H_A(sigma):
          E_g = 0
          E_e = hbar*detuning_p
          E_s = E_e + hbar*detuning_c
          E_p = E_s
          return  E_g*sigma(0,0) + E_e*sigma(1,1) + E_s*sigma(2,2) + E_p*sigma(3,3)

      H_atomos = H_A(sigma1) + H_A(sigma2)
      H_cavidad = hbar * d_p * (aa*a + 1/2)
      H_bombeo = I*hbar * rabi_p * (aa - a)
      def H_I(sigma):
          atomo_cavidad =  hbar * g * (sigma(0,1)*aa + sigma(1,0)*a)
          atomo_laser = -(hbar/2) * rabi_c * (
            sigma(1,2) + sigma(2,1))
      H_interaccion = H_I(sigma1) + H_I(sigma2)
      dr = sigma1(1,0) * sigma2(0,1)
      H_dr = hbar * omega_DR * (dr + dag(dr))
      ee1 = sigma1(3,2) * sigma2(2,3)
      ee2 = sigma1(2,3) * sigma2(2,3)
      H_ee = hbar * omega_EE * (ee1 + dag(ee1) + ee2 + dag(ee2))
      # Hamiltoniano total
      H = H_atomos + H_cavidad + H_bombeo + H_interaccion + H_dr + H_ee

      # ecuación de movimiento de Lindblad
      def L(A):
          return 2*A*rho*dag(A) - dag(A)*A*rho - rho*dag(A)*A
      rdot = -I/hbar * comm(H,rho)
      rdot += (kappa/2) * L(a) # disipación de la cavidad
      rdot += (gamma_e/2) * L(sigma1(0,1)) # decaimiento de |e>
      rdot += (gamma_e/2) * L(sigma2(0,1))
      rdot += (gamma_s/2) * L(sigma1(1,2)) # decaimiento de |s>
      rdot += (gamma_s/2) * L(sigma2(1,2))
      y = sigma1(0,1) + sigma2(0,1)
      rdot += (gamma_12/2) * L(y) # decaimiento colectivo
      
      # generación de ODE numérica
      build_ode(
          rho=rho,
          rdot=rdot,
          basis=base, # base para expresar la EDO
          filetype="GSL", # se crea la EDO en lenguaje c
          filename=f"func.c", # almacena la EDO
          dictname=f"dic.py" # almacena el dict de mapeo
      )
      from dic import dic

      # convertir condiciones iniciales simbólicas -> numéricas
      ket0 = Ket(0,"cavidad") * Ket(0,"atomo1") * Ket(0,"atomo2")
      rho0 = ket0 * dag(ket0)
      init_conditions = init_state(rho=rho, rho0=rho0, basis=base, dic=dic)

      # valores esperados
      symbexprs = []
      # probabilidades de estados atómicos |i,j>
      for i in range(4):
          for j in range(4):
              proyector = sigma1(i,i) * sigma2(j,j)
              proyector_symb = sub_qexpr(qexpr=trace(rho * proyector, basis=base), dic=dic)
              symbexprs.append(proyector_symb)
      # operador de número
      N = aa * a 
      N_symb = sub_qexpr(qexpr=trace(rho * N, basis=base), dic=dic)
      symbexprs.append(N_symb)

      # creacion archivo c
      gsl_main(
          odefile="func.c",
          y0=init_conditions,
          tspan=(t0,t1),
          step=nt,
          outfile="edo_gsl",
          symbexprs=symbexprs,
          options={"output_format": "hdf5"}
      )
```

Al considerar el sistema completo, el solucionador de Scipy deja de ser eficiente y se vuelve necesario expresar la ODE en lenguaje C para ser resuelto usando GSL. El archivo de salida de la función `gsl_main`, llamada `edo_gsl.c`, está listo para ser compilado y devuelve los 18 archivos HDF5 correspondientes (uno por cada valor de $Oee$). Para poder visualizar el comportamiento del bloqueo, se toma el valor de convergencia en la evolución temporal de los valores esperados, y se grafica en función de $Oee$.