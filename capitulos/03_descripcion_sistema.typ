// ===================================================================
// 03_formulacion_sistema.typ
// ===================================================================
#import "../style.typ": *

En este capítulo se establece la formulación matemática dos átomos de cuatro niveles ($kg, ke, ks, kp$) en configuración cascada interactuando entre sí dentro de una cavidad óptica y con la cavidad misma.

Se hace la construcción del Hamiltoniano total como la suma de las contribuciones de los Hamiltonianos de los subsistemas que lo componen, incluyendo las aportaciones energéticas individuales y los acoplamientos entre los subsistemas, y aplicando las condiciones disipativas que muestran la interacción del sistema con su entorno.

Debido a que en los sistemas cuánticos de varios niveles es difícil encontrar soluciones analíticas exactas, esta tesis utiliza un enfoque numérico para resolver el modelo que a continuación se formula. En la @sec:implem-numerica de este capítulo se detallan las técnicas numéricas utilizadas para resolver la ecuación maestra del sistema, describiendo el algoritmo de la simulación y las herramientas usadas.


=== Descripción del sistema físico <sec:descripcion-sistema>


El sistema que se estudia en este trabajo está conformado por dos átomos idénticos de cuatro niveles, confinados dentro de una cavidad óptica de un solo modo. Los niveles de energía de los átomos se encuentran en configuración de cascada (@fig:sistema), y como los siguientes estados:
- $kg$: estado base
- $ke$: estado intermedio
- $ks$: estado altamente excitado (Rydberg)
- $kp$: estado auxilar

Para la dinámica del sistema se usan dos campos externos: un láser de prueba débil de intensidad $rabip$ cuya caracterísitica es ser un bombeo que inyecta fotones a la cavidad a frecuencia $wp$; y un láser de control clásico de intensidad fuerte $rabic$ y frecuencia $wc$ que acopla los niveles $ke$ y $ks$, con desintonía entre la frecuencia del campo y la frecuencia de transición de $Dac = wc - wse$. El láser de prueba, a su vez, acopla la transición entre los niveles $kg$ y $ke$, con desintonía $Dpa = wp - weg$.

Además, los átomos descaen espontáneamente de los niveles $ks$ y $ke$ con tasas de decaimiento de $decs$ y $dece$, respectivamente.

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
  caption: [Diagrama de la interacción de un átomo de cuatro niveles con un campo de prueba con frecuencia $wp$ que acopla los niveles $kg -> ke$ con desintonía $Dpa$, y un campo de control con frecuencia $wc$ que acopla $ke -> ks$ y desintonía $Dac$, así como decaimientos espontáneos $decs$ y $dece$ entre los niveles $ks -> ke$ y $ke -> kg$, respectivamente.]
)} <fig:sistema>

La configuración descrita anteriormente queda representada en la @fig:sistema. Nótese que no existe ningún campo externo que acople directamente los niveles $ks$ y $kp$, pero la población de este último nivel estará únicamente determinada por las interacciones interatómicas, que se modelan a través de términos de interacción de tipo dipolar y de tipo de intercambio.


==== Construcción del Hamiltoniano


A partir del sistema descrita anteriormente, se construye el operador Hamiltoniano total $hat(H)$. Este operador es el responsable de la evolución unitaria del sistema; se descompone como la suma de la energía de la cavidad, las contribuciones individuales de cada átomo y la interacción entre ellos y con los campos externos.

Bajo la aproximación de onda rotante (RWA), $hat(H)$ queda escrito como:

$ hat(H) = Hc + Hb + Haa + Hi + Hdr + Hee. $ <eq:hamiltoniano_total>

A continuación, se detalla la expresiónon matemática de cada uno de estos términos:

- El campo electromagético de la cavidad se modela como un oscilador armónico cuántico, por lo que para modelar su dinámica usaremos el Hamiltoniano de Jaynes-Cummings descrito en @eq:ham_jaynescummings. Asumiremos que el sistema se encuentra en un marco de referencia que rota a la frecuencia del láser de prueba, por lo que $weg$ queda en términos de $Dpa$, y $w=wp$ en términos de su desintonía con la cavidad. Sin embargo, como estamos asumiendo que la cavidad y el átomo están en resonancia perfecta, esta desintonía es exactamente $Dpa$.

  Por tanto, el Hamiltoniano de la cavidad queda descrito de la siguiente forma:

  $ Hc = hbar Dpa cre anh $

  donde se han reacomodado los otros términos a sus respectivos Hamiltonianos atómicos y de interacción.

