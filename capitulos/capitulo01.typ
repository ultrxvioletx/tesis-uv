// ===================================================================
// capitulo01.typ
// ===================================================================
#import "../style.typ": *

== Átomo cuántico interactuando con luz clásica <cap:01>

// ===================================================================
=== Átomo libre
Partimos del sistema más sencillo al suponer un átomo en ausencia de campos externos, cuyo Hamiltoniano está dado por

$ hat(H)_0 = 1/(2 m) vecop(P)^2 + V(r) $

donde $V(r)$ es la interacción coulombiana del electrón con el núcleo, y en la representación de espacio $vecop(P)=-i nabla$ y $r = abs(vecb(r))$. Además, como se trata de un átomo libre, podemos describir el sistema mediante la ecuación de Schrödinger dependiente del tiempo

$ i hbar pdv(Psi,t) = hat(H)_0 Psi $

cuyas soluciones son los estados estacionarios

$ Psi(vecb(r),t) = psi_n (vecb(r)) e^((-i E_n t)/hbar) $ <eq:free-dep-wavefunctions>

donde $psi_n (vecb(r))$ es la parte espacial y representa a un átomo que se encuentra en un nivel de energía bien definido, llamada función de onda del estado $ket(n)$, $e^((-i E_n t)/hbar)$ es un factor de fase y $E_n$ la energía del estado $ket(n)$. $psi_n (vecb(r))$ y $E_n$ son las eigenfunciones y los eigenvalores de $H_0$, respectivamente

$ hat(H)_0 psi_n (vecb(r)) = E_n psi_n (vecb(r)) $ <eq:free-ind-schrodinger>

Y además las funciones de onda $psi_n (vecb(r))$ cumplen con la condición de ortonormalidad

$ integral d vecb(r) psi^*_n (vecb(r)) psi_m (vecb(r)) = delta_(n m) $

por lo que son una base en el espacio de Hilbert.

// ===================================================================
=== Átomo en presencia de campo externo (Gerry-Knight)
En presencia de un campo electromagnético externo, el Hamiltoniano de una partícula con carga $"e"$ y masa $m$ está dado por

$ hat(H) (vecb(r),t) = 1/(2m) [vecop(P) + "e"vecb(A)(vecb(r),t)]² - "e"Phi(vecb(r),t) + V(r) $

donde $vecb(A)(vecb(r),t)$ y $Phi(vecb(r),t)$ son los potenciales vectorial y escalar, respectivamente, tales que definen a los campos como

$
  vecb(E)(vecb(r),t) &= -nabla Phi(vecb(r),t) - pdv(vecb(A)(vecb(r),t), t) \
  vecb(B)(vecb(r),t) &= nabla times vecb(A)(vecb(r),t)
$ <eq:campos>

que son invariantes ante las transformaciones de gauge

$
  Phi'(vecb(r),t) &= Phi(vecb(r),t) - pdv(chi(vecb(r),t), t) \
  vecb(A)'(vecb(r),t) &= vecb(A)(vecb(r),t) + nabla chi(vecb(r),t) \
$

donde $chi (vecb(r),t)$ es una función escalar arbitraria. Por lo tanto, podemos definir el Hamiltoniano

$ hat(H)' = 1/(2m) [vecop(P) + "e"vecb(A)'(vecb(r),t)]² - "e"Phi'(vecb(r),t) + V(r) $

que deja invariante el comportamiento del átomo en el campo.

Consideremos ahora una transformación de gauge muy particular, llamada transformación de Coulomb, con la cual se cumple $nabla dot vecb(A) = 0$ y $Phi = 0$. Con esto hemos establecido que el potencial vectorial $vecb(A)$ es puramente transversal (pues su divergencia es cero), y además podemos expresar $hat(H)'$ como

$ hat(H)' = 1/(2m) [vecop(P) + "e"(vecb(A) + nabla chi)]² + "e"pdv(chi,t) + V(r) $

Partiendo ahora de la ecuación de Ampere-Maxwell

$ nabla times vecb(B) = mu_0 vecb(J) + mu_0 epsilon_0 pdv(vecb(E),t) $

sustituimos $vecb(B)$ y $vecb(E)$ por sus expresiones en @eq:campos, y aplicamos la transformación de Coulomb

$
  nabla times (nabla times vecb(A)) &= mu_0 vecb(J) + mu_0 epsilon_0 pdv(,t)(-nabla Phi - pdv(vecb(A),t)) \

  --> nabla (nabla dot vecb(A)) - nabla² vecb(A) &= mu_0 vecb(J) - mu_0 epsilon_0 nabla (pdv(Phi,t)) - mu_0 epsilon_0 pdv(vecb(A),t,2) \

  --> nabla² vecb(A) - mu_0 epsilon_0 pdv(vecb(A),t,2) &= - mu_0 vecb(J)
