// ===================================================================
// 04_1at4lvl.typ
// ===================================================================
#import "../style.typ": *

=== Átomo de tres niveles <sec:1at4lvl>

Ahora que hemos explicado la dinámica de los sistemas aislados, se procede a estudiar la respuesta de un único átomo de tres niveles ($kg <-> ke <-> ks$) dentro de la cavidad óptica bombeada. En la práctica, la excitación directa desde el estado base $kg$ hasta un estado altamente excitado de Rydberg $ks$ presenta ciertas dificultades, pues generalmente este proceso requiere láseres de alta potencia y frecuencias específicas, lo que puede resultar en una implementación experimental complicada.

Para superar esta limitación, se recurre a excitaciones de múltiples fotones en configuración cascada, en donde se acopla el estado base $kg$ con el estado de Rydberg $ks$ a través del estado intermedio $ke$. Sin embargo, el costo de esta técnica es el rápido decaimiento espontáneo asociado al nivel $ke$ ($dece$), el cual destruye la coherencia del sistema antes de que las interacciones de Rydberg puedan expresarse.

En esta sección se discute paso a paso los fenómenos físicos que surgen de esta configuración, comenzando con modelos simples que nos aportan intuición sobre los efectos de átomos en cavidades, y finalmente se plantea un caso particular para suprimir la decoherencia del nivel intermedio.

Como primer paso, consideramos una configuración tal que al modo de la cavidad se le aplica un barrido de desintonía del láser de prueba, $Dpa$, acoplando la transición inferior $kg <-> ke$, y considerando que el láser de control y la transición superior $ke <-> ks$ están en perfecta resonacia ($Dac = 0$), como se muestra en la @fig:1at3lvl_sistema.

#{
  let hg = 2.5
  let he = 1.6
  let hs = 0
  let d = 0.3
  figure(diagrama(
    cell-size: 1mm,
    mark-scale: 130%,
    edge((0,hg),(2,hg)),
    node((2,hg), $kg$),
    edge((0.5,hg),(0.5,he+d), "<->", $wp$, label-side: right, "wave"),
    edge((-0.5,he+d),(1.5,he+d), "--"),
    edge((-0.2,he+d),(-0.2,he),"<->", label-side: left, $Dpa$),
    edge((0,he),(2,he)),
    node((2,he), $ke$),
    edge((0,hs),(2,hs)),
    node((2,hs), $ks$),
    edge((0.5,hs),(0.5,he), "<->", $wc$, label-side: left, "wave")
  ),
  caption: [Diagrama de la interacción de un átomo de tres niveles en resonancia con un campo de control $rabic$ en la transición $ke <-> ks$, y con un campo de prueba $rabip$ en desintonía $Dpa$ con $kg <-> ke$.]
)} <fig:1at3lvl_sistema>

El subespacio de Hilbert para este sistema ahora considera la presencia de la cavidad y un átomo de 3 niveles, $HHc ** HHa$, con dimensión $3 nmax$. El Hamiltoniano queda como la suma de los Hamiltonianos considerados en @sec:1at2lvl y @sec:cavidad (@eq:1at2lvl_H, @eq:cavidad_Hc y @eq:cavidad_Hb):

$ hat(H) = Ha + Hi + Hc + Hb $ <eq:1at3lvl_hamtotal>

y a $Hi$ se le agrega el término de acoplamiento átomo-cavidad, reposicionando al láser de control $rabic$ para aplicarse a los niveles $ke <-> ks$:

$ Hi = hbar g (sig(g,e) cre + sig(e,g) anh) - hbar/2 rabic (sig(s,e) + sig(e,s)). $

Luego, la ecuación maestra de Lindblad considera los efectos de disipación de la cavidad ($kappa$) y decaimiento de los niveles $ke$ y $ks$ ($dece$ y $decs$, respectivamente):

$ dot(rr) = -i[hat(H), rr] + kappa/2 LL[anh] + dece/2 LL[sig(g,e)] + decs/2 LL[sig(e,s)] $ <eq:1at3lvl_maestra>

Para analizar esta dinámica, se simuló el sistema utilizando la @eq:1at3lvl_maestra hasta alcanzar su estado estacionario, con condiciones iniciales $rr (t_(=0)) = ketbra(0 0,0 0)$, y se realizó un barrido de la desintonía del bombeo, $Dpa$, para observar el comportamiento de los estados excitados y la población de fotones en la cavidad.

