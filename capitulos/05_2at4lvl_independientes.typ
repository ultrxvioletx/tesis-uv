// ===================================================================
// 05_2at4lvl_independientes.typ
// ===================================================================
#import "../style.typ": *


Ahora que hemos recorrido por el análisis de distintos parámetros de un átomo en cascada acoplado al modo de la cavidad, nos interesa continuar con el siguiente paso para llegar al sistema final de interés.

Mediante la técnica de eliminación adiabática, se consiguió una descripción efectiva para transición de dos fotones hacia el estado de Rydberg sin perder la coherencia del sistema aun con la disipación del nivel intermedio. Ahora que hemos caracterizado el espectro del átomo efectivo en el régimen de acoplamiento fuerte, tenemos todo lo necesario para simular la dinámica de dos átomos interactuando entre sí.

En este capítulo estudiaremos la transición entre el comportamiento de la cavidad y los fenómenos de interacción de los átomos, dividiéndolo en dos partes. En la primera, se introduce otro átomo a la cavidad asumiendo una distancia entre sus núcleos lo suficientemente grande para despreciar interacciones dipolares, y que nos permite observar efectos cooperativos como la súperradiancia y estados de Dicke descritos por el Hamiltoniano de Tavis-Cummings.

En la segunda fase, se consideran distancias cercanas tal que la interacción de resonancia de Föster es relevante para observar cómo cambia la dinámica de la excitación, bloqueando el acceso a estados doblemente excitados, y a su vez el cambio de la estructura espectral del sistema.


=== Dinámica de dos átomos Rydberg-independientes


Consideraremos ahora un segundo átomo idéntico dentro de la cavidad óptica. En esta sección, asumiremos que la distancia nuclear entre ambos átomos es lo suficientemente grande para que cualquier interacción directa (dipolo-dipolo o Van der Waals) sea nula ($Cdr = Cee = 0$). Así, la única vía de comunicación entre los átomos es el campo electromagnético compartido por la cavidad.

En un modelo semiclásico, dos átomos que son Rydberg-independientes (no interactúan entre sí vía fuerzas de Rydberg) absorben y emiten luz de forma no correlacionada @gelhausen_dissipative_2018. Sin embargo, de acuerdo con el modelo de Tavis-Cummings @tavis_exact_1968 (que representa la generalización del modelo de Jaynes-Cummings para un modelo de $nat$ átomos idénticos acoplados a un modo de cavidad), el sistema no interactúa con los átomos individualmente, sino con un momento dipolar colectivo.

Cuando están dentro del volumen de una cavidad en acoplamiento fuerte, el sistema no puede distinguir qué átomo específico ha absorbido o emitido un fotón; los dos átomos en el estado base $kss$ absorben un fotón de forma no localizada. En estudios de emisión colectiva en el límite de Dicke @brooke_super_2008, la simetría del acoplamiento hace que los estados accesibles sean los dos de excitación compartida.

Por un lado, el sistema oscila entre $kgg$ y el estado simétrico (o estado superradiante) de Dicke:

$ dicke1 = 1/sqrt(2) (ket(s g) + ket(g s)). $

La consecuencia de esto es que el momento dipolar de transición se amplifica de forma cooperativa. Así, la fuerza de acoplamiento efectiva entre los átomos y la cavidad en resonancia se multiplica por un factor $sqrt(nat)$, donde $nat$ es el número de átomos. Por tanto, en el caso específico de dos átomos $nat=2$, el desdoblamiento de los estados vestidos se amplifica un factor de $sqrt(2) approx 1.41$.

Por otro lado, el sistema también oscilaría entre $kgg$ y el estado antisimétrico (estado subradiante):

$ dicke2 = 1/sqrt(2) (ket(s g) - ket(g s)) $

