// ===================================================================
// 03_formulacion_sistema.typ
// ===================================================================
#import "../style.typ": *

    En el presente capítulo se establece la formulación matemática del sistema bajo estudio, que consiste en dos átomos de cuatro niveles en cascada interactuando dentro de una cavidad óptica, realizando la construcción del Hamiltoniano total como la suma de las contribuciones de los Hamiltonianos de los subsistemas que lo componen e incluyendo las aportaciones energéticas individuales y los acoplamientos entre los subsistemas, y formulando finalmente los mecanismos disipativos que dictan la interacción del sistema con su entorno. El objetivo es obtener una descripción analítica que exprese la física de las simulaciones numéricas posteriores.

    Debido a que la complejidad de los sistemas cuánticos de muchos niveles dificulta la búsqueda de soluciones analíticas exactas, esta investigación utiliza un enfoque computacional para la resolución del modelo que a continuación se formula. En la @sec:implem-numerica de este capítulo se detallan las técnicas numéricas utilizadas para resolver la ecuación maestra de Lindblad, describiendo el algoritmo de la simulación y las herramientas computacionales usadas.


=== Descripción del sistema físico <sec:descripcion-sistema>


El sistema que se estudia en este trabajo está conformado por dos átomos idénticos de cuatro niveles, confinados dentro de una cavidad óptica de un solo modo. Los niveles de energía de los átomos se encuentran en configuración de cascada, y como los siguientes estados:
- $kg$: estado base
- $ke$: estado intermedio
- $ks$: estado altamente excitado (Rydberg)
- $kp$: estado de bloqueo

Para la dinámica del sistema se usan dos campos externos: un láser de prueba cuya naturaleza es un bombeo que inyecta fotones a la cavidad a frecuencia $wp$ y es considerado cuántico; y un láser de control clásico de intensidad constante y frecuencia $wc$ que acopla los niveles $ke$ y $ks$, con desintonía (_detuning_) entre la frecuencia del campo y la frecuencia de transición entre los niveles $Dac = wc - wse$.

La cavidad, a su vez, acopla la transición entre los niveles $kg$ y $ke$, con desintonía $Dpa = wp - weg$.

Además, los átomos descaen espontáneamente de los niveles $ks$ y $ke$ con tasas de decaimiento de $decs$ y $dece$, respectivamente.

La configuración descrita anteriormente queda representada en la @fig:sistema. No existe ningún campo externo que acople directamente los niveles $ks$ y $kp$, pero la dinámica de este último nivel estará únicamente determinada por las interacciones interatómicas, que se modelan a través de términos de interacción de tipo dipolar y de tipo de intercambio.

#{
  let hg = 3
  let he = 2
  let hs = 0.5
  let hp = 0
  let d = 0.3
  figure(diagrama(
    cell-size: 1mm,
    mark-scale: 130%,
    //niveles
    edge((0.5,hg),(2,hg)),
    edge((0.5,he),(2,he)),
    edge((0.5,hs),(2,hs)),
    edge((0.5,hp),(2,hp)),
    edge((3,hs),(4,hs)),
    edge((3,hg),(4,hg)),
    edge((3,he),(4,he)),
    edge((3,hp),(4,hp)),
    node((4,hg), $kg$),
    node((4,he), $ke$),
    node((4,hs), $ks$),
    node((4,hp), $kp$),
    //distancias energias
    edge((1.5,hg),(1.5,he), "<|-|>", $hbar weg$, label-side: right),
    edge((1.5,he),(1.5,hs), "<|-|>", $hbar wse$, label-side: right),
    edge((1.5,hs),(1.5,hp), "<|-|>", $hbar wps$, label-side: right),
    //laseres
    edge((1,hg),(1,he +d), "<->", $hbar wp$, label-side: left, "wave"),
    edge((1,he),(1,hs+d), "<->", $hbar wc$, label-side: left, "wave"),
    //deltas
    edge((0.3,he+d),(1.3,he+d), "--"),
    edge((0.3,hs+d),(1.3,hs+d), "--"),
    edge((0.6,he +d),(0.6,he), "<->", $Dpa$, label-side: left),
    edge((0.6,hs +d),(0.6,hs), "<->", $Dac$, label-side: left),
    //decaimientos
    edge((4,he+0.5),(3.6,he+0.2), "<-", $dece$, label-side: left, "wave"),
    edge((4,hs+0.5),(3.6,hs+0.2), "<-", $decs$, label-side: left, "wave"),
  ),
  caption: [Diagrama de la interacción de un átomo de cuatro niveles con un campo de prueba con frecuencia $wp$ que acopla los niveles $kg -> ke$ y un campo de control con frecuencia $wc$ que acopla $ke -> ks$, así como decaimientos espontáneos $decs$ y $dece$ entre los niveles $ks -> ke$ y $ke -> kg$, respectivamente.]
)} <fig:sistema>


