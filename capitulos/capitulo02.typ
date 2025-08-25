// ===================================================================
// capitulo02.typ
// ===================================================================
#import "../style.typ": *

== Teoría cuántica de la interacción átomo-campo <cap:02>

En el tratamiento semiclásico de la interacción luz-materia, hemos modelado al átomo como un sistema cuántico discreto, pero hemos tratado al campo electromagnético como una onda clásica externa $vecb(E)(t) = vecb(E)_0 cos(nu t)$. Si bien este enfoque nos ha permitido observar resultados como las oscilaciones de Rabi, no es capaz de explicar fenómenos como la emisión espontánea, donde un átomo excitado decae emitiendo un fotón incluso en ausencia de un campo externo.

Para ello, nuestro siguiente paso es la cuantización del campo externo. Discutiremos la interacción de un campo de radiación cuántica con el sistema del átomo de dos niveles, descrito por el Hamiltoniano con aproximación dipolar, expresado en la ecuación @eq01:field-hamiltonian2.


// ===================================================================
=== Oscilador armónico cuántico (Cohen)
#let opX = $hat(X)$
#let opP = $hat(P)$
#let opH = $hat(H)$
#let opN = $hat(N)$
#let ani = $hat(a)$
#let cre = $hat(a)^dagger$
#let En = $E_n$
#let kn = $ket(n)$

Como la idea central de la cuántización del campo electromagnético es que en cada modo éste se comporta exactamente como un oscilador armónico cuántico independiente, comenzaremos con explicar algunos conceptos importantes de este sistema.

Partimos del Hamiltoniano de un oscilador armónico clásico unidimensional de masa $m$ y frecuencia $omega$,

$ H = (p²)/(2m) + 1/2 m omega² x² $

que puede ser cuantizado simplemente _convirtiendo_ la posición $x$ y momento $p$ en operadores hermitianos, $opX'$ y $opP'$, cuya relación de conmutación es $[opX', opP'] = i hbar$. Así, el Hamiltoniano cuántico se convierte en

$ opH = (opP'^2)/(2m) + 1/2 m omega^2 opX'^2 $

o, escrito de otra forma,

$ opH = (hbar omega)/2 (opX^2 + opP^2) $

donde $opX = sqrt((m omega)/hbar) opX'$ y $opP = 1/sqrt(m omega hbar) opP'$ son los operadores adimensionales asociados. Como $opH$ no depende del tiempo, la solución se reduce a simplemente resolver la ecuación de eigenvalores $opH ket(phi) = E ket(phi)$.


Para resolverla, se introducen los operadores (no hermitianos) $ani$ y $cre$, como combinaciones lineales de $opX$ y $opP$

$
  ani &= 1/sqrt(2)(opX + i opP)\
  cre &= 1/sqrt(2)(opX - i opP)\
$

cuyo conmutador es $[ani,cre]=1$ y además se satisface que $cre ani = 1/2 (opX^2 + opP^2 -1)$, por lo tanto, el Hamiltoniano queda escrito como

$ opH = hbar omega (cre ani + 1/2) $

Esta forma notablemte simple del Hamiltoniano nos va a permitir encontrar el espectro de energía. Si ahora definimos el operador hermitiano $opN = cre ani$, entonces

$ opH = hbar omega (opN + 1/2) $

Se puede demostrar que los eigenestados del operador $opN$ son los estados de Fock denotados por $kn$, y sus eigenvalores son los enteros no negativos $n = 0,1,2,...$. Por lo tanto, los niveles de energía permitidos del oscilador armónico cuántico son

$ En = (n + 1/2) h omega $

y la separación entre niveles es simplemente $Delta E = hbar omega$. Con esto, hemos expresado que en la mecánica cuántica, la energía del oscilador armónico está cuantizado y no puede tomar valores arbritrarios.

Una propiedad importante de los operadores $cre$ y $ani$, es que actúan como una _escalera_, esto es, conectan los niveles de energía mediante las propiedades

$
  cre kn &= sqrt(n+1) ket(n+1) \
  ani kn &= sqrt(n) ket(n-1)
$

y es por eso que $cre$ recibe el nombre de operador *creación* y $ani$ de operador *aniquilación*, pues su acción sobre un eigenestado de $opN$ hace a un cuanto de energía $hbar omega$ aparecer o desaparecer.






// ===================================================================
=== Cuantización del campo externo