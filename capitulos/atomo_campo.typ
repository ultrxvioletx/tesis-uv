// ===================================================================
// 03_atomo_campo.typ
// ===================================================================
#import "../style.typ": *

=== Interacción semiclásica átomo-campo <atomo-campo>

==== Átomo en presencia de campo externo (Gerry-Knight)
#let rt = $(vecb(r),t)$
#let qe = $bold(e)$
#let H0 = $hat(H)_0$
#let HI = $hat(H)_I (t)$
En presencia de un campo electromagnético externo, el Hamiltoniano de una partícula con carga $qe$ y masa $m$ está dado por

$ hat(H) rt = 1/(2m) [vecop(P) + qe vecb(A)rt]² - qe Phi rt + V(r) $

donde $vecb(A)rt$ y $Phi rt$ son los potenciales vectorial y escalar, respectivamente, tales que definen a los campos como

$
  vecb(E)rt &= -nabla Phi rt - pdv(vecb(A)rt, t) \
  vecb(B)rt &= nabla times vecb(A)rt
$ <eq:campos>

que son invariantes ante las transformaciones de gauge

$
  Phi' rt &= Phi rt - pdv(chi rt, t) \
  vecb(A)' rt &= vecb(A)rt + nabla chi rt \
$

donde $chi rt$ es una función escalar arbitraria. Por lo tanto, podemos definir el Hamiltoniano

$ hat(H)' = 1/(2m) [vecop(P) + qe vecb(A)' rt]² - qe Phi' rt + V(r) $

que deja invariante el comportamiento del átomo en el campo.

Consideremos ahora una transformación de gauge muy particular, llamada transformación de Coulomb, con la cual se cumple $nabla dot vecb(A) = 0$ y $Phi = 0$. Con esto hemos establecido que el potencial vectorial $vecb(A)$ es puramente transversal (pues su divergencia es cero), y además podemos expresar $hat(H)'$ como

$ hat(H)' = 1/(2m) [vecop(P) + qe (vecb(A) + nabla chi)]² + qe pdv(chi,t) + V(r) $

Partiendo ahora de la ecuación de Ampere-Maxwell

$ nabla times vecb(B) = mu_0 vecb(J) + mu_0 epsilon_0 pdv(vecb(E),t) $

sustituimos $vecb(B)$ y $vecb(E)$ por sus expresiones en @eq:campos, y aplicamos la transformación de Coulomb

$
  nabla times (nabla times vecb(A)) &= mu_0 vecb(J) + mu_0 epsilon_0 pdv(,t)(-nabla Phi - pdv(vecb(A),t)) \

  ==> nabla (nabla dot vecb(A)) - nabla² vecb(A) &= mu_0 vecb(J) - mu_0 epsilon_0 nabla (pdv(Phi,t)) - mu_0 epsilon_0 pdv(vecb(A),t,2) \

  ==> nabla² vecb(A) - mu_0 epsilon_0 pdv(vecb(A),t,2) &= - mu_0 vecb(J)
$

Como estamos suponiendo que no hay fuentes cerca, entonces no hay densidad de corriente $vecb(J)=0$, y lo que queda es la ecuación de onda homogénea

$ nabla² vecb(A) - 1/(c²) pdv(vecb(A),t,2) = 0 $

cuya solución general es $vecb(A) = vecb(A)_0 e^(-i(vecb(k) dot vecb(r) - omega t)) + vecb(A)^*_0 e^(i(vecb(k) dot vecb(r) - omega t))$.

Luego, de la expresión anterior consideremos a $vecb(k)$, el vector de propagación de la onda con longitud $lambda$, cuya magnitud es $abs(vecb(k))=(2 pi)/lambda$; en óptica, $lambda$ tiene típicamente valores de orden $10^(-7)$m (la luz visible se encuentra entre 380-750 nm) y $abs(vecb(r))$ tiene dimensiones atómicas de orden $10^(-10)$m, entonces $vecb(k) dot vecb(r) << 1$, esto es, asumimos que la longitud de onda de la luz es mucho mayor que el tamaño del átomo, lo que se conoce como aproximación dipolar, provocando que el potencial vectorial sea uniforme en el espacio alrededor del átomo, $vecb(A)rt approx vecb(A)(t)$.

Si ahora consideramos otra transformación de gauge, dada por $chi rt=-vecb(A)(t) dot vecb(r)$, entonces

$
  nabla chi rt &= -vecb(A)(t) \
  pdv(,t) chi rt &= -vecb(r) dot pdv(vecb(A),t) = -vecb(r) dot vecb(E)(t)
$

por lo tanto

