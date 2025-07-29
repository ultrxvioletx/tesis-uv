// ===================================================================
// capitulo01.typ
// ===================================================================
#import "../style.typ": *

== Átomo cuántico interactuando con luz clásica <cap:01>
// == Teoría semiclásica de la interacción átomo-campo <cap:01>



// ===================================================================
=== Átomo libre <sec01:atomo-libre>
#let H0 = $hat(H)_0$
#let en = $e^(-(i E_n t)/hbar)$
#let kn = $ket(n)$
#let psin = $psi_n (vecb(r))$
Partimos del sistema más sencillo al suponer un átomo en ausencia de campos externos, cuyo Hamiltoniano está dado por

$ H0 = 1/(2 m) vecop(P)^2 + V(r) $

donde $V(r)$ es la interacción coulombiana del electrón con el núcleo, y en la representación de espacio $vecop(P)=-i nabla$ y $r = abs(vecb(r))$. Además, como se trata de un átomo libre, podemos describir el sistema mediante la ecuación de Schrödinger dependiente del tiempo

$ i hbar pdv(Psi,t) = H0 Psi $

cuyas soluciones son los estados estacionarios

$ ket(Psi(t)) = en kn $ <eq01:free-dep-state>

o, expresados en la representación de espacio

$ braket(r,Psi) = Psi(vecb(r),t) = psin en $ <eq01:free-dep-wavefunction>

donde $braket(r,n) = psin$ es la parte espacial y representa a un átomo que se encuentra en un nivel de energía bien definido, llamada función de onda del estado $kn$, $en$ es un factor de fase y $E_n$ la energía del estado $kn$. \
$kn$, $psin$ y $E_n$ son los eigenestados, las eigenfunciones y los eigenvalores de $H_0$, respectivamente

$
  H0 psin = E_n psin \
  H0 kn = E_n kn
$ <eq01:free-eigenfunction>

Y además las funciones de onda $psin$ y los estados $kn$ cumplen con la condición de ortonormalidad

$ integral dd(vecb(r),3) psi^*_m (vecb(r)) psin = braket(m,n) = delta_(n m) $

por lo que son una base en el espacio de Hilbert.










// ===================================================================
=== Átomo en presencia de campo externo (Gerry-Knight) <sec01:atomo-campo>
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
$ <eq01:campos>

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

sustituimos $vecb(B)$ y $vecb(E)$ por sus expresiones en @eq01:campos, y aplicamos la transformación de Coulomb

$
  nabla times (nabla times vecb(A)) &= mu_0 vecb(J) + mu_0 epsilon_0 pdv(,t)(-nabla Phi - pdv(vecb(A),t)) \

  ==> nabla (nabla dot vecb(A)) - nabla² vecb(A) &= mu_0 vecb(J) - mu_0 epsilon_0 nabla (pdv(Phi,t)) - mu_0 epsilon_0 pdv(vecb(A),t,2) \

  ==> nabla² vecb(A) - mu_0 epsilon_0 pdv(vecb(A),t,2) &= - mu_0 vecb(J)
$

Como estamos suponiendo que no hay fuentes cerca, entonces no hay densidad de corriente $vecb(J)=0$, y lo que queda es la ecuación de onda homogénea

$ nabla² vecb(A) - 1/(c²) pdv(vecb(A),t,2) = 0 $

cuya solución general es $vecb(A) = vecb(A)_0 e^(-i(vecb(k) dot vecb(r) - omega t)) + vecb(A)^*_0 e^(i(vecb(k) dot vecb(r) - omega t))$.

Luego, de la expresión anterior consideremos a $vecb(k)$, el vector de propagación de la onda con longitud $lambda$, cuya magnitud es $abs(vecb(k))=(2 pi)/lambda$; en óptica, $lambda$ tiene típicamente valores de orden $10^(-7)$m (la luz visible se encuentra entre 380-750 nm) y $abs(vecb(r))$ tiene dimensiones atómicas, de orden $10^(-10)$m, entonces $vecb(k) dot vecb(r) << 1$ (aproximación dipolar), provocando que el potencial vectorial sea uniforme en el espacio alrededor del átomo, $vecb(A)rt approx vecb(A)(t)$.

Si ahora consideramos otra transformación de gauge, dada por $chi rt=-vecb(A)(t) dot vecb(r)$, entonces

