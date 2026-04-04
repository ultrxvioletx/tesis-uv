// ===================================================================
// 04_1at4lvl.typ
// ===================================================================
#import "../style.typ": *

=== Átomo de tres niveles <sec:1at4lvl>

Ahora que hemos explicado la dinámica de los sistemas aislados, se procede a estudiar la respuesta de un único átomo de tres niveles ($kg <-> ke <-> ks$) dentro de la cavidad óptica bombeada. En la práctica, la excitación directa desde el estado base $kg$ hasta un estado altamente excitado de Rydberg $ks$ presenta ciertas dificultades, pues generalmente este proceso requiere láseres de alta potencia y frecuencias específicas, lo que puede resultar en una implementación experimental complicada.

Para superar esta limitación, se recurre a excitaciones de múltiples fotones en configuración cascada, en donde se acopla el estado base $kg$ con el estado de Rydberg $ks$ a través del estado intermedio $ke$. Sin embargo, el costo de esta técnica es el rápido decaimiento espontáneo asociado al nivel $ke$ ($dece$), el cual destruye la coherencia del sistema antes de que las interacciones de Rydberg puedan presentarse.

En esta sección se discute paso a paso los fenómenos físicos que surgen de esta configuración, comenzando con modelos simples que nos aportan intuición sobre los efectos de átomos en cavidades, y finalmente se plantea un caso particular para suprimir dicha decoherencia del nivel intermedio.

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
  caption: [Diagrama de la interacción de un átomo de tres niveles con un campo electromagético y en cuasiresonancia con la cavidad, con desintonía $Dpa$.]
)} <fig:1at3lvl_sistema>

La reducción del espacio de Hilbert para este sistema ahora solamente descarta la presencia del segunto átomo, $HH = HHc ** HHa1$, y en el Hamiltoniano se eliminan los términos relacionados con las interacciones interatómicas, por lo que queda como la suma de los Hamiltonianos considerados en @sec:1at2lvl y @sec:cavidad (@eq:1at2lvl_Ha, @eq:1at2lvl_Hi, @eq:cavidad_Hc y @eq:cavidad_Hb):

$ hat(H) = Ha + Hi + Hc + Hb $ <eq:1at3lvl_hamtotal>

y a $Hi$ se le agrega el término de acoplamiento átomo-cavidad, reposicionando al láser de control $rabic$ para aplicarse a los niveles $ke <-> ks$:

$ Hi = hbar g (sig(g,e) cre + sig(e,g) anh) - hbar/2 rabic (sig(s,e) + sig(e,s)). $

Luego, la ecuación maestra de Lindblad considera los efectos de disipación de la cavidad ($kappa$) y decaimiento de los niveles $ke$ y $ks$ ($dece$ y $decs$, respectivamente):

$ dot(rr) = -i[hat(H), rr] + kappa/2 LL[anh] + dece/2 LL[sig(g,e)] + decs/2 LL[sig(e,s)] $ <eq:1at3lvl_maestra>

Para analizar esta dinámica, se simuló el sistema utilizando la @eq:1at3lvl_maestra hasta alcanzar su estado estacionario, con condiciones iniciales $rr (t_(=0)) = ketbra(0 0,0 0)$, y se realizó un barrido de la desintonía del bombeo, $Dpa$, para observar el comportamiento de los estados excitados y la población de fotones en la cavidad.

La dinámica se dividirá en dos tipos de análisis, dados por la presencia o ausencia del láser de control clásico en la transición $ke <-> ks$, como a continuación se detalla.

==== Desdoblamiento _vacuum Rabi_ en régimen de acoplamiento fuerte

Procederemos a estudiar el sistema átomo-cavidad en la configuración más simple, que corresponde al láser de control apagado $rabic=0$. En este régimen, y asumiendo que el bombeo de la cavidad es suficientemente débil para no lograr poblar el estado $ks$ a través de estados virtuales, el sistema es reducido a un átomo de 2 niveles $kg <-> ke$ interactuando con el modo de la cavidad. Esta configuración está descrita por el modelo de Jaynes-Cummings @gerry_introductory_2005[cap.4], y cuyos fenómenos cambian dependiendo de la relación entre la constante $g$ y las tasas de disipación del sistema $kappa, dece$.