La dinámica se dividirá en tres tipos de análisis, los dos primeros dados por la presencia o ausencia del láser de control clásico en la transición $ke <-> ks$, y el último por una desontía $Dpa$ muy grande, como a continuación se detalla.

==== Desdoblamiento _vacuum Rabi_ <sec:vacuum_rabi>

Procederemos a estudiar el sistema átomo-cavidad en la configuración más simple, que corresponde al láser de control apagado $rabic=0$. En este régimen, y asumiendo que el bombeo de la cavidad es suficientemente débil para no lograr poblar el estado $ks$ a través de estados virtuales, el sistema es reducido a un átomo de 2 niveles $kg <-> ke$ interactuando con el modo de la cavidad. Esta configuración está descrita por el modelo de Jaynes-Cummings, y cuyos fenómenos cambian dependiendo de la relación entre la constante $g$ y las tasas de disipación del sistema $kappa, dece$.

Debido a que la constante de acoplamiento átomo-cavidad es mayor que las tasas de disipación ($g > kappa, dece$), el sistema se encuentra en el régimen de acomplamiento fuerte.

Considerando el caso de la sección anterior donde se analiza la espectroscopía de la cavidad vacía, se esperaría una única resonancia centrada en $Dpa=0$. Sin embargo, la @fig:1at3lvl_sinrabi muestra un desdoblamiento simétrico en dos picos, anulando casi por completo la excitación en la resonancia central, lo que se conoce como _Vacuum Rabi splitting_ @hernandez_vacuum_2007 y es causado por el fuerte acoplamiento átomo-cavidad.

#figure(
  stack(
    dir: ttb,
    spacing: 0em,
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: (top, top),
      [*(a)*],
      image("../assets/figuras/1at3lvl_fotones0.png"),
    ),
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: (top, top),
      [*(b)*],
      image("../assets/figuras/1at3lvl_excitado0.png"),
    ),
  ),
  caption: [*(a)* Número medio de fotones en el estado estacionario *(b)* Probabilidad de ocupación del primer estado excitado $Pe$ (cuadrados) y en el segundo estado excitado $Ps$ (triángulos); en función de la desintonía del láser de prueba $Dpa$, para un átomo de cuatro niveles sometido a un láser de control apagado, donde se muestra un desdoblamiento _Vacuum-Rabi_. Los parámetros utilizados son: $rabip = 0.1$, $rabic = 0.0$, $g = 1.5$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.0$, $nmax = 5$.]
) <fig:1at3lvl_sinrabi>

Debido a que $g > kappa, dece$, el acoplamiento es lo suficientemente grande para que el átomo emita y absorba los fotones de la cavidad coherentemente antes de que la energía sea disipada al entorno. Aunque los estados desnudos $g 1$ (átomo en reposo, 1 fotón) y $e 0$ (átomo excitado, cero fotones), que son eigenestados del hamiltoniano libre, siguen siendo una base válida para describir el sistema, resulta mucho más conveniente analizar la dinámica utilizando la base del Hamiltoniano total acoplado. Al diagonalizar la interacción, los estados desnudos se combinan linealmente para formar un caso particular de estados vestidos (_dressed states_, discutidos en @sec:dressed_states):

$ ket(+-) = 1/sqrt(2) ket(g 1) +- ket(e 0). $

Al considerar esta base, el desdoblamiento puede ser explicado más directamente: estos dos nuevos eigenestados del sistema híbrido tienen energías distintas, separadas por $2 hbar g$, por lo que el láser de prueba ya no es resonante con la cavidad en $Dpa=0$, sino que ahora se acopla a las frecuencias desplazadas correspondientes a los estados vestidos.

Como es de esperarse, la población del nivel superior $ks$ permanece en cero, ya que no existe ningún campo que acople el estado.

==== Interferencia cuántica y EIT <sec:EIT>

A diferencia del sistema de _dos_ niveles anterior, la presencia de más de una fuente de excitación permite que surjan fenómenos de interferencia cuántica y coherencia atómica, tales como la Transparencia Inducida Electromagnética (EIT). En la figura @fig:1at3lvl_conrabi se muestra una alteración en la estructura de los niveles del sistema, como consecuencia de dichos fenómenos.