==== Construcción del Hamiltoniano


A partir de la dinámica descrita anteriormente, se construye el operador Hamiltoniano total $hat(H)$ del sistema. Este operador es el responsable de la evolución unitaria del mismo y se descompone como la suma de la energía de la cavidad, y las contribuciones individuales de cada átomo y de interacción entre ellos y con los campos externos.

Bajo la aproximación de onda rotante (RWA), $hat(H)$ queda escrito como:

$ hat(H) = Hc + Hb + Haa + Hi + Hdr + Hee. $ <eq:hamiltoniano_total>

A continuación, se detalla el significado físico de cada uno de estos términos.

===== Dinámica de la cavidad y el campo de bombeo

El campo EM de la cavidad se modela como un oscilador armónico cuántico. El Hamiltoniano libre de la cavidad, en un marco de referencia que rota a la frecuencia del láser de prueba (bombeo), queda escrito como #footnote[Al segundo término de @eq:ham_jaynescummings lo movemos de lugar para que quede representado en $Ha$. Además, como asumimos un marco de referencia que rota a la frecuencia del láser de prueba, $w=wp$ queda en términos de la desintonía.]:

$ Hc = hbar Dpa cre anh $

donde $anh$ y $cre$ son los operadores de creación y aniquilación de fotones, respectivamente.

Luego, la inyección de fotones al sistema de la cavidad se describe mediante el Hamiltoniano de bombeo:

$ Hb = i hbar rabip (cre - anh) $

donde $rabip$ representa la intensidad (frecuencia de Rabi) del campo de prueba.


===== Energía atómica y acoplamiento átomo-láser

La interacción de los átomos con los campos EM, dado por $Hi$ consta de dos partes: el acoplamiento cuántico con el modo de la cavidad ($Hca$) y el acoplamiento clásico con el láser de control #footnote[Al Hamiltoniano expresado en @eq:ham_luzmateria se le aplica una transformación unitaria para moverse en un marco rotante a la frecuencia del láser de control, lo que hace que las matrices sean constantes en el tiempo y facilita la simulación. Esto provoca que la dependencia temporal de estos Hamiltonianos esté absorbida en las energías diagonales del átomo, expresadas en desintonías, y por esa razón aparecen en $Ha$.] ($Hla$). Para el átomo $k$-ésimo, con $k=1,2$, se tiene:

$ Hi_(,k) &= Hca + Hla \
  &=hbar g (sigk(g,e,k) cre + sigk(e,g,k) anh) - hbar rabic/2 (sigk(e,s,k) + sigk(s,e,k)). $

Aquí, $g$ es la constante de acoplamiento átomo-cavidad, que dicta el intercambio de excitaciones entre la cavidad y la transición $kg <-> ke$, mientras que $rabic$ es la intensidad del láser de control clásico aplicado a la transición $ke <-> ks$, y $sigk(i,j,k)$ el operador $ketbra(i,j)$ del átomo $k$.

El Hamiltoniano libre para los dos átomos ($Haa = hat(H)_(A 1) + hat(H)_(A 1)$) está dado por la suma de las energías de cada nivel atómico:

$ hat(H)_(A,k) = E_g sigk(g,g,k)+ E_e sigk(e,e,k) + E_s sigk(s,s,k) + E_p sigk(p,p,k) $

donde las energías relativas de los niveles atómicos dependen de las desintonías del sistema ($Dpa$, $Dac$), y
- $E_g = 0$ (nivel de referencia)
- $E_e = hbar Dpa$
- $E_s = hbar (Dpa + Dac)$
- $E_p = E_s $

===== Acoplamiento interatómiico y términos de interacción

