// ===================================================================
// 03_formulacion_sistema.typ
// ===================================================================
#import "../style.typ": *


=== Descripción del sistema físico <descripcion-sistema>
// operadores
#let Ha = $hat(H)_"atomos"$ //hamiltoniano atomos
#let Hb = $hat(H)_"bombeo"$ //hamiltoniano bombeo
#let Hc = $hat(H)_"cavidad"$ //hamiltoniano cavidad
#let Hi = $hat(H)_"interaccion"$ //hamiltoniano interaccion
#let Hdr = $hat(H)_"DR"$ //hamiltoniano dipolo resonante
#let Hee = $hat(H)_"EE"$ //hamiltoniano dipolo de intercambio
#let cre = $hat(a)^dagger$ //creacion
#let anh = $hat(a)$ //aniquilacion
#let rr = $hat(rho)$
#let sig(ii,jj,at) = $sigma_(ii jj)^((at))$ //sigma
// kets
#let kg = $ket(g)$ //g
#let ke = $ket(e)$ //e
#let ks = $ket(s)$ //s
#let kp = $ket(p)$ //p
// parámetros
#let wp = $omega_p$ //frecuencia prueba
#let wc = $omega_c$ //frecuencia control
#let weg = $omega_(e g)$ //distancia eg
#let wse = $omega_(s e)$ //distancia se
#let wps = $omega_(p s)$ //distancia ps
#let Dba = $Delta_(p e g)$ //detuning bombeo-atomo
#let Dal = $Delta_(c s e)$ //detuning atomo-control
#let dece = $gamma_e$ //decaimiento e->g
#let decs = $gamma_s$ //decaimiento s->e
#let dec12 = $gamma_(12)$ //decaimiento colectivo
#let rabip = $Omega_p$ //rabi prueba
#let rabic = $Omega_c$ //rabi control
#let Odr = $Omega_"12"$ //
#let Oee = $d^2$ //elemento de matriz dipolar


El sistema que se estudia en este trabajo está conformado por dos átomos idénticos de cuatro niveles, confinados dentro de una cavidad óptica de un solo modo permitido. Los niveles de energía de los átomos se encuentran en configuración de cascada, y como los siguientes estados:
- $kg$: estado fundamental
- $ke$: primer estado excitado
- $ks$: segundo estado
- $kp$: estado altamente excitado (Rydberg)

Para la dinámica del sistema se usan dos campos externos: un láser de prueba cuya naturaleza es un bombeo que inyecta fotones a la cavidad a frecuencia $wp$ y es considerado cuántico, y un láser de control clásico de intensidad constante y frecuencia $wc$ que acopla los niveles $ke$ y $ks$. La cavidad, a su vez, acopla la transición entre los niveles $kg$ y $ke$. La configuración descrita anteriormente queda representada en la @fig:sistema. No existe ningún campo externo que acople directamente los niveles $ks$ y $kp$, pero la dinámica de este último nivel estará únicamente determinada por las interacciones interatómicas, que se modelan a través de términos de interacción de tipo dipolar y de tipo de intercambio.

#figure(
  diagram(cell-size: 1mm,
          mark-scale: 130%,
          edge((0,3),(1,3)),
          edge((0.5,3),(0.5,2), "<|-|>", $hbar weg$, label-side: right),
          edge((0.1,3),(0.1,2.1), "->", $hbar wp$, label-side: left, "wave"),
          edge((0,2),(1,2)),
          edge((0.5,2),(0.5,1), "<|-|>", $hbar wse$, label-side: right),
          edge((0.1,2),(0.1,1.1), "->", $hbar wc$, label-side: left, "wave"),
          edge((0,1),(1,1)),
          edge((0.5,1),(0.5,0.5), "<|-|>", $hbar wps$, label-side: right),
          edge((0,0.5),(1,0.5)),
          
          edge((2,3),(3,3)),
          node((3,3), $kg$),
          edge((2.4,2.8),(2.4,2.1), "<-", $dece$, label-side: left, "wave"),
          edge((2,2),(3,2)),
          node((3,2), $ke$),
          edge((2.4,1.8),(2.4,1.1), "<-", $decs$, label-side: left, "wave"),
          edge((2,1),(3,1)),
          node((3,1), $ks$),
          edge((2,0.5),(3,0.5)),
          node((3,0.5), $kp$),
  ),
  caption: [Diagrama de la interacción de un átomo de cuatro niveles con un campo de prueba con frecuencia $wp$ que acopla los niveles $kg -> ke$ y un campo de control con frecuencia $wc$ que acopla $ke -> ks$, así como decaimientos espontáneos $decs$ y $dece$ entre los niveles $ks -> ke$ y $ke -> kg$, respectivamente.]
) <fig:sistema>


==== Construcción del Hamiltoniano


Bajo la aproximación de onda rotante (RWA), el Hamiltoniano total que describe la dinámica del sistema anterior se puede escribir como la suma de las contribuciones individuales de cada átomo y de interacción entre ellos y con los campos externos:

$ hat(H) = Hc + Hb + Ha + Hi + Hdr + Hee $

A continuación, se detalla el significado físico de cada uno de estos términos.

===== Dinámica de la cavidad y el campo de bombeo