$
  nabla chi rt &= -vecb(A)(t) \
  pdv(,t) chi rt &= -vecb(r) dot pdv(vecb(A),t) = -vecb(r) dot vecb(E)(t)
$

por lo tanto

$ hat(H)' = (vecop(P))/(2m) + V(r) + qe vecb(r) dot vecb(E)(t) $

Y finalmente, después de considerar la expresión del momento dipolar $vecb(d)=-qe vecb(r)$, causado por la separación entre el electrón y el núcleo del átomo, obtenemos el siguiente Hamiltoniano

$ hat(H)' = H0 - vecop(d) dot vecb(E)(t) $ <eq01:field-hamiltonian>

En general, para un representación no especificada, el momento dipolar es un operador $vecop(d)$. Para simplificar la notación, realizaremos un cambio de etiqueta a $hat(H)'$ y lo llamaremos simplemente $hat(H)$, y al término $- vecop(d) dot vecb(E)(t)$ le vamos a asociar el Hamiltoniano de interacción denotado por $HI$.

$ HI = - vecop(d) dot vecb(E)(t) $

Así, la expresión @eq01:field-hamiltonian queda reescrita como

$ hat(H) = H0 + HI $ <eq01:field-hamiltonian2>






// ===================================================================
=== Átomo de 2 niveles (Orszag) <sec01:2-niveles>
#set math.mat(delim: "[")
#set math.vec(delim: "[")
#let kPsi = $ket(Psi (t))$
#let ka = $ket(a)$
#let kb = $ket(b)$
#let ea = $e^(-i omega_a t)$
#let eb = $e^(-i omega_b t)$
#let Ca = $C_a (t)$
#let Cb = $C_b (t)$
#let wa = $omega_a$
#let wb = $omega_b$
#let Ea = $E_a$
#let Eb = $E_b$

#let qe = $bold(e)$
#let H0 = $hat(H)_0$
#let HI = $hat(H)_I (t)$

El planteamiento y desarrollo del contenido de esta sección fue tomado del capítulo 2 del libro _Quantum optics: including noise reduction, trapped ions, quantum trajectories, and decoherence_ #cite(<orszag2008_quantum>, style: "elsevier-harvard").

Hasta ahora no hemos hablado nada acerca de la naturaleza del campo electromagnético, si es considerado clásico o cuántico, y la expresión @eq01:field-hamiltonian es válida para ambos casos. En el modelo semiclásico de interacción, es decir aquel que considera al campo electromagnético clásico con un átomo cuántico, queremos explorar las consecuencias de que la frecuencia del campo casi coincida con la diferencia de energía entre un par de niveles atómicos (fenómeno de cuasirresonancia), al que llamaremos *átomo de 2 niveles*.

#diagram(cell-size: 15mm, $
        hbar wa edge() & ka
        & edge("d", omega,"<|-|>")\
        hbar wb edge() & kb
$)

El átomo de 2 niveles se caracteriza por un estado base $kb$ y el estado excitado $ka$, con energías $hbar wb$ y $hbar wa$, respectivamente. Exploraremos el caso donde el átomo intercatúa con un campo eléctrico dado por una onda senosoidal

$ vecb(E)(t) = vecb(E)_0 cos(nu t) $

siendo $nu$ la frecuencia de la radiación del campo y $vecb(E)_0 = vecop(e) E_0$, donde $vecop(e)$ es el vector unitario de polarización del campo.

Para simplificar la derivación, procederemos utilizando los estados sin considerar ninguna representación. Tomamos el Hamiltoniano @eq01:field-hamiltonian2 para la ecuación de Schrödinger dependiente del tiempo de la interacción

$ i hbar dv(,t) kPsi = [H0 + HI] kPsi $ <eq01:total-dep-schrodinger>

y usamos las soluciones @eq01:free-dep-state de la ecuación de Schrödinger dependiente del tiempo del átomo libre como base conveniente para descomponer a la función de onda de la interacción

$ kPsi = Ca ea ka + Cb eb kb $ <eq01:total-dep-state>

con $omega_i = E_i / hbar$. Al sustituir @eq01:total-dep-state en @eq01:total-dep-schrodinger obtenemos del lado izquierdo

