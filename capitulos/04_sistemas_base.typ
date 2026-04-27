// ===================================================================
// 04_sistemas_base.typ
// ===================================================================
#import "../style.typ": *


Antes de estudiar la dinámica de dos átomos interactuando, comenzaremos por las bases físicas que rigen el sistema principal. En este capítulo, se utiliza la paquetería OpenKet para analizar fenómenos cuánticos bien conocidos analíticamente, dividiendo la discusión en dos etapas.

Primero, en las primeras dos secciones se estudian los subsistemas más elementales de manera aislada: el átomo de dos niveles en interacción semiclásica y el modo de cavidad disipativo, esto con el objetivo de observar y discutir las propiedades de dichos sistemas en los regímenes seleccionados.

Posteriormente, en @sec:1at4lvl, se considera a un único átomo de cuatro niveles en la cavidad. A través del análisis de las poblaciones atómicas y del campo intracavidad, se caracterizarán fenómenos de interferencia cuántica como el desdoblamiento _Vacuum Rabi_, el efecto Autler-Townes y la Transparencia Inducida Electromagnética (EIT). Esto nos permite obtener un punto de partida controlado para lograr identificar la fenomenología nueva causada en nuestro sistema de interés al introducir un segundo átomo en el @cap:bloqueo.


=== Oscilaciones de Rabi en un átomo de dos niveles <sec:1at2lvl>

#figure(
  diagrama(cell-size: 1mm,
          mark-scale: 130%,
          edge((0,2),(2,2)),
          node((2,2), $kg$),
          edge((0.5,2),(0.5,0.4), "<->", $wc$, label-side: left, "wave"),
          edge((-0.5,0.4),(1.5,0.4), "--", $Dac$),
          edge((0,0),(2,0)),
          node((2,0), $ke$)
  ),
  caption: [Diagrama de la interacción de un átomo de dos niveles con un campo electromagético, con desintonía $Dac$.]
) <fig:1at2lvl_sistema>


El sistema cuántico de interacción luz-materia más elemental es un átomo de dos niveles (@fig:1at2lvl_sistema), interactuando con un campo electromagnético clásico. De acuerdo con la teoría clásica de interacción, ignorando efectos de decaimiento y bajo la aproximación de onda rotante (RWA), la probabilidad de encontrar al

#figure(
  image("../assets/figuras/1at2lvl.png", width: 100%),
  caption: [Evolución temporal de la probabilidad de excitación $Pe (t)$ para un átomo de dos niveles interactuando con un campo clásico, partiendo del estado base $kg$. Las líneas continuas corresponden a la solución analítica de la @eq:1at2lvl_analitica, mientras que los marcadores representan los resultados obtenidos numéricamente usando la integración de la ecuación maestra (@eq:1at2lvl_maestra) con OpenKet. Se observan tres valores de desintonía: total resonancia $Dac = 0.0$ (círculos), y fuera de resonancia $Dac = 2.0$ (triángulos), $Dac = 4.0$ (cuadrados). El tiempo está normalizado como $rabic t$, y las magnitudes de frecuencia están expresadas en unidades arbitrarias consistentes con la frecuencia de Rabi, cuyo valor es $rabic = 2.0$.],
) <fig:1at2lvl>

átomo en el estado excitado evoluciona en el tiempo y está dada analíticamente por la fórmula de Rabi (descrita en @cap:teoría):

$ Pe (t) = rabic^2 / rabir^2 sin^2(rabir/2 t) $ <eq:1at2lvl_analitica>

donde $rabic$ es la frecuencia de Rabi que caracteriza la intensidad de acoplamiento entre los niveles $kg <-> ke$, y $rabir = sqrt(rabic^2 + Dac^2)$ es la frecuencia de Rabi generalizada, la cual depende de la desintonía $Dac$ entre la frecuencia del láser y la de transición atómica.

Para poder simular este sistema, se considera un subespacio de Hilbert $HHa$ de dimensión 2, pues en él vive un solo átomo de dos niveles. El Hamiltoniano del sistema es el de interacción semiclásica:

$
  hat(H) &= Ha + Hi \
  &= hbar Dac sig(e,e) -hbar/2 rabic (sig(e,g) + sig(g,e)).
$ <eq:1at2lvl_H>

Debido a que no se consideraron efectos de decaimiento, la ecuación maestra de Lindblad se reduce simplemente a la ecuación de Von Neumann:

$ dot(rr) = -i/hbar [hat(H), rr] $ <eq:1at2lvl_maestra>

con condiciones iniciales $rr (t_(=0)) = ketbra(g,g)$.

Como se observa en la @fig:1at2lvl, la integración numérica es bastante precisa con la solución analítica para todos los regímenes de desintonía evaluados. En el caso de total resonancia $Dac = 0.0$, el sistema oscila perfectamente entre los valores 0 y 1 a una frecuencia dada puramente por $rabic$.

Al introducir desintonía no nula ($Dac = 2.0$ y $Dac = 4.0$), se observan dos efectos explicados por la teoría semiclásica @gerry_introductory_2005[$section 4.4$]: por un lado, la amplitud máxima de excitación es menor, disminuyendo drásticamente la probabilidad de que el átomo se encuentre excitado; y, por otro lado, la frecuencia de las oscilaciones aumenta conforme el sistema oscila a la frecuencia de Rabi generalizada $rabir$.