- La inyección de fotones al sistema de la cavidad se describe mediante el Hamiltoniano de bombeo:

  $ Hb = i hbar rabip (cre - anh). $

- La interacción de los átomos con los campos electromagnéticos, dado por $Hi$, consta de dos partes: el acoplamiento cuántico con el modo de la cavidad ($Hca$) y el acoplamiento clásico con el láser de control #footnote[Al Hamiltoniano expresado en @eq:ham_luzmateria se le aplica una transformación unitaria para moverse en un marco rotante a la frecuencia del láser de control, lo que hace que las matrices sean constantes en el tiempo y facilita la simulación. Esto provoca que la dependencia temporal de estos Hamiltonianos esté absorbida en las energías diagonales del átomo, expresadas en desintonías, y por esa razón aparecen en $Ha$.] ($Hla$). Para el átomo $k$-ésimo, con $k=1,2$, se tiene:

  $ Hi_(,k) &= Hca + Hla \
    &=hbar g (sigk(g,e,k) cre + sigk(e,g,k) anh) - hbar rabic/2 (sigk(e,s,k) + sigk(s,e,k)). $

  donde, $g$ es la constante de acoplamiento átomo-cavidad y $sigk(i,j,k)$ el operador $ketbra(i,j)$ del átomo $k$.

- El Hamiltoniano libre para los dos átomos ($Haa = hat(H)_(A 1) + hat(H)_(A 1)$) está dado por la suma de las energías de cada nivel atómico:

  $ hat(H)_(A,k) = E_g sigk(g,g,k)+ E_e sigk(e,e,k) + E_s sigk(s,s,k) + E_p sigk(p,p,k) $

  donde las energías relativas de los niveles atómicos dependen de las desintonías del sistema ($Dpa$, $Dac$), y
  - $E_g = 0$
  - $E_e = hbar Dpa$
  - $E_s = hbar (Dpa + Dac)$
  - $E_p = E_s $

