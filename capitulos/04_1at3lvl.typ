// ===================================================================
// 04_1at4lvl.typ
// ===================================================================
#import "../style.typ": *

=== Átomo de tres niveles <sec:1at4lvl>

Ahora que hemos explicado la dinámica de los sistemas aislados, se procede a estudiar la respuesta de un único átomo de tres niveles ($kg <-> ke <-> ks$) dentro de la cavidad óptica bombeada. En esta configuración en cascada, al modo de la cavidad se le aplica un barrido de desintonía del láser de prueba, $Dpa$, acoplando la transición inferior $kg <-> ke$, y considerando que el láser de control y la transición superior $ke <-> ks$ están en perfecta resonacia ($Dac = 0$), como se muestra en la @fig:1at3lvl_sistema.

#figure(
  diagrama(cell-size: 1mm,
          mark-scale: 130%,
          edge((0,2),(2,2)),
          node((2,2), $kg$),
          edge((0.5,2),(0.5,1.4), "<->", $wp$, label-side: left, "wave"),
          edge((-0.5,1.4),(1.5,1.4), "--", $Dpa$),
          edge((0,1),(2,1)),
          node((2,1), $ke$),
          edge((0,0),(2,0)),
          node((2,0), $ks$),
          edge((0.5,0),(0.5,1), "<->", $wc$, label-side: left, "wave")
  ),
  caption: [Diagrama de la interacción de un átomo de tres niveles con un campo electromagético y en cuasiresonancia con la cavidad, con desintonía $Dpa$.]
) <fig:1at3lvl_sistema>

La reducción del espacio de Hilbert para este sistema ahora solamente descarta la presencia del segunto átomo, $HH = HHc ** HHa1$, y en el Hamiltoniano se eliminan los términos relacionados con las interacciones interatómicas, por lo que queda como la suma de los Hamiltonianos considerados en @sec:1at2lvl y @sec:cavidad (@eq:1at2lvl_Ha, @eq:1at2lvl_Hi, @eq:cavidad_Hc y @eq:cavidad_Hb):

$ hat(H) = Ha + Hi + Hc + Hb $ <eq:1at3lvl_hamtotal>

y a $Hi$ se le agrega el término de acoplamiento átomo-cavidad, reposicionando al láser de control $rabic$ para aplicarse a los niveles $ke <-> ks$:

$ Hi = hbar g (sig(g,e) cre + sig(e,g) anh) - hbar/2 rabic (sig(s,e) + sig(e,s)). $

Luego, la ecuación maestra de Lindblad considera los efectos de disipación de la cavidad ($kappa$) y decaimiento de los niveles $ke$ y $ks$ ($dece$ y $decs$, respectivamente):

$ dot(rr) = -i[hat(H), rr] + kappa/2 LL[anh] + dece/2 LL[sig(g,e)] + decs/2 LL[sig(e,s)] $ <eq:1at3lvl_maestra>

Para analizar esta dinámica, se simuló el sistema utilizando la @eq:1at3lvl_maestra hasta alcanzar su estado estacionario, con condiciones iniciales $rr (t_(=0)) = ketbra(0 0,0 0)$, y se realizó un barrido de la desintonía del bombeo, $Dpa$, para observar el comportamiento de los estados excitados y la población de fotones en la cavidad.

La dinámica se dividirá en dos tipos de análisis, dados por la presencia o ausencia del láser de control clásico en la transición $ke <-> ks$, como a continuación se detalla.

==== Desdoblamiento _vacuum Rabi_ en régimen de acoplamiento fuerte

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
  caption: [*(a)* Número medio de fotones en el estado estacionario *(b)* Probabilidad de ocupación del primer estado excitado $P_e$ (rosa) y en el segundo estado excitado $P_s$ (beige); en función de la desintonía del láser de prueba $Dpa$, para un átomo de cuatro niveles sometido a un láser de control apagado, donde se muestra un desdoblamiento _Vacuum-Rabi_ @mucke_electromagnetically_2010. Los parámetros utilizados son: $rabip = 0.1$, $rabic = 0.0$, $g = 3.0$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.01$, $nmax = 5$.]
) <fig:1at3lvl_sinrabi>

