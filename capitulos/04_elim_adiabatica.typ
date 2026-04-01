// ===================================================================
// 05_elim_adiabatica.typ
// ===================================================================
#import "../style.typ": *


El análisis del capítulo anterior nos permitió establecer una base constructiva de los fenómenos dados con átomos en cavidades. Sin embargo, en experimentos reales como los reportados por @gaetan_observation_2009, la excitación directa desde el estado base $kg$ hasta un estado altamente excitado de Rydberg $ks$ presenta dificultades técnicas, donde generalmente este proceso requiere láseres de alta potencia y frecuencias específicas, lo que puede resultar en una implementación experimental complicada.

Para superar esta limitación, se recurre a excitaciones de múltiples fotones, en donde se acopla el estado base $kg$ con el estado de Rydberg $ks$ a través de un estado intermedio $ke$, utilizando dos láseres en configuración cascada. Sin embargo, el costo de esta técnica es el rápido decaimiento espontáneo asociado al nivel $ke$ ($dece$), el cual destruye la coherencia del sistema antes de que las interacciones interatómicas de Rydberg puedan presentarse. En este capítulo, se implementa la técnica de eliminación adiabática para suprimir dicha decoherencia, estudiaremos diversos fenómenos relacionados con esta técnica y, finalmente, se analizará el fenómeno de bloqueo de excitación en el sistema acoplado de dos átomos de cuatro niveles.


==== Eliminación adiabática del estado intermedio <sec:elim_adiabatica>


La estrategia usada para poblar de manera coherente el estado de Rydberg $ks$ sin tener pérdidas radiativas del nivel intermedio $ke$, consiste en operar al sistema en un régimen de desintonía muy grande (_large detuning_) [CITAR AKI].

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
          edge((0.5,0),(0.5,0.6), "<->", $wc$, label-side: left, "wave"),
          edge((-0.5,0.6),(1.5,0.6), "--", label-side: right, $Dac$),
  ),
  caption: [Diagrama de la interacción de un átomo de tres niveles con desintonías $Dpa$ y $Dac$ con los niveles atómicos.]
) <fig:1at4lvl_sistema>

El esquema físico, mostraso en la @fig:1at4lvl_sistema, se configuró tal que ambos láseres tengan una desintonía idéntica, $Delta$, pero de signo opuesto respecto al nivel $ke$, es decir, $Delta = Dpa = -Dac$, de manera que la transición de dos fotones $kg <-> ks$ mantenga la resonancia exacta. Esta aproximación de eliminación adiabática es válida solamente en el régimen de _large detuning_ donde la desintonía es mucho mayor que las tasas de disipación del sistema ($Delta >> kappa, dece, decs$). Así, el nivel intermedio $ke$ se vuelve virtual y su función es solamente mediar la transición, por lo que su población es despreciable. Matemáticamente, esto permite que el átomo se comporte como un sistema de dos niveles $kg$, $ks$.

Dado que los campos EM intensos inducen desplazamientos de energía en los niveles de energía atómicos (_AC Stark shift_) [CITAR AKI - cohen atom photom], el sistema sufre una perturbación adicional. El estado base $kg$ y el de Rydberg $ks$ son afectados por corrimientos proporcionales a $sg = rabip^2/(4 Delta)$ y $ss = rabic^2/(4 Delta)$, respectivamente, lo que lleva a una pérdida de resonancia en la transición de dos fotones. Por ello, en la simulación numérica se tiene que aplicar una compensación de dichos desplazamientos ajustando las frecuencias de los láseres, tales que

$ Dpa = Delta + sg, $
$ Dac = - Delta + ss. $

Para exponer numéricamente estos efectos, se simuló en OpenKet la dinámica de un solo átomo de tres niveles ($kg <-> ke <-> ks$) bajo dos configuraciones: primero, un átomo aislado interactuando con dos campos clásicos en el espacio libre; y segundo, un átomo dentro de la cavidad óptica acoplada a un campo de bombeo.


===== Átomo aislado con dos campos clásicos en el espacio libre


El primer caso corresponde a un átomo aislado ($HH = HHa1$), donde un láser de prueba (clásico y débil) acopla la transición $kg <-> ke$, y un láser de control (clásico y fuerte) acopla la transición $ke <-> ks$. El Hamiltoniano de interacción semiclásico para este sistema es:

$ Hi = -hbar/2 {rabip (sig(g,e) + sig(e,g)) + rabic (sig(e,s) + sig(s,e))} $

y la ecuación maestra de Lindblad con términos de decaimiento para el nivel intermedio $ke$ y el estado de Rydberg $ks$:

$ dot(rr) = -i/hbar [Ha + Hi, rr] + dece/2 LL[sig(g,e)] + decs/2 LL[sig(e,s)]. $

Como el sistema se encuentra fuertemente desintonizado, la teoría de perturbaciones explica que el átomo oscila entre los estados de los extremos, con una frecuencia de Rabi efectiva de dos fotones [CITAR AKI] dada por:

$ rabieff approx (rabip rabic)/(2 Delta) = 0.05 $

#figure(
  image("../assets/figuras/1at4lvl.png"),
  caption: [Evolución temporal de las poblaciones atómicas en el régimen de eliminación adiabática. Se observa que la población del estado intermedio $P_e$ (rosa) permanece en cero a lo largo de la evolución, mientras que el átomo muestra oscilaciones de Rabi entre el estado base $kg$ y el estado de Rydberg $ks$ (beige), comportándose como un sistema de dos niveles efectivo. Los parámetros utilizados son: $rabip = 0.5$, $rabic = 20.0$, $Delta = 100.0$, $dece = 0.0$, $decs = 0.0$.]
) <fig:1at4lvl>