- Como se mencionó en @sec:bloqueo_rydberg, la interacción dipolo-dipolo $Wdd$ entre dos átomos acopla pares de estados con distinta paridad. En el modelo de cuatro niveles, esta interacción se divide en dos Hamiltonianos:

  - $Hdr$, describe el intercambio resonante de excitaciones en la transición inferior $kg <-> ke$, es decir, que una excitación salte de un átomo a otro entre ese par de niveles:

    $
    Hdr &= hbar Cdr/R^3 (sigk(g,e,1)^dagger ** sigk(g,e,2) + sigk(g,e,1) ** sigk(g,e,2)^dagger) \
      &= hbar Cdr/R^3 (ketbra(e g,g e) + ketbra(g e,e g))
    $

    donde $Cdr$ es la fuerza de interacción del intercambio y $R$ la distancia interatómica.

  - $Hee$, describe el intercambio resonante en la transición $ks <-> kp$ y es muy importante para este trabajo, ya que modela la fuerte interacción cuando los átomos alcanzan el nivel altamente excitado:

    $
    Hee &= hbar Cee/R^3 (sigk(s,p,1) + sigk(s,p,1)^dagger) ** (sigk(s,p,2) + sigk(s,p,2)^dagger) \
      &= hbar Oee (ketbra(p s,s p) + ketbra(s p,p s)) + ketbra(s s, p p) + ketbra(p p, s s))
    $

    #{
      let gg = 3
      let gs = 1.5
      let ss = 0
      let d = 0.5
      let sep = 0.5
      let L = 1
      figure(diagrama(
        cell-size: 1mm,
        mark-scale: 130%,
        //diagrama 1
        //niveles
        edge((-2 -L,gg -sep),(-2 -L/2,gg -sep)),
        edge((-2 -L,ss+sep),(-2 -L/2,ss+sep), $kss$),
        edge((-1 -L,ss+sep),(-1 -L/2,ss+sep), $kpp$),
        //laseres
        edge((-2 -L+0.1,gg -sep),(-2 -L+0.1,ss+sep), "-|>", "wave"),
        edge((-2 -L/2 -0.2,ss+sep+0.1),(-1 -L + 0.2,ss+sep+0.1), bend:-40deg, "<=>", $Wdd$),

        edge((-1.5,gs),(-1,gs), "=>"),

        //diagrama 2
        //niveles
        edge((0,gg),(L,gg)),
        edge((0,gs),(L,gs)),
        edge((0,ss),(L,ss), "--"),
        node((-0.5,gg), $ket(g g)$),
        node((-0.5,gs), $ket(g s), ket(s g)$),
        node((-0.5,ss), $kss$),
        //distancias energias
        edge((0,ss),(L,ss -d), bend: -10deg),
        edge((0,ss),(L,ss+d), bend: 10deg),
        edge((L,ss),(L,ss -d), "-", $Delta E$),
        node((L -0.2,ss -d - 0.2), $Oee$),
        node((L -0.2,ss +d + 0.2), $-Oee$),
        //laseres
        edge((L/4,gg),(L/4,gs), "-|>", "wave"),
        edge((L/4,gs),(L/4,ss), "-|>", "wave")
      ),
      caption: [Diagrama de desdoblamiento simétrico del nivel de energía $kss$ debido a la presencia de $kpp$ y la interacción dipolo-dipolo $Wdd$.]
    )} <fig:desdoblamiento>

    donde $Cee prop d^2$ y $Oee = Cee\/R^3$. Notemos que aquí es donde toma presencia el nivel auxilar $kp$.
    
    Para modelar el bloqueo de excitación en este trabajo se implementa una resonancia de Föster inducida. Al introducir el cuarto nivel $kp$, cuya energía es igual a la de $ks$ pero con paridad opuesta y tal que no hay ningún láser externo sintonizado para poblarlo, se genera una degeneración entre ambos estados en cada uno de los átomos. Debido a la interacción dipolo-dipolo, se puede acoplar fuertemente el estado $kss$ de los átomos con el estado $kpp$ sin emitir fotones, puesto que la energía total se conserva:

    $ E_s^((1)) + E_s^((2)) = E_p^((1)) + E_p^((2)) $

    cumpliendo así la resonancia de Föster. Luego, el acoplamiento fuerte ocasiona que la energía de $kss$ se desplace simétricamente hacia $+- Oee$ (desdoblamiento Autler-Townes) y, si este desplazamiento es más grande que el ancho de línea del láser ($Oee >> rabic$), el sistema sale de resonancia y el segundo átomo no puede ser excitado, logrando así el bloqueo de Rydberg @gaetan_observation_2009 @pillet_controllable_2009 @vogt_electricfield_2007.


==== Incorporación de la disipación y decaimiento


Debido a que el sistema es abierto, ya que los espejos de la cavidad no son perfectos y los átomos interactúan con el entorno, es necesario incluir los procesos de pérdida de fotones de la cavidad y el decaimiento atómico espontáneo.

Estas pérdidas de energía se introducen utilizando el formalismo de la Ecuación Maestra de Lindblad #footnote[Con el objetivo de mantener simple y general la ecuación maestra, en todas las simulaciones descritas en esta tesis se utlizaron unidades naturales, tal que $hbar = 1$.] para la matriz densidad $rr$:

$ dot(rr) = -i/h [hat(H),rr] + kappa LL[anh] + sum_(j = 1,2) (dece/2 LL[sigk(g,e,j)] + decs/2 LL[sigk(e,s,j)]) + dec12/2 LL[sigk(g,e,1) + sigk(g,e,2)] $ <eq:lindblad_total>

donde el superoperador de Lindblad $LL$ se define como $LL[OO] = 2 OO rr OO^dagger - OO^dagger OO rr - rr OO^dagger OO$


El término proporcional a $kappa$ modela la fuga de fotones a través de los espejos de la cavidad, mientras que los términos con $dece$ y $decs$ representan el decaimiento espontáneo individual de cada átomo en las transiciones $ke <-> kg$ y $ks <-> ke$, respectivamente.

Cuando la distancia entre los átomos es menor que la longitud de onda de la transición $kg <-> ke$, los átomos pueden emitir fotones de manera correlacionada y actúan como un sistema colectivo, generando efectos de superrradiancia o subradiancia en el sistema @breuer_theory_2002. Esto se incluye mediante un término de decaimiento colectivo, $dec12$, el cual actúa sobre el operador de salto conjunto $(sigk(g,e,1) + sigk(g,e,2))$.