$
  i hbar dv(,t) kPsi
  &= i hbar dv(,t) (Ca ea ka + Cb eb kb) \
  &= i hbar [(dv(C_a,t) - i wa C_a) ea ka + (dv(C_b,t) - i wb C_b) eb kb]
$ <eq01:total-dep-schrodinger-left>

Y del lado derecho, como $H0$ es un operador lineal que actúa solamente sobre los estados $ket(n)$ y no sobre funciones de tiempo, entonces no afecta a los términos $C_n (t)$ ni $e^(-i omega_n t)$. Además, $ka$ y $kb$ cumplen con la ecuación de eigenvalores de $H0$ @eq01:free-eigenfunction, entonces

$
  [H0 &+ HI] kPsi \
  &= H0(C_a ea ka + C_b eb kb) + HI(C_a ea ka + C_b eb kb) \
  &= Ea C_a ea ka + Eb C_b eb kb + HI(C_a ea ka + C_b eb kb)
$ <eq01:total-dep-schrodinger-rigth>

Considerando que $E_n = hbar omega_n$, el término $i hbar (-i omega_n C_n)$ de @eq01:total-dep-schrodinger-left se convierte en $hbar omega_n C_n = E_n C_n$ y se cancela con los dos primeros términos de @eq01:total-dep-schrodinger-rigth, dejándonos con

$ i hbar (dv(C_a,t) ea ka + dv(C_b,t) eb kb) = HI(C_a ea ka + C_b eb kb) $ <eq01:total-dep-schrodinger2>

Ahora bien, si proyectamos sobre el estado $ka$, es decir, multiplicamos toda la ecuación por $bra(a)$, tenemos

$ i hbar dv(C_a,t) ea = C_a ea braket(a,HI,a) + C_b eb braket(a,HI,b) $

Recordemos que 
$ HI = -vecop(d) dot E(t) = -qe E_0 (vecb(r) dot vecop(e)) cos nu t $

y, además, por paridad de las funciones de onda, el elemeto diagonal $braket(a,HI,a)$ es cero. Por lo tanto

#let eab = $e^(-i omega t)$
#let dab = $"d"_(a b)$
#let dba = $"d"_(b a)$
#let ca = $c_a (t)$
#let cb = $c_b (t)$
#let rabi = $Omega_R$
$ &i hbar dv(C_a,t) ea = C_b eb braket(a,HI,b) $
$
  ==> i hbar dv(C_a,t) &= C_b e^(i wa t) eb braket(a,HI,b)
                      = C_b e^(-(wa - wb)t) braket(a,HI,b) \
                      &= C_b eab (-E_0 cos nu t) qe braket(a,vecb(r),b) dot vecop(e) \
                      &equiv C_b e^(i nu t) (- dab E_0 cos nu t)
$

Donde definimos el elemento de matriz dipolar $dab = qe braket(a,vecb(r),b) dot vecop(e) = dba^*$. Finalmente, aplicamos la expansión del coseno $cos nu t = (e^(i nu t) + e^(-i nu t))/2$

$
  i hbar dv(C_a,t) &= -(dab E_0)/2 Cb eab (e^(i nu t) + e^(-i nu t)) \
  &= -(dab E_0)/2 Cb [e^(i(omega + nu)t) + e^(i(omega - nu)t)]
$

Realizando un procedimiento análogo en donde proyectamos la ecuación @eq01:total-dep-schrodinger2 sobre el estado $kb$, obtenemos el siguiente par de ecuaciones diferenciales acopladas

$
  &i hbar dv(C_b,t) = -(dab E_0)/2 Ca [e^(-i(omega + nu)t) + e^(-i(omega - nu)t)] \
  &i hbar dv(C_a,t) = -(dab E_0)/2 Cb [e^(i(omega + nu)t) + e^(i(omega - nu)t)]
$

en donde aparecen términos que oscilan muy rápido (a frecuencias $omega + nu$) y términos que oscilan lentamente (a frecuencias $omega - nu$). La *Aproximación de Onda Rotante (RWA)* consiste en ignorar los términos que oscilan rápidamente, ya que su efecto promedio sobre largos periodos de tiempo es casi nulo, y nos quedamos solo con los términos de oscilación lenta. \
Bajo esta aproximación, definimos


$
  cb &= Cb/2 e^(-i Delta t) \ 
  ca &= Ca/2 e^(i Delta t)
