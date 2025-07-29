// ===================================================================
// simulacion01.typ
// ===================================================================
#import "../style.typ": *

== Átomo de 2 niveles <sim:01>

// ===================================================================
Teniendo en cuenta estas consideraciones, para poder simular las amplitudes de probabilidad $|c_n (t)|^2$ del átomo de 2 niveles (y en general cualquier sistema cuántico) debemos expresar su Hamiltoniano en términos de la base ${ket(n)}$.\
Tomaremos la matriz Hamiltoniana de @eq01:rabi-matrix-system y, para realizar el código escrito en Python, representaremos al estado base como $ket(0)$ y el estado excitado $ket(1)$. Así, el Hamiltoniano queda reescrito como


```py
  rabi = 1/2 #frecuencia de Rabi
  delta = 1 #detuning 
  base = [Ket(0), Ket(1)]
  rho = Operator("rho")
  
  H = h/2 * (-delta*Ket(0)*Bra(0) + -rabi*Ket(0)*Bra(1) + -rabi*Ket(1)*Bra(0) + delta*Ket(1)*Bra(1))
```