Cuando el láser de control está apagado, $rabic = 0$, el sistema se reduce a un átomo de dos niveles interactuando con la cavidad, descrito por el modelo de Jaynes-Cummings @gerry_introductory_2005[cap.4]. Debido al desdoblamiento _Vacuum-Rabi_ @walls_quantum_2008[cap.11] ocasionado por el fuerte acoplamiento, los niveles de energía $kg$ y $ke$ se modifican y se convierten en los polaritones $ket(+-) = 1/sqrt(2) ket(g 1) +- ket(e 0)$; así, el láser de prueba resuena ahora en estos dos eigenestados desplazados con el nuevo sistema átomo-cavidad formado. Como es de esperarse, la población del nivel superior $ks$ permanece en cero, ya que no existe ningún campo externo que acople el estado.


En la cavidad, la presencia del átomo destruye su resonancia central absorbiendo gran cantidad fotones eficientemente, por lo que dispersa y absorbe los fotones inyectados por el bombeo, e impide que la luz se acumule en la cavidad. La transmisión solamente se recupera en los valores de desintonía que corresponden a los eigenestados de los polaritones, lo que genera un espectro de doble pico.

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
  caption: [*(a)* Número medio de fotones en el estado estacionario *(b)* Probabilidad de ocupación del primer estado excitado $P_e$ (rosa) y en el segundo estado excitado $P_s$ (beige); en función de la desintonía del láser de prueba $Dpa$, para un átomo de cuatro niveles sometido a un láser de control de gran intensidad en la transición $ke <-> ks$, que presenta EIT en resonancia $Dpa = 0$ y desdoblamiento de Autler-Townes en el estado $ke$, así como un pico de excitación máxima en el estado $ks$ debido a una transición resonante de dos fotones. Los parámetros utilizados son: $rabip = 0.1$, $rabic = 2.0$, $g = 3.0$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.01$, $nmax = 5$.]
) <fig:1at3lvl_conrabi>

Al activar el láser de control, el fuerte acoplamiento entre los estados $ke$ y $ks$ provoca la formación de los _dressed states_, forzando al átomo a oscilar rápidamente entre ellos. Los estados originales se mezclan para formar dos nuevos eigenestados $ket(+-) = 1/sqrt(2) (ket(e) +- ket(s))$ del Hamiltoniano, cuyas energías se encuentran desplazadas una cantidad proporcional a $+- (rabic/2)$, generando un desdoblamiento de Autler-Townes @khan_role_2016.

Además, la probabilidad de encontrar al átomo en el estado intermedio $ke$ decae a cero en $Dpa = 0$ como consecuencia de la interferencia cuántica destructiva. Las amplitudes de probabilidad de los dos caminos de excitación $kg -> ke$ (directo) y $kg -> ke -> ks -> ke$ (inducido por el láser de control) se encuentran desfasadas por $180^(degree)$, cancelándose entre sí. Debido a ello, el átomo no puede absorber fotones de la cavidad en ese estado y se vuelve transparente (EIT).


Por otro lado, la población del estado superior, $P_s$, muestra un pico máximo exactamente en el punto de transparencia de $P_e$. Aunque el estado $ke$ está bloqueado por la interferencia destructiva, el sistema en conjunto cumple la condición de resonancia para una transición simultánea de dos fotones @bharti_wavelength_2016, uno dado por la cavidad y otro por el láser de control, por lo que el electrón es transferido de forma directa desde el estado base $kg$ hasta el estado superior $ks$, formando un _dark state_.

A diferencia de la configuración $Lambda$ en que los dos estados base suelen ser estables, en sistemas cascada el estado $ks$ decae emitiendo un fotón, lo que destruye la coherencia y diluye la transparencia @khan_role_2016. Sin embargo, como $decs << 1$ (i.e. asumimos un modelo de átomos de Rydberg), el estado altamente excitado $ks$ tiene un tiempo de vida suficiente para sentir el bloqueo antes de que el átomo caiga espontáneamente, permitiendo que la coherencia sobreviva, por lo tanto que existan _dark states_ metaestables y una transparencia casi total @geabanacloche_electromagnetically_1995.

En la cavidad, la curva muestra también una estructura de tres picos. Los dos picos anchos de los laterales corresponden al acoplamiento de la luz con los _dressed states_. Y el tercero, donde antes había un valle de máxima absorción en $Dpa=0$, ahora corresponde a un máximo de transmisión. Esto confirma macroscópicamente la existencia del _dark state_ donde el átomo pierde su capacidad de absorción en la transición $kg <-> ke$. Al volverse ópticamente transparente, el átomo deja de disipar la energía de la cavidad, permitiendo que el bombeo externo lo llene nuevamente de manera eficiente.