=== Inyección y disipación de fotones en una cavidad vacía <sec:cavidad>


Ahora, el siguiente paso es simular la inyección y pérdida de excitaciones en una cavidad abierta, implementando una evolución no unitaria del sistema únicamente dado por la cavidad. Para ello, se consideró a la cavidad en ausencia de átomos.

La dinámica de este sistema se rige por la _competencia_ entre el bombeo externo (con intensidad $rabip$) que inyecta fotones al modo de la cavidad, y la tasa de decaimiento $kappa$ que modela la fuga de los fotones a través de los espejos.

El espacio de Hilbert a utilizar es el subespacio $HHc$ de dimensión $nmax$, que considera a la cavidad sin átomos, por lo que los términos sobrevivientes del Hamiltoniano de la @eq:hamiltoniano_total son:

$ Hc = hbar Dpa (cre anh + 1/2) $ <eq:cavidad_Hc>
$ Hb = i hbar rabip (cre - anh) $ <eq:cavidad_Hb>

donde $Dpa$ corresponde a la desintonía entre la frecuencia del láser de bombeo y la resonancia de la cavidad. La ecuación maestra que describe el proceso de esta subsección es:

$ dot(rr) = -i/hbar [Hc + Hb, rr] + kappa/2 LL[anh] $ <eq:maestra_cavidad>

y se usaron las condiciones iniciales $rr (t_(=0)) = ketbra(0,0)$.

El número medio de fotones dentro de la cavidad $Nexp (t)$ evoluciona hacia un estado estacionario dado por el balance entre la ganacia de fotones y la pérdida de estos. Si el sistema parte del vacío cuántico, la solución analítica establece que el campo dentro de la cavidad evoluciona como un estado coherente $ket(alpha (t))$ @gerry_introductory_2005[$section 8.3, section 8.5$] @walls_quantum_2008[$section 7.2$], cuya amplitud compleja está descrita por:

$ alpha(t) = alpha_"ss" (1 - e^(-(kappa/2 + i Dpa) t)) $ <eq:analitica_cavidad>

donde $alpha_"ss" = rabip / (kappa/2 + i Dpa)$ es la amplitud del campo en el límite $t -> infinity$. Por lo tanto, el número medio de fotones se calcula como $Nexp (t) = abs(alpha(t))^2$.

#figure(
  image("../assets/figuras/cavidad.png"),
  caption: [Evolución temporal del número medio de fotones $Nexp$ en una cavidad bombeada con disipación, en calidad de resonancia $Dpa=0$. Los marcadores cuadrados representan la simulación numérica obtenida de alimentar a OpenKet con la @eq:maestra_cavidad, partiendo del estado de vacío $ket(0)$, mientras que la línea continua representa la solución analítica dada por la @eq:analitica_cavidad. El tiempo está normalizado respecto a la frecuencia de Rabi $rabip$. Los valores de los parámetros usados son: $rabip = 1.0 kappa$, $kappa = 1.0$, $N_max = 15$, dando un valor de $abs(alpha_"ss")^2 = 4$.]
) <fig:cavidad>

Para caracterizar la respuesta de la cavidad, el observable de interés es el número medio de fotones dentro en el estado estacionario, $Nss$. Sin embargo, en la práctica esta cantidad no es físicamente accesible, pero la teoría de _input-output_ @collett_squeezing_1984 expresa que el flujo de fotones que salen de la cavidad a través de un espejo transmisivo, es directamente proporcional a la tasa de disipasión $kappa$ y el número de fotones almacenados en ese instante. Por lo tanto, el observable $Nss$ nos brinda una medida directa y proporcional de su espectro de transmisión.

Así, se simuló la dinámica de la cavidad hasta alcanzar el estado estacionario ($t -> infinity$) para un barrido de valores de desintonía $Dpa$. Como se muestra en la @fig:cavidad_fotones, el número medio de fotones $Nss$ muestra una directa dependencia con respecto a $Dpa$.

El perfil de la curva obtenida corresponde a una Lorentziana centrada en $Dpa=0$, característica de una cavidad óptica @carmichael_statistical_1999[$section 1.5.3$]. Es decir, la máxima inyección de fotones ocurre cuando el láser de bombeo y el modo de la cavidad están perfectamente sincronizados.

#figure(
  image("../assets/figuras/cavidad_fotones.png"),
  caption: [Espectro de trasmisión de la cavidad vacía en el estado estacionario. Se grafica el número de fotones $Nss$ en función de la desintonía del campo de bombeo $Dpa$. La curva describe una distribución Lorentziana, con un máximo de transmisión en resonancia perfecta $Dpa=0$. La desintonía está normalizada respecto a la disipación $kappa$. Los valores de los parámetros usados son $rabip = 1.0 kappa$, $kappa = 1.0$, $nmax = 10$.]
) <fig:cavidad_fotones>

Además, conforme aumenta la magnitud de desintonía, $abs(Dpa) > 0$, la probabilidad de que un fotón ingrese a la cavidad disminuye de manera significativa.

El análisis de este fenómeno se vuelve importante para el del sistema que estudiaremos más adelante, ya que la modificación de esta curva al introducir la presencia de átomos será una evidencia del acoplamiento luz-materia del régimen de electrodinámica cuántica de cavidades.