que posee un momento dipolar neto igual a cero debido a la interferencia destructiva. Sin embargo, como no está acoplado a la cavidad, actúa como un subespacio oscuro y entonces el bombeo no puede acceder a él (es decir, es oscuro a la luz de la cavidad), por lo que la dinámica de absorción y transmisión se restringe únicamente al ocasionado por el estado superradiante $ket(Psi_+)$, bajo el estado:

$ ket(0 Psi_+)_"Dicke" = 1/sqrt(2) (ket(G 1) +- ket(Psi_+ 0)_"Dicke") $

donde $ket(G 1)$ es el estado base colectivo ($ket(G) = kgg$) y 1 fotón, y $ket(Psi_+ 0)_"Dicke"$ es el estado superradiante de Dicke y 0 fotones.

Ahora que hemos introducido el segundo átomo, el espacio de Hilbert utilizado corresponde exactamente al discutido en @sec:implem-numerica, dado por la @eq:hilbert_total (con dimensión $9 nmax$), así como la ecuación maestra de Lindblad de @eq:lindblad_total utilizando el Hamiltoniano total de @eq:hamiltoniano_total. Para visualizar la dinámica de la superposición coherente, se realizó un barrido de la sonda $scan$, pero ahora sobre la base extendida a dos átomos.

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
  caption: [Espectro del sistema de dos átomos acoplados a la cavidad en ausencia de interacción de Rydberg ($Oee=0$). *(a)* Número medio de fotones en el estado estacionario *(b)* Probabilidad de encontrar una sola excitación $Ps$ (triángulos), que corresponde a $P1s$, y probabilidad de excitacion doble $Pss$ (círculos). Se observa una separación de las resonancias más estrecha en comparación con el caso de un solo átomo. Los parámetros utilizados son: $rabip = 0.5 kappa$, $rabic = 20.0 kappa$, $g = 15.0 kappa$, $kappa = 1.0$, $dece = 1.0 kappa$, $decs = 0.0 kappa$, $Oee=0.0 kappa$, $nmax = 3$.]
) <fig:2at4lvl_independientes>


Al analizar la separación entre los picos de transmisión de la @fig:2at4lvl_independientes, se observa una separación de $sim 5.71 kappa$, causada por dos efectos involucrados: la desintonía del sistema efectivo provocada por los corrimientos Stark colectivos, y el factor $sqrt(2)$ del segundo átomo.

Como se discutió en @sec:elim_adiabatica, el campo vacío de la cavidad induce un desplazamiento en el nivel $kg$. Al introducir el segundo átomo en la cavidad, ambos átomos contribuyen a este corrimiento cuando el sistema se encuentra en el estado $kss$. Por tanto, $sg$ se duplica, mientras que $ss$ se mantiene igual, ya que el estado superradiante comparte la excitación.

Así, utilizando la @eq:delta_energias y @eq:rabi_g con cero fotones, obtenemos analíticamente la distancia de los picos como:

$ d2 = delta E = sqrt(4(sqrt(2) geff)^2 + (ss - 2sg)^2) approx 5.5 kappa. $

Además, ahora que los subsistemas están aún más desintonizados, esta vez por una distancia $Delta S = 2 sg - ss approx 3.5 kappa$, la asimetría de los picos discutida en el capítulo anterior es aún más dramática.

Esto es, el pico derecho $scan \/ kappa approx 4.8$ tiene un carácter fotónico casi puro y domina la transmisión de la cavidad, mientras que la excitación atómica en ese punto es prácticamente despreciable. Por otro lado, en el pico izquierdo $scan \/ kappa approx -0.7$ tiene un carácter atómico predominante y la transmisión de la cavidad disminuye.

La @fig:2at4lvl_independientes también muestra que, al no existir interacción entre los átomos, el sistema es capaz de absorber dos fotones a la vez; la curva verde muestra que el estado doblemente excitado $kss$ tiene una probabilidad de $Pss approx 0.25$, mientras que la curva beige nos dice que la probabilidad de que al menos uno de los dos esté excitado es $P1s approx 0.5$. Por lo tanto, se confirma que los átomos operan de forma Rydberg-independiente entre sí.