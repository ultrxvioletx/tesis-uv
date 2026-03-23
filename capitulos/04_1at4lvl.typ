// ===================================================================
// 04_1at4lvl.typ
// ===================================================================
#import "../style.typ": *

=== Átomo de cuatro niveles

Ahora que hemos explicado la dinámica de los sistemas aislados, se procedió a estudiar la respuesta de un único átomo de cuatro niveles ($kg <-> ke <-> ks <-> kp$) dentro de la cavidad óptica bombeada. En esta configuración en cascada, al modo de la cavidad se le aplica un barrido de detuning del láser de prueba, $Dpa$, acoplando la transición inferior ($kg <-> ke$), y considerando que el láser de control y la transición superior ($ke <-> ks$) están en perfecta resonacia ($Dac = 0$). Para este análisis, el estado superior $kp$ no está acomplado a ningún campo externo, por lo que su población permanece nula y podemos considerar al átomo como simplemente uno de tres niveles en cascada.

La reducción del espacio de Hilbert para este sistema ahora solamente descarta la presencia del segunto átomo, $HH = HH_"cavidad" + HH_"átomo1"$, y en el Hamiltoniano se eliminan los términos relacionados con las interacciones interatómicas, por lo que queda como la suma de los Hamiltonianos considerados en @subsec:1at2lvl y @subsec:cavidad (@eq:1at2lvl_Ha, @eq:1at2lvl_Hi, @eq:cavidad_Hc y @eq:cavidad_Hb):

$ hat(H) = Ha + Hi + Hc + Hb $

y a $Hi$ se le agrega el término de acoplamiento átomo-cavidad, reposicionando al láser de control $rabic$ para aplicarse a los niveles $ke <-> ks$:

$ Hi = hbar g (sig(g,e) cre + sig(e,g) anh) - hbar/2 rabic (sig(s,e) + sig(e,s)). $

Luego, la ecuación maestra de Lindblad considera los efectos de disipación de la cavidad ($kappa$) y decaimiento de los niveles $ke$ y $ks$ ($dece$ y $decs$, respectivamente):

$ dot(rr) = -i[hat(H), rr] + kappa/2 LL[anh] + dece/2 LL[sig(g,e)] + decs/2 LL[sig(e,s)] $ <eq:1at4lvl_maestra>

Para analizar esta dinámica, se simuló el sistema utilizando la @eq:1at4lvl_maestra hasta alcanzar su estado estacionario, con condiciones iniciales $rr (t_(=0)) = ketbra(0 0,0 0)$, y se realizó un barrido del detuning del bombeo, $Dpa$, para observar el comportamiento de los estados excitados y la población de fotones en la cavidad, como a continuación se detalla.

==== Población de estados excitados

A diferencia del sistema de dos niveles anterior, la presencia de más de una fuente de excitación permite que surjan fenómenos de interferencia cuántica y coherencia atómica, tales como el desdoblamiento de Autler-Townes y la Transparencia Inducida Electromagnética (EIT) @fleischhauer_electromagnetically_2005. En la figura @fig:deltas_1at4lvl_excitado se muestra una alteración en la estructura de los niveles atómicos, como consecuencia de dichos fenómenos.

#figure(
  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    align(center)[
      #image("../assets/figuras/fig:deltas_1at4lvl_excitado0.png")
      *(a)*
    ],
    align(center)[
      #image("../assets/figuras/fig:deltas_1at4lvl_excitado.png")
      *(b)*
    ],
  ),
  caption: [Espectro de excitación en el estado estacionario en el que muestra la probabilidad de ocupación del primer estado excitado $P_e$ (rosa) y en el segundo estado excitado $P_s$ (beige), en función del detuning (normalizado) del láser de prueba $Dpa$, para un átomo de cuatro niveles sometido a: (a) un láser de control apagado, donde la población del estado $ke$ exhibe un desdoblamiento _Vacuum-Rabi_ @mucke_electromagnetically_2010; y (b) un láser de control de gran intensidad en la transición $ke <-> ks$, que presenta EIT en resonancia $Dpa = 0$ y desdoblamiento de Autler-Townes en el estado $ke$, así como un pico de excitación máxima en el estado $ks$ debido a una transición resonante de dos fotones [CITA AKI]. Los parámetros utilizados son: $rabip = 0.1$, $rabic = 2.0$, $g = 3.0$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.01$, $nmax = 5$.]
) <fig:deltas_1at4lvl_excitado>

Debido a que la constante de acoplamiento átomo-cavidad es mayor que las tasas de disipación ($g > kappa, dece$), el sistema se encuentra en el régimen de acomplamiento fuerte.

