// ===================================================================
// 05_2at4lvl_independientes.typ
// ===================================================================
#import "../style.typ": *


En el capítulo anterior se estableció la base constructiva necesaria para poder identificar los fenómenos involucrados en nuestro sistema de interés, que consiste en dos átomos de cuatro niveles dentro de la cavidad. Mediante la técnica de eliminación adiabática, se consiguió una transición efectiva de dos fotones hacia el estado de Rydberg sin perder la coherencia del sistema aún con la disipación del nivel intermedio. Ahora que hemos caracterizado la espectroscopía de el átomo efectivo en el régimen de acoplamiento fuerte, tenemos todo lo necesario para abordar la dinámica de dos átomos interactuantes.

En este capítulo estudiaremos la transición entre el comportamiento de la cavidad y los fenómenos de interacción de los átomos, dividiéndolo en dos partes. En la primera, se introduce el segundo átomo a la cavidad, asumiendo una distancia entre sus núcleos lo suficientemente grande para despreciar interacciones dipolares, y que nos permite obserbar efectos cooperativos como la súperradiancia y estados de Dicke en el marco de Tavis-Cummings.

En la segunda fase, se activa la interacción de Van der Waals de átomos de Rydberg para observar cómo cambia la dinámica de la excitación, suprimiendo el acceso a estados de doble excitación, y a su vez el cambio de la estructura espectral de la cavidad.


=== Dinámica de dos átomos independientes


El siguiente paso es introducir un segundo átomo idéntico en la cavidad óptica.En esta sección, asumiremos que la distancia nuclear entre ambos átomos es lo suficientemente grande para que cualquier interacción directa (dipolo-dipolo o Van der Waals) sea nula ($Odr = Oee = 0$). Así, la única vía de comunicación entre los átomos es el campo electromagnético compartido por la cavidad.

En un modelo semiclásico, dos átomos que son independientes absorben y emiten luz de forma no correlacionada [CITAR AKI]. Sin embargo, de acuerdo con el modelo de Tavis-Cummings [CITAR AKI] (que representa la generalización del modelo de Jaynes-Cummings para un modelo de dos átomos idénticos acoplados a un modo de cavidad), el sistema no interactúa con los átomos individualmente, sino con un momento dipolar colectivo. Cuando están dentro del volumen de una cavidad en acoplamiento fuerte, el sistema no puede distinguir qué átomo específico ha absorbido o emitido un fotón; los dos átomos en el estado base $ket(g g)$ absorben un fotón de forma no localizada, formando una excitación simétrica llamada estado superradiante de Dicke:

$ ket(+) = 1/sqrt(2) (ket(s g) + ket(g s)) $

La consecuencia de esto es que la fuerza de acoplamiento efectiva entre los átomos y la cavidad se multiplican por un factor $sqrt(N_"at")$, donde $N_"at"$ es el número de átomos. Por tanto, en el caso específico de dos átomos $N_"at"=2$, se esperaría que el desdoblamiento de los polaritones se amplifique un factor de $sqrt(2) approx 1.41$.

Por otro lado, la superposición antisimétrica y ortogonal $ket(-) = 1/sqrt(2) (ket(s g) - ket(g s))$, llamado estado subradiante, posee un momento dipolar neto igual a cero [CITAR AKI], por lo que la cavidad no puede acceder a él (es decir, es oscuro a la luz de la cavidad) y la dinámica se restringe únicamente al ocasionado por el estado superradiante $ket(+)$.

Ahora que hemos introducido el segundo átomo, el espacio de Hilbert utilizado ya no está truncado y corresponde exactamente al discutido en la @sec:implem-numerica, dado por la @eq:hilbert_total, así como la ecuación maestra de Lindblad de la @eq:lindblad_total utilizando el Hamiltoniano total de la @eq:hamiltoniano_total. Para visualizar la dinámica de la superposición coherente, se realizó un barrido de la sonda $scan$ de la sección anterior, pero ahora sobre la base extendida a dos átomos.

#figure(
  stack(
    dir: ttb,
    spacing: 0em,
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: (top, top),
      [*(a)*],
      image("../assets/figuras/2at4lvl_fotones0.png"),
    ),
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: (top, top),
      [*(b)*],
      image("../assets/figuras/2at4lvl_excitado0.png"),
    ),
  ),
  caption: [Espectroscopía del sistema de dos átomos acoplados a la cavidad en ausencia de interacción de Rydberg ($Oee=0$). *(a)* Número medio de fotones en el estado estacionario *(b)* Probabilidad de encontrar una sola excitación $Ps$ (beige), que corresponde a $P1s$, y probabilidad de excitacion doble $Pss$ (verde). Se observa una separación de las resonancias más estrecha en comparación con el caso de un solo átomo. Los parámetros utilizados son: $rabip = 0.5$, $rabic = 20.0$, $g = 15.0$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.0$, $Oee=0$, $nmax = 3$.]
) <fig:2at4lvl_independientes>

Al analizar la separación entre los picos de transmisión, se esperaría que el desdoblamiento de los picos medido en la sección anterior ($3.09 kappa$) se incremente por el factor $sqrt(2)$, dando como resultado $d2 approx 4.35 kappa$. Sin embargo, la espectroscopía de la @fig:2at4lvl_independientes muestra una separación de $5.6 kappa$, que representa un factor de ensanchamiento de $sim 1.81$.

Esta diferencia es causada por los corrimientos Stark colectivos del sistema, ya que el campo vacío de la cavidad induce un desplazamiento en el nivel $kg$. Al introducir el segundo átomo en la cavidad, ambos átomos contribuyen de forma simultánea a este corrimiento cuando el sistema se encuentra en el estado $ket(g g)$. Por tanto, el desplazamiento se duplica [CITAR AKI] $2 sg = 2 g^2/Delta = 4.5 kappa$, mientras que el desplazamiento de $ks$ se mantiene igual $ss = 1.0 kappa$, ya que el estado superradiante comparte la excitación.

Así, finalmente obtenemos analíticamente la distancia de los picos como:

$ d2 = sqrt((2sg - ss)^2 + 4(sqrt(2) geff)^2) approx 5.5 kappa $

Además de la separación de los picos, la magnitud del corrimiento Stark colectivo desplaza el centro del sistema hacia energías positivas [CITAR AKI], y da como resultado que la asimetría de los polaritones discutida en el capítulo anterior sea aún más dramática. Esto es, el pico derecho $scan /\ kappa approx 4.8$ tiene un carácter fotónico casi puro, y domina la transmisión de la cavidad mientras que la excitación atómica en ese punto es prácticamente despreciable. Por otro lado, en el pico izquierdo $scan /\ kappa approx -0.9$ tiene un carácter atómico predominante y la transmisión de la cavidad disminuye.

La @fig:2at4lvl_independientes también muestra que, al no existir interacción entre los átomos, el sistema es capaz de absorber dos fotones a la vez; la curva verde muestra que el estado doblemente excitado $kss$ tiene una probailidad de $Pss approx 0.25$, mientras que la curva beige nos dice que la probabilidad de que al menos uno de los dos esté excitado es $P1s approx 0.5$. Por lo tanto, se confirma que los átomos operan de forma independiente entre sí.