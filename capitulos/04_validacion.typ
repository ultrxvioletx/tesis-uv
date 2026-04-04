// ===================================================================
// 04_validacion.typ
// ===================================================================
#import "../style.typ": *


Antes de estudiar la dinámica acoplada de dos átomos interaccionando, es importante establecer la validez del método numérico implementado y definir las bases físicas que rigen el sistema principal. En este capítulo, se utiliza la paquetería OpenKet para analizar fenómenos cuánticos bien conocidos analíticamente. Dicha discusión se divide en dos etapas.

Primero, en las primeras dos secciones se aíslan los subsistemas más elementales: el átomo de dos niveles y el modo de cavidad disipativo, esto con el objetivo de garantizar que los términos del Hamiltoniano y los superoperadores de pérdida funcionan de manera precisa.

Posteriormente, en la @sec:1at4lvl, se introduce un único átomo de cuatro niveles en la cavidad. A través del análisis de las poblaciones atómicas y del campo intracavidad, se caracterizarán fenómenos de interferencia cuántica como el desdoblamiento _vacuum Rabi_, el efecto Autler-Townes y la Transparencia Inducida Electromagnética (EIT). Esto nos permite obtener sistemas de referencia para lograr identificar la fenomenología nueva causada en nuestro sistema de interés al introducir un segundo átomo en el @cap:bloqueo.


=== Oscilaciones de Rabi en un átomo de dos niveles <sec:1at2lvl>

#figure(
  diagrama(cell-size: 1mm,
          mark-scale: 130%,
          edge((0,2),(2,2)),
          node((2,2), $kg$),
          edge((0.5,2),(0.5,0.4), "<->", $wc$, label-side: left, "wave"),
          edge((-0.5,0.4),(1.5,0.4), "--", $Delta$),
          edge((0,0),(2,0)),
          node((2,0), $ke$)
  ),
  caption: [Diagrama de la interacción de un átomo de dos niveles en cuasiresonancia con un campo electromagético, con desintonía $Delta$.]
) <fig:1at2lvl_sistema>


El sistema cuántico de interacción luz-materia más elemental es un átomo de dos niveles (@fig:1at2lvl_sistema), interactuando con un campo electromagnético clásico. De acuerdo con la teoría clásica de interacción, ignorando efectos de decaimiento y bajo la aproximación de onda rotante (RWA), la probabilidad de encontrar al átomo en el estado excitado evoluciona en el tiempo y está dada analíticamente por la fórmula de Rabi (descrita en @cap:teoría):

#figure(
  image("../assets/figuras/1at2lvl.png", width: 100%),
  caption: [Evolución temporal de la probabilidad de excitación $Pe (t)$ para un átomo de dos niveles interactuando con un campo clásico, partiendo del estado base $kg$. Los marcadores cuadrados representan los resultados obtenidos numéricamente usando la integración de la ecuación maestra (@eq:1at2lvl_maestra) con OpenKet, mientras que las líneas continuas corresponden a la solución analítica de la @eq:1at2lvl_analitica. Se observan tres valores de desintonía: total resonancia $Delta = 0.0$ (verde), y fuera de resonancia $Delta = 2.0$ (morado), $Delta = 4.0$ (naranja). El tiempo está normalizado respecto a la frecuencia de Rabi $rabic$, cuyo valor es $rabic = 2.0$.],
) <fig:1at2lvl>

$ Pe (t) = rabic^2 / rabir^2 sin^2(rabir/2 t) $ <eq:1at2lvl_analitica>

donde $rabic$ es la frecuencia de Rabi que caracteriza la intensidad de acomplamiento entre los niveles $kg <-> ke$, y $rabir = sqrt(rabic^2 + Delta^2)$ es la frecuencia de Rabi generalizada, la cual depende de la desintonía $Delta$ entre la frecuencia del láser y la frecuencia de transición atómica.

Para poder simular este sistema, se truncó el espacio de Hlbert a un sistema sin cavidad y de un solo átomo, $HH = HHa1$, del que se consideraron únicamente sus primeros dos niveles, aislando los términos correspondientes en el Hamiltoniano general (@eq:hamiltoniano_total). Así, los Hamiltonianos utilizado son

$ Ha = hbar Delta sig(g,g) $ <eq:1at2lvl_Ha>
$ Hi = -hbar/2 rabic (sig(e,g) + sig(g,e)) $ <eq:1at2lvl_Hi>

y, debido a que no se consideraron efectos de decaimiento, la ecuación maestra de Lindblad se reduce simplemente a la ecuación de Von Neumann:

$ dot(rr) = -i/hbar [Ha + Hi, rr] $ <eq:1at2lvl_maestra>

con condiciones iniciales $rr (t_(=0)) = ketbra(g,g)$.

Como se observa en la @fig:1at2lvl, la integración numérica es bastante precisa con la solución analítica para todos los regímenes de desintonía evaluados. En el caso de total resonancia $Delta = 0.0$, el sistema oscila perfectamente entre los valores 0 y 1 a una frecuencia dada puramente por $rabic$.