$

donde $ Delta equiv (wa - wb) - nu = omega - nu $ es la *desintonía* entre la diferencia de energía entre los niveles, y la frecuencia de radiación del campo; y la *Frecuencia de Rabi*,

$ rabi = abs((-dab E_0)/2) $

obteniendo

$
  dv(,t) cb &= -i/2 [-Delta ca + rabi ca] \
  dv(,t) ca &= -i/2 [Delta ca + rabi cb]
$ <eq01:rabi-eq-system>

Podemos escribir @eq01:rabi-eq-system en su forma matricial

$
  dv(,t) vec(cb, ca) = -i/2
  mat(
    -Delta, rabi;
    rabi^*, Delta
  )
  vec(cb, ca)
$ <eq01:rabi-matrix-system>

cuyos eigenvalores de @eq01:rabi-matrix-system son $-+ Omega$, donde

$ Omega = sqrt(Delta^2 + rabi^2) $

es la *Frecuencia de Rabi generalizada*, la cual notemos que incluye el efecto de desintonía, $Delta$, que relaciona la diferencia de energía entre niveles y la frecuencia de radiación del campo $E(t)$.

La solución del sistema @eq01:rabi-matrix-system es

#let arg = $(Omega t)/2$
$
  vec(cb, ca) =
  mat(
    cos(arg)+(i Delta)/Omega sin(arg), -i(E_0 dba)/(Omega hbar) sin(arg);
    -i(E_0 dba)/(Omega hbar) sin(arg), cos(arg)-(i Delta)/Omega sin(arg)
  )
  vec(c_b (0), c_a (0))
$

Y si establecemos las condiciones iniciales como $c_b (0)=1$, $c_a (0)=0$ (el sistema se encuentra en el estado base), la probabilidad de transición entre estados, de $kb$ a $ka$ es

$ |ca|^2 = ((Delta^2 - rabi^2)/ Omega^2) sin^2(arg) $









// ===================================================================
=== Átomo de 3 niveles (Scully-Zubary) <sec01:3-niveles>
#let H0 = $hat(H)_0$
#let HI = $hat(H)_I (t)$
#let completez = $ketbra(a) + ketbra(b)$
#let ka = $ket(a)$
#let kb = $ket(b)$
#let kc = $ket(c)$
Para estudiar el caso del átomo de 3 niveles, obtendremos el Hamiltoniano RWA como una generalización del Hamiltoniano del átomo de 2 niveles interactuando con un campo clásico a una sola frecuencia, presentado en la sección anterior, y lo aplicaremos para analizar un átomo de 3 niveles interactuando con un campo clásico a dos frecuencias distintas, considerando sus tres configuraciones posibles: cascada, lambda ($Lambda$) y Vee ($"V"$).

Para ello, tomemos el Hamiltoniano de la @sec01:atomo-campo

$ hat(H) = H0 + HI $

Usando la relación de completez $completez = bb(1)$, escribimos $H0$ como

$
  H0
  &= (completez) H0 (completez)\
  &= hbar wa ketbra(a) + hbar wb ketbra(b)
$

donde usamos la propiedad $H0 ka = hbar wa ka$ y $H0 kb = hbar wb kb$. De forma similar, escribimos a $HI$ como

$
  HI
  &= -e (completez) vecb(r) (completez) vecb(E)(t)\
  &= -(dab ketbra(a,b) + dba ketbra(b,a)) vecb(E)(t)
$

==== Lambda $Lambda$
#let bombeo = $Omega_p$
#let sonda = $Omega_s$

En el átomo de 3 niveles en configuración Lambda, tenemos dos estados base, $kb$ y $kc$, y un estado excitado $ka$. Este átomo presenta superposición coherente, es decir, puede existir en un estado que es una superposición de sus niveles base

$ ket(Psi_("coherente")) = c_b kb + c_c kc $

y donde la relación de fase entre los coeficientes $c_b$ y $c_c$ está bien definida y se mantiene estable en el tiempo. Esto quiere decir que es un único estado cuántico donde el átomo está, en cierto sentido, en ambos estados a la vez y con una fase relativa fija.

Ahora tomemos nuestro átomo $Lambda$ y consideremos dos campos con respectivas frecuencias $nu_1$ y $nu_2$