$ hat(H)' = (vecop(P))/(2m) + V(r) + qe vecb(r) dot vecb(E)(t) $

Y finalmente, después de considerar la expresión del momento dipolar $vecb(d)=-qe vecb(r)$, causado por la separación entre el electrón y el núcleo del átomo, obtenemos el siguiente Hamiltoniano

$ hat(H)' = H0 - vecop(d) dot vecb(E)(t) $ <eq:field-hamiltonian>

En general, para un representación no especificada, el momento dipolar es un operador $vecop(d)$. Para simplificar la notación, realizaremos un cambio de etiqueta a $hat(H)'$ y lo llamaremos simplemente $hat(H)$, y al término $- vecop(d) dot vecb(E)(t)$ le vamos a asociar el Hamiltoniano de interacción denotado por $HI$.

$ HI = - vecop(d) dot vecb(E)(t) $

Así, la expresión @eq:field-hamiltonian queda reescrita como

$ hat(H) = H0 + HI $ <eq:field-hamiltonian2>






// ===================================================================
==== Átomo de dos niveles interactuando con campo clásico (Orszag)
#set math.mat(delim: "[")
#set math.vec(delim: "[")
#let kPsi = $ket(Psi (t))$
#let ke = $ket(e)$
#let kg = $ket(g)$
#let ee = $e^(-i omega_e t)$
#let eg = $e^(-i omega_g t)$
#let Ce = $C_e (t)$
#let Cg = $C_g (t)$
#let we = $omega_e$
#let wg = $omega_g$
#let Ee = $E_e$
#let Eg = $E_g$

#let qe = $bold(e)$
#let H0 = $hat(H)_0$
#let HI = $hat(H)_I (t)$

El planteamiento y desarrollo del contenido de esta sección fue tomado del capítulo 2 del libro _Quantum optics: including noise reduction, trapped ions, quantum trajectories, and decoherence_ #cite(<orszag2008_quantum>, style: "elsevier-harvard").

Hasta ahora no hemos hablado nada acerca de la naturaleza del campo electromagnético, si es considerado clásico o cuántico, y la expresión @eq:field-hamiltonian es válida para ambos casos. En el modelo semiclásico de interacción, es decir aquel que considera al campo electromagnético clásico con un átomo cuántico, queremos explorar las consecuencias de que la frecuencia del campo casi coincida con la diferencia de energía entre un par de niveles atómicos (fenómeno de cuasirresonancia), al que llamaremos *átomo de 2 niveles*.

#figure(
  diagram(cell-size: 15mm,
          mark-scale: 130%,
          node((0,1), $hbar wg$),
          edge((0,1),(1,1)),
          node((1,1), $kg$),

          edge((0.5,1),(0.5,0), "<|-|>", $omega$, label-side: left),
          edge((-0.5,0.5),(0,0.5), $nu$, "-|>", "wave"),

          node((0,0), $hbar we$),
          edge((0,0),(1,0)),
          node((1,0), $ke$),
  ),
  caption: [Diagrama de la interacción de un átomo de dos niveles con un campo eléctrico de frecuencia $nu$.]
)

El átomo de 2 niveles se caracteriza por un estado base $kg$ y el estado excitado $ke$, con energías $hbar wg$ y $hbar we$, respectivamente. Exploraremos el caso donde el átomo intercatúa con un campo eléctrico dado por una onda senosoidal

$ vecb(E)(t) = vecb(E)_0 cos(nu t) $

siendo $nu$ la frecuencia de la radiación del campo y $vecb(E)_0 = vecop(e) E_0$, donde $vecop(e)$ es el vector unitario de polarización del campo.

Para simplificar la derivación, procederemos utilizando los estados sin considerar ninguna representación. Tomamos el Hamiltoniano @eq:field-hamiltonian2 para la ecuación de Schrödinger dependiente del tiempo de la interacción

$ i hbar dv(,t) kPsi = [H0 + HI] kPsi $ <eq:total-dep-schrodinger>

y usamos las soluciones @eq:free-dep-state de la ecuación de Schrödinger dependiente del tiempo del átomo libre como base conveniente para descomponer a la función de onda de la interacción

$ kPsi = Ce ee ke + Cg eg kg $ <eq:total-dep-state>

con $omega_i = E_i / hbar$. Al sustituir @eq:total-dep-state en @eq:total-dep-schrodinger obtenemos del lado izquierdo

$
  i hbar dv(,t) kPsi
  &= i hbar dv(,t) (Ce ee ke + Cg eg kg) \
  &= i hbar [(dv(C_e,t) - i we C_e) ee ke + (dv(C_g,t) - i wg C_g) eg kg]
$ <eq:total-dep-schrodinger-left>