El campo EM de la cavidad se modela como un oscilador armónico cuántico. El Hamiltoniano libre de la cavidad, en un marco de referencia que rota a la frecuencia del láser de prueba (bombeo), queda escrito como:

$ Hc = hbar Dba (cre anh + 1/2) $

donde $anh$ y $cre$ son los operadores de creación y aniquilación de fotones, respectivamente, y $Dba = omega_"p" - omega_"se"$ es la desintonía (detuning) entre la frecuencia del campo de prueba y la distancia entre los niveles $ke$ y $ks$.

Luego, la inyección de fotones al sistema de la cavidad se describe mediante el Hamiltoniano de bombeo:

$ Hb = hbar rabip (cre - anh) $

donde $rabip$ representa la intensidad (frecuencia de Rabi) del campo de prueba.


===== Energía atómica y acoplamiento átomo-láser

La interacción de los átomos con los campos EM, dado por $Hi$ consta de dos partes: el acoplamiento cuántico con el modo de la cavidad y el acoplamiento clásico con el láser de control. Para el átomo $j$-ésimo, con $j=1,2$, se tiene.

$ Hi_(,j) = hbar g (sig(g,e,j) cre + sig(e,g,j) anh) - hbar rabic/2 (sig(e,s,j) + sig(s,e,j)) $

Aquí, $g$ es la constante de acoplamiento átomo-cavidad, que dicta el intercambio de excitaciones entre la cavidad y la transición $kg <-> ke$, mientras que $rabic$ es la intensidad del láser de control clásico aplicado a la transición $ke <-> ks$.

El Hamiltoniano libre para los dos átomos ($Ha = hat(H)_(A 1) + hat(H)_(A 1)$) está dado por la suma de las energías de cada nivel atómico:

$ hat(H)_(A,j) = E_g sig(g,g,j)+ E_e sig(e,e,j) + E_s sig(s,s,j) + E_p sig(p,p,j) $

donde las energías relativas de los niveles atómicos dependen de las desintonías del sistema ($Dba$, $Dal$), siendo
- $E_g = 0$ (nivel de referencia)
- $E_e = E_g + hbar (Dba + Dal)$
- $E_s = E_e + hbar$
- $E_p = E_s + hbar $

===== Acoplamiento interatómiico y términos de interacción

Cuando dos átomos se encuentran a distancias cortas, la interacción dipolo-dipolo modifica significativamente sus niveles de energía [CITAR AKI]. En este modelo, se consideran dos mecanismos de interacción interatómica.

El primer término, $Hdr$, describe el intercambio resonante de excitaciones en la transición inferior ($kg <-> ke$), y permite que una excitación salte de un átomo a otro de manera no radiativa:

$ Hdr = hbar Odr/R^3 (ketbra(e g,g e) + ketbra(g e,e g)) $

El segundo término, $Hee$, es muy importante para este trabajo, ya que modela la fuerte interacción inducida cuando los átomos alcanzan niveles superiores:

$ Hee = hbar Oee (ketbra(p s,s p) + ketbra(s p,p s)) + ketbra(s s, p p) + ketbra(p p, s s)) $

donde $Oee$ es el elemento de matriz dipolar y representa la fuerza de interacción que acopla los estados doblemente excitados. Físicamente, esta interacción provoca un desplazamiento drástico en los niveles de energía del estado colectivo [CITAR AKI]. Si este desplazamiento es mucho mayor que el ancho de línea de la excitación, la absorción del segundo fotón se vuelve energéticamente prohibida, dando lugar al fenómeno de bloqueo de excitación, y se manifiesta como una supresión de los estados doblemente excitados $ket(s s)$ y $ket(p p)$ cuando la interacción es suficientemente fuerte ($Oee >> rabic$).


==== Incorporación de la disipación y decaimiento

#let LL = text(style: "italic")[L]
#let OO = text(style: "italic")[$hat(O)$]

Debido a que el sistema es abierto, ya que los espejos de la cavidad no son perfectos y los átomos intercatúan con el entorno, es necesario incluir los procesos de pérdida de fotones de la cavidad y el decaimiento atómico espontáneo. Estas pérdidas de energía se introducen utilizando el formalismo de la Ecuación Maestra de Lindblad para la matriz densidad $rr$:

$ dot(rr) = -i [hat(H),rr] + kappa LL[a] + sum_(j = 1,2) (dece/2 LL[sig(g,e,j)] + decs/2 LL[sig(e,s,j)]) + dec12/2 LL[sig(g,e,1) + sig(g,e,2)] $

donde el superoperador de Lindblad $LL$ se define como $LL[OO] = 2 OO rr OO^dagger - OO^dagger OO rr - rr OO^dagger OO$


El término proporcional a $kappa$ modela la fuga de fotones a través de los espejos de la cavidad, mientras que los términos con $dece$ y $decs$ representan el decaimiento espontáneo individual de cada átomo en las transiciones $ke <-> kg$ y $ks <-> ke$, respectivamente.

Cuando la distancia entre los átomos es menor que la longitud de onda de la transición $kg <-> ke$, los átomos pueden emitir fotones de manera correlacionada [CITAR AKI]. Esto se incluye mediante un término de decaimiento colectivo, $dec12$, el cual actúa sobre el operador de salto conjunto $(sig(g,e,1) + sig(g,e,2))$, generando efectos de superrradiancia o subradiancia en el sistema.