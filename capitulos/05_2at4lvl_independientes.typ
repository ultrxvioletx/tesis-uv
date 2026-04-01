// ===================================================================
// 05_2at4lvl_independientes.typ
// ===================================================================
#import "../style.typ": *


=== Dinámica colectiva


El siguiente paso es introducir un segundo átomo idéntico en la cavidad óptica.En esta sección, asumiremos que la distancia nuclear entre ambos átomos es lo suficientemente grande para que cualquier interacción directa (dipolo-dipolo o Van der Waals) sea nula ($Odr = Oee = 0$). Así, la única vía de comunicación entre los átomos es el campo electromagnético compartido por la cavidad.

En un modelo semiclásico, dos átomos que son independientes absorben y emiten luz de forma no correlacionada [CITAR AKI]. Sin embargo, de acuerdo con el modelo de Tavis-Cummings [CITAR AKI] (que representa la generalización del modelo de Jaynes-Cummings para un modelo de dos átomos idénticos acoplados a un modo de cavidad), el sistema no interactúa con los átomos individualmente, sino con un momento dipolar colectivo. Cuando están dentro del volumen de una cavidad en acoplamiento fuerte, el sistema no puede distinguir qué átomo específico ha absorbido o emitido un fotón; los dos átomos en el estado base $ket(g g)$ absorben un fotón de forma no localizada, formando una excitación simétrica llamada estado superradiante de Dicke:

$ ket(+) = 1/sqrt(2) (ket(s g) + ket(g s)) $

La consecuencia de esto es que la fuerza de acoplamiento efectiva entre el par de átomos y la cavidad se multiplican por un factor $sqrt(N_"at")$, donde $N_"at"$ es el número de átomos. Por tanto, en el caso específico de dos átomos $N_"at"=2$, se esperaría que el desdoblamiento de los polaritones se amplifique un factor de $sqrt(2) approx 1.41$.

Por otro lado, la superposición antisimétrica y ortogonal $ket(-) = 1/sqrt(2) (ket(s g) - ket(g s))$, llamado estado subradiante, posee un momento dipolar neto igual a cero [CITAR AKI], por lo que la cavidad no puede acceder a él (es decir, es oscuro a la luz de la cavidad) y la dinámica se restringe únicamente al ocasionado por el estado superradiante $ket(+)$.

Ahora que hemos introducido el segundo átomo, el espacio de Hilbert utilizado ya no está truncado y corresponde exactamente al discutido en la @sec:implem-numerica, dado por la @eq:hilbert_total, así como la ecuación maestra de Lindblad de la @eq:lindblad_total utilizando el Hamiltoniano total (@eq:hamiltoniano_total). Para visualizar la dinámica de la superposición coherente, se realizó un barrido de la sonda $scan$ de la sección anterior, pero ahora sobre la base extendida a dos átomos.

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
  caption: [Espectroscopía del sistema de dos átomos acoplados a la cavidad en ausencia de interacción de Rydberg ($Oee=0$). *(a)* Número medio de fotones en el estado estacionario *(b)* Probabilidad de encontrar una sola excitación $P_s$ (beige), que corresponde a $P_(s g) + P_(g s)$, y probabilidad de excitacion doble $P_(s s)$ (verde). Se observa una separación de las resonancias más estrecha en comparación con el caso de un solo átomo. Los parámetros utilizados son: $rabip = 0.5$, $rabic = 20.0$, $g = 15.0$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.0$, $Oee=0$, $nmax = 3$.]
) <fig:2at4lvl_independientes>

Al analizar la separación entre los picos de transmisión, se esperaría que el desdoblamiento de los picos medido en la sección anterior ($3.09 kappa$) se incremente por el factor $sqrt(2)$, dando como resultado $d2 approx 4.35 kappa$. Sin embargo, la espectroscopía de la @fig:2at4lvl_independientes muestra una separación de $5.6 kappa$, que representa un factor de ensanchamiento de $sim 1.81$.

Esta diferencia es causada por los corrimientos Stark colectivos del sistema, ya que el campo vacío de la cavidad induce un desplazamiento en el nivel $kg$. Al introducir el segundo átomo en la cavidad, ambos átomos contribuyen de forma simultánea a este corrimiento cuando el sistema se encuentra en el estado $ket(g g)$. Por tanto, el desplazamiento se duplica [CITAR AKI] $2 sg = 2 g^2/Delta = 4.5 kappa$, mientras que el desplazamiento de $ks$ se mantiene igual $ss = 1.0 kappa$ ya que el estado superradiante contiene una excitación compartida.

Así, finalmente obtenemos analíticamente la distancia de los picos como:

$ d2 = sqrt((2sg - ss)^2 + 4(sqrt(2) geff)^2) approx 5.5 kappa $

Por otro lado, la @fig:2at4lvl_independientes también muestra que, al no existir interacción entre los átomos, el sistema es capaz de absorber dos fotones a la vez; la curva verde muestra que el estado doblemente excitado $ket(s s)$ tiene una probailidad de $P_(s s) approx 0.25$ en el pico izquierdo. Por lo tanto, se confirma que los átomos operan de forma independiente entre sí.