Y del lado derecho, como $H0$ es un operador lineal que actúa solamente sobre los estados $ket(n)$ y no sobre funciones de tiempo, entonces no afecta a los términos $C_n (t)$ ni $e^(-i omega_n t)$. Además, $ke$ y $kg$ cumplen con la ecuación de eigenvalores de $H0$ @eq:free-eigenfunction, entonces

$
  [H0 &+ HI] kPsi \
  &= H0(C_e ee ke + C_g eg kg) + HI(C_e ee ke + C_g eg kg) \
  &= Ee C_e ee ke + Eg C_g eg kg + HI(C_e ee ke + C_g eg kg)
$ <eq:total-dep-schrodinger-rigth>

Considerando que $E_n = hbar omega_n$, el término $i hbar (-i omega_n C_n)$ de @eq:total-dep-schrodinger-left se convierte en $hbar omega_n C_n = E_n C_n$ y se cancela con los dos primeros términos de @eq:total-dep-schrodinger-rigth, dejándonos con

$ i hbar (dv(C_e,t) ee ke + dv(C_g,t) eg kg) = HI(C_e ee ke + C_g eg kg) $ <eq:total-dep-schrodinger2>

Ahora bien, si proyectamos sobre el estado $ke$ es decir, multiplicamos toda la ecuación por $bra(a)$, tenemos

$ i hbar dv(C_e,t) ee = C_e ee braket(e,HI,e) + C_g eg braket(e,HI,g) $

Recordemos que 
$ HI = -vecop(d) dot E(t) = -qe E_0 (vecb(r) dot vecop(e)) cos nu t $

y, además, por paridad de las funciones de onda, el elemeto diagonal $braket(e,HI,e)$ es cero. Por lo tanto

#let eeg = $e^(-i omega t)$
#let deg = $"d"_(e g)$
#let dge = $"d"_(g e)$
#let ce = $c_e (t)$
#let cg = $c_g (t)$
#let rabi = $Omega_R$
$ &i hbar dv(C_e,t) ee = C_g eg braket(e,HI,g) $
$
  ==> i hbar dv(C_e,t) &= C_g e^(i we t) eg braket(e,HI,g)
                      = C_g e^(-(we - wg)t) braket(e,HI,g) \
                      &= C_g eeg (-E_0 cos nu t) qe braket(a,vecb(r),b) dot vecop(e) \
                      &equiv C_g e^(i nu t) (- deg E_0 cos nu t)
$

Donde definimos el elemento de matriz dipolar $deg = qe braket(e,vecb(r),g) dot vecop(e) = dge^*$. Finalmente, aplicamos la expansión del coseno $cos nu t = (e^(i nu t) + e^(-i nu t))/2$

$
  i hbar dv(C_e,t) &= -(deg E_0)/2 Cg eeg (e^(i nu t) + e^(-i nu t)) \
  &= -(deg E_0)/2 Cg [e^(i(omega + nu)t) + e^(i(omega - nu)t)]
$

Realizando un procedimiento análogo en donde proyectamos la ecuación @eq:total-dep-schrodinger2 sobre el estado $kg$, obtenemos el siguiente par de ecuaciones diferenciales acopladas

$
  &i hbar dv(C_g,t) = -(deg E_0)/2 Ce [e^(-i(omega + nu)t) + e^(-i(omega - nu)t)] \
  &i hbar dv(C_e,t) = -(deg E_0)/2 Cg [e^(i(omega + nu)t) + e^(i(omega - nu)t)]
$

en donde aparecen términos que oscilan muy rápido (a frecuencias $omega + nu$) y términos que oscilan lentamente (a frecuencias $omega - nu$). La *Aproximación de Onda Rotante (RWA)* consiste en ignorar los términos que oscilan rápidamente, ya que su efecto promedio sobre largos periodos de tiempo es casi nulo, y nos quedamos solo con los términos de oscilación lenta. \
Bajo esta aproximación, definimos


$
  cg &= Cg/2 e^(-i Delta t) \ 
  ce &= Ce/2 e^(i Delta t)
$

donde $ Delta equiv (we - wg) - nu = omega - nu $ es la *desintonía* entre la diferencia de energía entre los niveles, y la frecuencia de radiación del campo; y la *Frecuencia de Rabi*,

$ rabi = abs((-deg E_0)/2) $

obteniendo

$
  dv(,t) cg &= -i/2 [-Delta ce + rabi ce] \
  dv(,t) ce &= -i/2 [Delta ce + rabi cg]
$ <eq:rabi-eq-system>






// ===================================================================
==== Simulación: átomo de 2 niveles interactuando con luz clásica