Debido a que la constante de acoplamiento átomo-cavidad es mayor que las tasas de disipación ($g > kappa, dece$), el sistema se encuentra en el régimen de acomplamiento fuerte.

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
  caption: [*(a)* Número medio de fotones en el estado estacionario *(b)* Probabilidad de ocupación del primer estado excitado $Pe$ (rosa) y en el segundo estado excitado $Ps$ (beige); en función de la desintonía del láser de prueba $Dpa$, para un átomo de cuatro niveles sometido a un láser de control apagado, donde se muestra un desdoblamiento _Vacuum-Rabi_ @mucke_electromagnetically_2010. Los parámetros utilizados son: $rabip = 0.1$, $rabic = 0.0$, $g = 3.0$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.01$, $nmax = 5$.]
) <fig:1at3lvl_sinrabi>

Considerando el caso de la sección anterior donde se analiza la espectroscopía de la cavidad vacía, se esperaría una única resonancia centrada en $Dpa=0$. Sin embargo, la @fig:1at3lvl_sinrabi muestra un desdoblamiento simétrico en dos picos distintos y simétricos, anulando casi por completo la excitación en la resonancia central, lo que se conoce como _Vacuum Rabi splitting_ @walls_quantum_2008[cap.11] y es causado por el fuerte acoplamiento átomo-cavidad.

Debido a que $g > kappa, dece$, el acoplamiento es lo suficientemente grande para que el átomo emita y absorba los fotones de la cavidad coherentemente antes de que la energía sea disipada al entorno. En consecuencia, los eigenestados $g 1$ (átomo en reposo, 1 fotón) y $e 0$ (átomo excitado, cero fotones) ya no son estados _desnudos_, sino que se forma una superposición de ambos en cuasi-partículas de luz-materia llamadas polaritones @kavokin_microcavities_2007[cap.4]:

$ ket(+-) = 1/sqrt(2) ket(g 1) +- ket(e 0) $

Estos dos estados tienen energías distintas y desplazadas por $+- g$ respecto a la frecuencia de resonancia original. Por lo tanto, el láser de prueba ya no es resonante con la cavidad en $Dpa=0$, sino en estos dos nuevos estados del sistema acoplado, lo cual explica la aparición de los dos picos de la @fig:1at3lvl_sinrabi.

Además, la presencia del átomo fuertemente acoplado destruye la resonancia central absorbiendo gran cantidad fotones eficientemente, por lo que dispersa y absorbe los fotones inyectados por el bombeo, e impide que la luz se acumule en la cavidad. La transmisión solamente se recupera en los valores de desintonía que corresponden a los polaritones. Como es de esperarse, la población del nivel superior $ks$ permanece en cero, ya que no existe ningún campo externo que acople el estado.

==== Interferencia cuántica y EIT

A diferencia del sistema de _dos_ niveles anterior, la presencia de más de una fuente de excitación permite que surjan fenómenos de interferencia cuántica y coherencia atómica, tales como el desdoblamiento de Autler-Townes y la Transparencia Inducida Electromagnética (EIT) @fleischhauer_electromagnetically_2005. En la figura @fig:1at3lvl_conrabi se muestra una alteración en la estructura de los niveles atómicos, como consecuencia de dichos fenómenos.

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
  caption: [*(a)* Número medio de fotones en el estado estacionario *(b)* Probabilidad de ocupación del primer estado excitado $Pe$ (rosa) y en el segundo estado excitado $Ps$ (beige); en función de la desintonía del láser de prueba $Dpa$, para un átomo de cuatro niveles sometido a un láser de control de gran intensidad en la transición $ke <-> ks$, que presenta EIT en resonancia $Dpa = 0$ y desdoblamiento de Autler-Townes en el estado $ke$, así como un pico de excitación máxima en el estado $ks$ debido a una transición resonante de dos fotones. Los parámetros utilizados son: $rabip = 0.1$, $rabic = 2.0$, $g = 3.0$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.01$, $nmax = 5$.]
) <fig:1at3lvl_conrabi>