Al activar el láser de control, se observan ciertas modificaciones en comparación con el _vacuum Rabi splitting_ anterior, explicadas a continuación.

Primero, el desdoblamiento Autler-Townes. Al aplicar el láser de control intenso $rabic$, el átomo oscila rápidamente entre los estados desnudos $ke$ y $ks$. Aunque estos estados son una base del subespacio del átomo, es mejor analizar el sistema en la base de los eigenestados del Hamiltoniano acoplado átomo-láser. Al hacer la diagonalización, como en el caso de la sección anterior, surgen los estados vestidos:

$ ket(N +-) = 1/sqrt(2) (ket(e N) +- ket(s [N+1])) $

y cuyos niveles de energía están desplazados $+- hbar rabic\/2$.

#figure(
  stack(
    dir: ttb,
    spacing: 0em,
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: (top, top),
      [*(a)*],
      image("../assets/figuras/1at3lvl_fotones.png"),
    ),
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: (top, top),
      [*(b)*],
      image("../assets/figuras/1at3lvl_excitado.png"),
    ),
  ),
  caption: [*(a)* Número medio de fotones en el estado estacionario *(b)* Probabilidad de ocupación del primer estado excitado $Pe$ (cuadrados) y en el segundo estado excitado $Ps$ (triángulos); en función de la desintonía del láser de prueba $Dpa$, para un átomo de cuatro niveles sometido a un láser de control de gran intensidad en la transición $ke <-> ks$, que presenta EIT en resonancia $Dpa = 0$ y desdoblamiento de Autler-Townes en el estado $ke$, así como un pico de excitación máxima en el estado $ks$ debido a una transición resonante de dos fotones. Los parámetros utilizados son: $rabip = 0.1$, $rabic = 2.0$, $g = 1.5$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.0$, $nmax = 5$.]
) <fig:1at3lvl_conrabi>

Este fenómeno de Autler-Townes se manifiesta en el espectro de transmisión ensanchando aún más la separación de los picos de absorción, ya que la luz de la cavidad debe satisfacer la condición de resonancia para las nuevas frecuencias desplazadas.

Luego, la formación de _dark state_ y anulación de la absorción en resonancia. En el espectro de excitación se observa una anulación de la población del estadio intermedio $Pe$, cuando la resonancia es total ($Dpa=0$) como resultado de una interferencia cuántica destructiva.

Para que el electrón llegue al estado $ke$, puede tomar un camino directo por acoplamiento al fotón de la cavidad ($kg -> ke$), y uno indirecto inducido por el láser de control ($kg -> ke -> ks -> ke$). En resonancia, las amplitudes de probabilidad de ambos caminos están desfasadas por $180^(degree)$, cancelándose entre sí @fleischhauer_electromagnetically_2005. Debido a ello, el átomo no puede absorber fotones de la cavidad en ese punto, volviéndose ópticamente transparente (EIT), y deja de disipar la energía de la cavidad, permitiendo que el bombeo externo lo llene nuevamente de manera eficiente @mucke_electromagnetically_2010.

De manera simultánea, la población del estado superior $Ps$ (curva beige), muestra un pico máximo exactamente en el punto de transparencia de $Pe$. Aunque el estado $ke$ está bloqueado por la transparencia, el sistema en conjunto cumple la condición de resonancia para una transición simultánea de dos fotones @bharti_wavelength_2016, uno dado por la cavidad y otro por el láser de control. El electrón es transferido de forma directa desde el estado base $kg$ hasta el estado de Rydberg $ks$ sin poblar el nivel intermedio.

Es importante mencionar que, a diferencia de la configuración $Lambda$ en que los dos estados base suelen ser estables, en sistemas cascada el estado $ks$ decae emitiendo un fotón, lo que destruye la coherencia y diluye la transparencia @khan_role_2016. Sin embargo, como $decs << dece$ (i.e. asumimos un modelo de átomos de Rydberg), el estado altamente excitado $ks$ tiene un tiempo de vida suficiente para sentir el bloqueo antes de que el átomo caiga espontáneamente, permitiendo que la coherencia sobreviva, y por tanto que existan _dark states_ metaestables y una transparencia casi total @geabanacloche_electromagnetically_1995.