Cuando dos átomos se encuentran a distancias cortas, la interacción dipolo-dipolo provoca un desplazamiento en los niveles de energía @pillet_controllable_2009. Para describir correctamente el sistema, es necesario recurrir a dos mecanismos de interacción interatómica.

El primer término, $Hdr$ (dipolar resonante), describe el intercambio resonante de excitaciones en la transición inferior $kg <-> ke$. Ocurre cuando los átomos están en niveles que permiten transferencia de energía interna, es decir, que una excitación salte de un átomo a otro de manera no radiativa:

$
Hdr &= hbar Odr/R^3 (sigk(g,e,1)^dagger ** sigk(g,e,2) + sigk(g,e,1) ** sigk(g,e,2)^dagger) \
  &= hbar Odr/R^3 (ketbra(e g,g e) + ketbra(g e,e g))
$

donde $Odr$ es la fuerza de interacción del intercambio y $R$ la distancia interatómica.

El segundo término, $Hee$ (estados excitados), es muy importante para este trabajo, ya que modela la fuerte interacción inducida cuando los átomos alcanzan niveles superiores. Aunque estos niveles no estén poblados, su existencia aún distorsiona los niveles del estado base @cohentannoudji_atomphoton_2008:

$
Hee &= hbar C3/R^3 (sigk(s,p,1) + sigk(s,p,1)^dagger) ** (sigk(s,p,2) + sigk(s,p,2)^dagger) \
  &= hbar Oee (ketbra(p s,s p) + ketbra(s p,p s)) + ketbra(s s, p p) + ketbra(p p, s s))
$

donde $C3 prop d^2$, siendo $d$ el momento dipolar eléctrico de la transición, que representa la fuerza de interacción que acopla los estados doblemente excitados.

Físicamente, esta interacción provoca un desplazamiento simétrico $Delta E = +- C3/R^3$ en los niveles de energía del estado colectivo @pillet_controllable_2009. Si este desplazamiento es mucho mayor que la frecuencia de Rabi ($C3 >> rabic$), el sistema sale de resonancia @vogt_electricfield_2007 y la absorción del segundo fotón se vuelve energéticamente prohibida, dando lugar al fenómeno de bloqueo de excitación, que se manifiesta como una supresión de los estados doblemente excitados $kss$ y $kpp$. Con la intención de englobar la relación de $C3$ y $R$ en un único parámetro, en esta tesis utilizaremos $Oee = C3/R^3$ para la descripción de este bloqueo.


==== Incorporación de la disipación y decaimiento


Debido a que el sistema es abierto, ya que los espejos de la cavidad no son perfectos y los átomos intercatúan con el entorno, es necesario incluir los procesos de pérdida de fotones de la cavidad y el decaimiento atómico espontáneo.

Estas pérdidas de energía se introducen utilizando el formalismo de la Ecuación Maestra de Lindblad #footnote[Con el objetivo de mantener simple y general la ecuación maestra, en todas las simulaciones descritas en esta tesis se utlizaron unidades naturales, tal que $hbar = 1$.] para la matriz densidad $rr$:

$ dot(rr) = -i/h [hat(H),rr] + kappa LL[anh] + sum_(j = 1,2) (dece/2 LL[sigk(g,e,j)] + decs/2 LL[sigk(e,s,j)]) + dec12/2 LL[sigk(g,e,1) + sigk(g,e,2)] $ <eq:lindblad_total>

donde el superoperador de Lindblad $LL$ se define como $LL[OO] = 2 OO rr OO^dagger - OO^dagger OO rr - rr OO^dagger OO$


El término proporcional a $kappa$ modela la fuga de fotones a través de los espejos de la cavidad, mientras que los términos con $dece$ y $decs$ representan el decaimiento espontáneo individual de cada átomo en las transiciones $ke <-> kg$ y $ks <-> ke$, respectivamente.

Cuando la distancia entre los átomos es menor que la longitud de onda de la transición $kg <-> ke$, los átomos pueden emitir fotones de manera correlacionada y actúan como un sistema colectivo, generando efectos de superrradiancia o subradiancia en el sistema @breuer_theory_2002. Esto se incluye mediante un término de decaimiento colectivo, $dec12$, el cual actúa sobre el operador de salto conjunto $(sigk(g,e,1) + sigk(g,e,2))$.