Cuando el láser de control está apagado, $rabic = 0$, el sistema se reduce a un átomo de dos niveles interactuando con la cavidad, descrito por el modelo de Jaynes-Cummings @gerry_introductory_2005[cap.4]. Debido al desdoblamiento _Vacuum-Rabi_, los niveles de energía $kg$ y $ke$ se modifican y se convierten en los polaritones $ket(+-) = 1/sqrt(2) ket(g 1) +- ket(e 0)$; así, el láser de prueba ya no resuena solamente con el átomo, sino con estos dos nuevos eigenestados desplazados, lo que físicamente se traduce en el intermcabio de fotones constante entre la cavidad y el átomo. Como es de esperarse, la población del nivel superior $ks$ permanece en cero, ya que no existe ningún campo externo que acople el estado.

Sin embargo, al activar el láser de control, el fuerte acoplamiento entre los estados $ke$ y $ks$ provoca la formación de los _dressed states_, forzando al átomo a oscilar rápidamente entre ellos. Los estados originales se mezclan para formar dos nuevos eigenestados del Hamiltoniano, cuyas energías se encuentran desplazadas una cantidad proporcional a $+- rabic/2$, generando un desdoblamiento de Autler-Townes @khan_role_2016.

Además, la probabilidad de encontrar al átomo en el estado intermedio $ke$ decae a cero en $Dpa = 0$ como consecuencia de la interferencia cuántica destructiva. Las amplitudes de probabilidad de los dos caminos de excitación $kg -> ke$ (directo) y $kg -> ke -> ks -> ke$ (inducido por el láser de control) se encuentran desfasadas por $180^(degree)$, cancelándose entre sí. Debido a ello, el átomo no puede absorber fotones de la cavidad y se vuelve transparente (EIT).


Por otro lado, la población del estado superior, $P_s$, muestra un pico máximo exactamente en el punto de transparencia mencionado anteriormente. Aunque el estado $ke$ está bloqueado por la interferencia destructiva, el sistema en conjunto cumple la condición de resonancia para una transición simultánea de dos fotones [CITAR AKI], uno dado por la cavidad y otro por el láser de control, por lo que el electrón es transferido de forma directa desde el estado base $kg$ hasta el estado superior $ks$, formando un _dark state_ [CITAR AKI]. 

==== Población de la cavidad

Los fenómenos que alteran a los estados exictados, a su vez, se reflejan también en el estado del modo de la cavidad. En la práctica, la luz que escapa de la cavidad, proporcional al número de fotones dentro de ella $Nss$, se vuelve el observable principal debido a su facilidad para ser medido. Es por ello que se analizó el espectro de transmisión de la cavidad bajo las mismas condiciones.

#figure(
  grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    align(center)[
      #image("../assets/figuras/fig:deltas_1at4lvl_fotones0.png")
      *(a)*
    ],
    align(center)[
      #image("../assets/figuras/fig:deltas_1at4lvl_fotones.png")
      *(b)*
    ],
  ),
  caption: [Número medio de fotones en el estado estacionario en función del detuning del láser de prueba $Dpa$, para un átomo de cuatro niveles sometido a: (a) un láser de control apagado, donde se observa el desdoblamiento de Rabi en el vacío; y (b) un láser de control de gran intensidad en la transición $ke <-> ks$, que presenta desdoblamiento de Autler-Townes en el estado $ke$ e induce una transparencia en resonancia $Dpa = 0$. Los parámetros utilizados son: $rabip = 0.1$, $rabic = 2.0$, $g = 3.0$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.01$, $nmax = 5$.]
) <fig:deltas_1at4lvl_fotones>

Con el láser apagado, se observa que la presencia del átomo destruye la resonancia central, donde el átomo es un gran absorbente de fotones, y dispersa y absorbe los fotones inyectados por el bombeo, impidiendo que la luz se acumule en la cavidad. La transmisión solamente se recupera en los valores de detuning que corresponden a los eigenestados de los polaritones, lo cual genera un espectro de doble pico.

Finalmente, con el láser de control encendido, la curva muestra ahora una estructura de tres picos. Los dos picos anchos de los laterales corresponden al acoplamiento de la luz con los _dressed states_ generados por el desdoblamiento de Autler-Townes.

Sin embargo, donde antes había un valle de máxima absorción en $Dpa=0$, ahora hay un tercer pico de transmisión, que es agudo y estrecho. Esto confirma macroscópicamente la existencia del _dark state_, causado por la interferencia destructiva (EIT) donde el átomo pierde su capacidad de absorción en la transición $kg <-> ke$ [CITAR AKI]. Al volverse ópticamente transparente, el átomo deja de disipar la energía de la cavidad, permitiendo que el bombeo externo lo llene nuevamente de forma eficiente.