Al introducir desintonía no nula ($Delta = 2.0$ y $Delta = 4.0$), se observan dos efectos explicados por la teoría semiclásica @gerry_introductory_2005[cap.4]: por un lado, la amplitud máxima de excitación es menor, disminuyendo drásticamente la probabilidad de que el átomo se encuentre excitado; y, por otro lado, la frecuencia de las oscilaciones aumenta conforme el sistema oscila a la frecuencia de Rabi generalizada $rabir$.

Esto valida que OpenKet logra simular correctamente los efectos de desintonía en el acoplamiento átomo-láser.


=== Inyección y disipación de fotones en una cavidad vacía <sec:cavidad>


Ahora, el siguiente paso para la calibración del modelo es la implementación de términos no unitarios, es decir, la inyección y pérdida de excitaciones en un sistema abierto. Para ello, se realizó la simulación de un modo de cavidad en ausencia de átomos.

La dinámica de este sistema se rige por la _competencia_ entre el bombeo externo (con intensidad $rabip$) que inyecta fotones al modo de la cavidad, y la tasa de decaimiento $kappa$ que modela la fuga de los fotones a través de los espejos.

Nuevamente, reducimos el espacio de Hilbert, pero ahora a un sistema de la cavidad sin átomos, $HH = HHc$, por lo que los términos sobrevivientes del Hamiltoniano de la @eq:hamiltoniano_total son:

$ Hc = hbar Delta (cre anh + 1/2) $ <eq:cavidad_Hc>
$ Hb = i hbar rabip (cre - anh) $ <eq:cavidad_Hb>

donde $Delta$ en este contexto corresponde a la desintonía entre la frecuencia del láser de bombeo y la resonancia de la cavidad, por lo que la ecuación maestra que describe el proceso de esta subsección es:

$ dot(rr) = -i/hbar [Hc + Hb, rr] + kappa/2 LL[anh] $ <eq:maestra_cavidad>

y se usaron las condiciones iniciales $rr (t_(=0)) = ketbra(0,0)$.

Analíticamente, el número medio de fotones dentro de la cavidad $Nexp (t)$ evoluciona hacia un estado estacionario dado por el balance entre la ganacia de fotones y la pérdida de estos. Si el sistema parte del vacío cuántico, la solución analítica establece que el campo dentro de la cavidad evoluciona como un estado coherente $ket(alpha (t))$ @gerry_introductory_2005[cap.8], cuya amplitud compleja está descrita por:

$ alpha(t) = alpha_"ss" (1 - e^(-(kappa/2 + i Delta) t)) $ <eq:analitica_cavidad>

donde $alpha_"ss" = rabip / (kappa/2 + i Delta)$ es la amplitud del campo en el límite $t -> infinity$ @walls_quantum_2008[cap.7]. Por lo tanto, el número medio de fotones se calcula como $Nexp (t) = abs(alpha(t))^2$.

#figure(
  image("../assets/figuras/cavidad.png"),
  caption: [Evolución temporal del número medio de fotones $Nexp$ en una cavidad bombeada con disipación, en calidad de resonancia $Delta=0$. Los marcadores cuadrados representan la simulación numérica obtenida de alimentar a OpenKet con la @eq:maestra_cavidad, partiendo del estado de vacío $ket(0)$, mientras que la línea continua representa la solución analítica dada por la @eq:analitica_cavidad. El tiempo está normalizado respecto a la frecuencia de Rabi $rabip$. Los valores de los parámetros usados son: $rabip = 1.0$, $kappa = 1.0$, $N_max = 15$, dando un valor de $abs(alpha_"ss")^2 = 4$.]
) <fig:cavidad>

Luego, para caracterizar la espectroscopía del sistema, se simuló su dinámica hasta alcanzar el estado estacionario ($t -> infinity$) para un barrido de valores de desintonía $Delta$. Como se muestra en la @fig:cavidad_fotones, el número medio de fotones dentro de la cavidad $Nss$ muestra una directa dependencia con respecto a $Delta$.

#figure(
  image("../assets/figuras/cavidad_fotones.png"),
  caption: [Espectro de trasmisión de la cavidad vacía en el estado estacionario. Se grafica el número de fotones $Nss$ en función de la desintonía del campo de bombeo $Delta$. La curva describe una distrución Lorentziana, con un máximo de transmisión en resonancia perfecta $Delta=0$. La desintonía está normalizada respecto a la disipación $kappa$. Los valores de los parámetros usados son $rabip = 1.0$, $kappa = 1.0$, $nmax = 10$.]
) <fig:cavidad_fotones>

El perfil de la curva obtenida corresponde a una Lorentziana centrada en $Delta=0$, característica de una cavidad óptica @carmichael_statistical_1999[cap.1]. Es decir, la máxima inyección de fotones ocurre cuando el láser de bombeo y el modo de la cavidad están perfectamente sincronizados. Además, conforme aumenta la magntud de desintonía, $abs(Delta) > 0$, la probabilidad de que un fotón ingrese a la cavidad disminuye de manera significativa.

El análisis de este fenómeno se vuelve importante para el del sistema posterior, ya que la modificación de esta curva al introducir la presencia de átomos será una evidencia del acoplamiento luz-materia del régimen de electrodinámica cuántica de cavidades.