Veamos en la @fig:1at4lvl que, a pesar de que existe un acoplamiento entre los estados $kg <-> ke$ y $ke <-> ks$ de manera directa, el estado intermedio $ke$ no presenta población significativa, lo que demuestra físicamente que el electrón no transita por ese estado. Este resultado confirma que el sistema atómico se ha reducido a un modelo de dos niveles con probabilidad de excitación $P_s (t) = sin^2(rabieff/2 t)$.


===== Átomo acoplado a la cavidad óptica


Una vez que se ha validado la eliminación adiabática en el átomo aislado, ahora se introduce el modo de la cavidad ($HH = HHa1 ** Hc$). En esta configuración, la cavidad reemplaza al láser de prueba clásico, acomplando la transición inferior $kg <-> ke$ con un acoplamiento de Jaynes-Cummings $g$, y es alimentado por el láser de prueba externo de intensidad $rabip$. El láser intenso de control que acopla $ke <-> ks$ se mantiene sin cambios. Por lo tanto, el Hamiltoniano total y la ecuación maestra de Lindblad para este sistema son los mismos que los usados en @eq:1at3lvl_hamtotal y @eq:1at3lvl_maestra, respectivamente, pero con los términos de interacción y disipación correspondientes a esta nueva configuración.

Debido a que el nivel $ke$ está suprimido adiabáticamente, la interacción efectiva ya no ocurre entre el átomo de dos niveles aislado y el modo de la cavidad, sino que ahora el modo de la cavidad interactúa con la transición de dos fotones $kg <-> ks$. El sistema se reduce a un modelo de Jaynes-Cummings efectivo con una frecuencia de acoplamiento dada por [CITAR AKI]:

$ geff approx (g rabic)/(2 Delta) $

Para los parámetros usados, este acomplamiento es $geff = 1.5 kappa$, lo que coloca al sistema en el régimen de acoplamiento fuerte cooperativo. Se simuló la respuesta estacionaria conforme el barrido de $scan$ alrededor de la desintonía $Delta=100$.

#figure(
  stack(
    dir: ttb,
    spacing: 0em,
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: (top, top),
      [*(a)*],
      image("../assets/figuras/1at4lvl_fotones.png"),
    ),
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: (top, top),
      [*(b)*],
      image("../assets/figuras/1at4lvl_excitado.png"),
    ),
  ),
  caption: [*(a)* Número medio de fotones en el estado estacionario *(b)* Probabilidad de excitación atómica del nivel intermedio $P_e$ (rosa) y el nivel de Rydberg $P_s$ (beige), para el sistema átomo-cavidad bajo eliminación adiabática, en función de la variación $delta$ de la desintonía alrededor de $Dpa = 100$. Se exhibe un desdoblamiento asimétrico de los estados luz-materia. Los parámetros utilizados son: $rabip = 0.5$, $rabic = 20.0$, $g = 15.0$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.0$, $nmax = 3$.]
) <fig:1at4lvl_cavidad>

Como se observa en @fig:1at4lvl_cavidad, el estado intermedio permanece suprimido a lo largo del barrido, lo que confirma que, incluso en el régimen de acoplamiento fuerte con la cavidad ($g > kappa$), el sistema de 3 niveles continúa comportándose efectivamente como uno de dos niveles; y el electrón no experimenta las pérdidas asociadas a $dece$.

Sin embargo, se puede notar claramente la nueva presencia de dos picos de resonancia asimétricos y desplazados del origen, causado por los ya conocidos polaritones del desdoblamiento _Vacuum Rabi_ efectivo [CITAR AKI] y los corrimientos Stark inducidos por la grande desintonía. Por un lado, el láser de control fuerte desplaza el nivel $ks$ una cantidad de $ss = 1.0 kappa$; y por otro lado, las fluctuaciones del vacío en la cavidad empujan al nivel $kg$, desplazando la resonancia efectiva una cantidad $sg = g^2 / Delta = 2.25 kappa$

La desalineación de la energía entre la cavidad y el átomo _vestido_ por el láser ($ss != sg$) rompe la degeneración de dichos polaritones [CITAR AKI], generando una asimetría en la amplitud de los picos. El pico izquierdo ($scan\/kappa approx -0.5$) se encuentra más cerca de la resonancia atómica desplazada, por lo que tiene mayor carácter de excitación material (polaritón tipo atómico), y que se refleja en una alta probabilidad de encontrar al átomo en el estado $ks$ con un menor número de fotones en la cavidad. De forma inversa, el pico derecho ($scan\/kappa approx 2.5$) tiene un mayor carácter fotónico (polaritón tipo luz), maximizando la transmisión dentro de la cavidad mientras que el nivel de excitación del átomo decrece.

Analíticamente, la separación entre los polaritones [CITAR AKI] está descrita por la diferencia de los corrimientos y el acoplamiento efectivo:

$ d1 = sqrt((ss - sg)^2 + 4geff^2) approx 3.25 kappa $

La contracción mostrada en la @fig:1at4lvl_cavidad es causada por la disipación $kappa$ que tiende a jalar las resonancias hacia el centro [CITAR AKI].

Finalmente, debido al fuerte acoplamiento del láser de control, la resonancia efectiva de dos fotones es desplazada y ya no se encuentra en el origen $scan = 0$ [CITAR AKI]. Mientras que la frecuencia de resonancia intrínsieca de la cavidad permanece sin alteraciones, el desplazamiento $ss$ hace que el sistema híbrido deba compensar esa energía extra, moviendo el centro del espectro hacia la derecha, por lo que la resonancia se encuentra en $scan approx 1$.