$

Como estamos suponiendo que no hay fuentes cerca, entonces no hay densidad de corriente $vecb(J)=0$, y lo que queda es la ecuación de onda homogénea

$ nabla² vecb(A) - 1/(c²) pdv(vecb(A),t,2) = 0 $

cuya solución general es $vecb(A) = vecb(A)_0 e^(-i(vecb(k) dot vecb(r) - omega t)) + vecb(A)^*_0 e^(i(vecb(k) dot vecb(r) - omega t))$.

Luego, consideramos el vector de propagación de una onda con longitud $lambda$, cuya magnitud es $abs(vecb(k))=(2 pi)/lambda$; en óptica, $lambda$ tiene típicamente valores de orden $10^(-7)$m (la luz visible se encuentra entre 380-750 nm) y $abs(vecb(r))$ tiene dimensiones atómicas, de orden $10^(-10)$m, entonces $vecb(k) dot vecb(r) << 1$ (aproximación dipolar), provocando que el potencial vectorial sea uniforme en el espacio alrededor del átomo, $vecb(A)(vecb(r),t) approx vecb(A)(t)$.

Si ahora consideramos otra transformación de gauge, dada por $chi(vecb(r),t)=-vecb(A)(t) dot vecb(r)$, entonces

$
  nabla chi (vecb(r),t) &= -vecb(A)(t) \
  pdv(,t) chi (vecb(r),t) &= -vecb(r) dot pdv(vecb(A),t) = -vecb(r) dot vecb(E)(t)
$

por lo tanto

$ hat(H)' = (vecop(P))/(2m) + V(r) + "e"vecb(r) dot vecb(E)(t) $

Y finalmente, después de considerar la expresión del momento dipolar $vecb(d)=-"e"vecb(r)$, obtenemos el siguiente Hamiltoniano

$ hat(H)' = hat(H)_0 - vecop(d) dot vecb(E)(t) $ <eq:field-hamiltonian>

Para simplificar la notación, realizaremos un cambio de etiqueta a $hat(H)'$ y lo llamaremos simplemente $hat(H)$, y al término $- vecop(d) dot vecb(E)(t)$ le vamos a asociar el Hamiltoniano de interacción denotado por $hat(H)_I (t)$. Así, la expresión @eq:field-hamiltonian queda reescrita como

$ hat(H) = hat(H)_0 + hat(H)_I (t) $ <eq:field-hamiltonian2>

// ===================================================================
=== Interacción semiclásica átomo-campo
El planteamiento y desarrollo del contenido de esta sección fue tomado del capítulo 2 del libro _Quantum optics: including noise reduction, trapped ions, quantum trajectories, and decoherence_ #cite(<orszag2008_quantum>, style: "elsevier-harvard").

Hasta ahora no hemos hablado nada acerca de la naturaleza del campo electromagnético, si es considerado clásico o cuántico, y la expresión @eq:field-hamiltonian es válida para ambos casos. En el modelo semiclásico de interacción, es decir aquel que considera al campo electromagnético clásico con un átomo cuántico, queremos explorar las consecuencias de que la frecuencia del campo casi coincida con la diferencia de energía entre un par de niveles atómicos (fenómeno de cuasiresonancia), al que llamaremos *átomo de 2 niveles*.

El átomo de 2 niveles se caracteriza por un estado base $ket(b)$ y el estado excitado $ket(a)$, con energías $E_b = hbar omega_b$ y $E_a = hbar omega_a$, respectivamente. Exploraremos el caso donde el átomo intercatúa con un campo eléctrico dado por una onda senosoidal, $vecb(E)(t) = vecb(E)_0 cos(omega t)$, siendo $omega$ la frecuencia de la radiación del campo y $vecb(E)_0 = vecb(e) E_0$, donde $vecb(e)$ es el vector unitario de polarización del campo.

Así, definimos la _desintonía_ como

$ delta equiv (omega_a - omega_b) - omega $

Ahora, tomamos el Hamiltoniano @eq:field-hamiltonian2 para la ecuación de Schrödinger dependiente del tiempo de la interacción

$ i hbar pdv(,t) psi(vecb(r),t) = [hat(H)_0+hat(H)_I (t)] psi(vecb(r),t) $

y usamos las soluciones de la ecuación de Schrödinger dependiente del tiempo del átomo libre en @eq:free-dep-wavefunctions como base conveniente para descomponer a la función de onda de la interacción

$ psi(vecb(r),t) = sum_(n) C_n (t) psi(vecb(r)) e^(-i omega_n t) $

con $omega_n = E_n / hbar$