Al activar el láser de control, se observan tres modificaciones en comparación con el _vacuum Rabi splitting_ anterior, explicadas a continuación.

Primero, la aparición de los _dressed states_. El campo de control intenso provoca que el átomo oscile rápidamente entre los estados $ke$ y $ks$. Como se discutió en [SECCION], este acomplamiento coherente ocasiona una mezcla de los estados originales para formar dos nuevos eigenestados $ket(+-) = 1/sqrt(2) (ket(e) +- ket(s))$, y cuyos niveles de energía están desplazados por una cantidad proporcional a la frecuencia de Rabi, $+- rabic/2$. Este fenómeno, conocido como desdoblamiento de Autler-Townes @khan_role_2016, se manifiesta en el espectro de excitación $Pe$ (curva rosa) ensanchando aún más la separación de los picos de los polaritones. La luz de la cavidad ahora debe lidiar no sólo con el acoplamiento $g$, sino también con la modificación de los niveles causada por $rabic$.

Luego, anulación de la absorción en resonancia. En el espectro de excitación se observa una anulación de la población del estadio intermedio, $Pe$, cuando la resonancia es total, $Dpa=0$, resultado de una interferencia cuántica destructiva. Para que el electrón llegue al estado $ke$, puede tomar un camino directo por acoplamiento al fotón de la cavidad ($kg -> ke$), y uno indirecto inducido por el láser de control ($kg -> ke -> ks -> ke$). En resonancia, las amplitudes de probabilidad de ambos caminos están desfasadas por $180^(degree)$, cancelándose entre sí @fleischhauer_electromagnetically_2005. Debido a ello, el átomo no puede absorber fotones de la cavidad en ese punto, volviéndose ópticamente transparente (EIT).

Finalmente, la formación de _dark state_. La población del estado superior, $Ps$ (curva beige), muestra un pico máximo exactamente en el punto de transparencia de $Pe$. Aunque el estado $ke$ está bloqueado por la transparencia, el sistema en conjunto cumple la condición de resonancia para una transición simultánea de dos fotones @bharti_wavelength_2016, uno dado por la cavidad y otro por el láser de control. El electrón es transferido de forma directa desde el estado base $kg$ hasta el estado de Rydberg $ks$ sin poblar el nivel intermedio. A esta superposición coherente entre $kg$ y $ks$ se conoce como un _dark state_ @fleischhauer_electromagnetically_2005.

Es importante mencionar que, a diferencia de la configuración $Lambda$ en que los dos estados base suelen ser estables, en sistemas cascada el estado $ks$ decae emitiendo un fotón, lo que destruye la coherencia y diluye la transparencia @khan_role_2016. Sin embargo, como $decs << dece$ (i.e. asumimos un modelo de átomos de Rydberg), el estado altamente excitado $ks$ tiene un tiempo de vida suficiente para sentir el bloqueo antes de que el átomo caiga espontáneamente, permitiendo que la coherencia sobreviva, y por tanto que existan _dark states_ metaestables y una transparencia casi total @geabanacloche_electromagnetically_1995.

En el espectro de transmisión de la cavidad $Nss$ se muestra la consecuencia macroscópica de los fenómenos anteriormente explicados, pues la curva muestra también una estructura de tres picos. Los dos picos anchos de los laterales corresponden al acoplamiento de la luz con los _dressed states_. Y el tercero, donde antes había un valle de máxima absorción en $Dpa=0$, ahora corresponde a un máximo de transmisión. Esto confirma macroscópicamente la existencia del _dark state_ donde el átomo pierde su capacidad de absorción en la transición $kg <-> ke$. Al volverse ópticamente transparente, el átomo deja de disipar la energía de la cavidad, permitiendo que el bombeo externo lo llene nuevamente de manera eficiente @mucke_electromagnetically_2010.