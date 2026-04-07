// ===================================================================
// 05_2at4lvl_bloqueo.typ
// ===================================================================
#import "../style.typ": *


=== Interacción interatómica y Bloqueo de Rydberg


==== Bloqueo en átomos de 4 niveles

@pillet_controllable_2009
Ahora que finalmente se considera la interacción entre los átomos, es importante discutir por un momento la presencia del nivel $kp$, que por primera vez es relevante en esta tesis. El modelo que se considera y que es implementado en OpenKet genera el bloqueo de manera orgánica, por lo que se requiere un átomo de 4 niveles: los niveles $kg$ y $ks$ constituyen el sistema efectivo de dos niveles donde ocurre toda la dinámica principal; $ke$ funciona exclusivamente como el escalón que permite la transición de múltiples fotones y que queda suprimido bajo eliminación adiabática; y $kp$ es un estado auxiliar de Rydberg cuyo propósito es permitir el bloqueo. A diferencia de los otros niveles, $kp$ es el único que no es acoplado bajo ningún láser.

El bloqueo surge de forma natural a través de la interacción dipolo-dipolo (resonancia de Föster [CITAR AKI]). El término de interacción repulsiva de largo alcance $Oee$ acopla fuertemente el estado doblemente excitado $kss$ con estados que incluyen al nivel auxiliar, como $kpp$ o $ket(s p)$. Esta interacción, que es intensa, induce un desplazamiento de energía en el nivel $kss$. Si este corrimiento causado por $Oee$ es más grande que el ancho de línea de la excitación (determinado por $geff$ y $kappa$), el láser se sale de la resonancia. De esta forma, uno de los átomos ya excitado en $ks$ modifica el entorno de su átomo vecino, e impide que absorba él un segundo fotón.

Para observar este fenómeno de bloqueo, se simuló la espectroscopía de absorción para distintos valores de $Oee in {0.1, 1.0, 10.0, 50.0}$, en función del barrido de $scan$.

#{
  let escala = 75%
  figure(
  stack(
    dir: ttb,
    spacing: 0em,
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: (top, top),
      [*(a)*],
      image("../assets/figuras/2at4lvl_excitado01.png", width: escala),
    ),
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: (top, top),
      [*(b)*],
      image("../assets/figuras/2at4lvl_excitado1.png", width: escala),
    ),
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: (top, top),
      [*(c)*],
      image("../assets/figuras/2at4lvl_excitado5.png", width: escala),
    ),
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: (top, top),
      [*(d)*],
      image("../assets/figuras/2at4lvl_excitado10.png", width: escala),
    ),
  ),
  caption: [Probabilidad de excitación de dos átomos acoplados dentro de la cavidad con distintos valores de interacción de Rydberg $Oee$ *(a)* $0.1$ *(b)* $1.0$ *(c)* $10.0$ *(d)* $50.0$. Se muestra la probabilidad de encontrar una sola excitación $Ps$ (beige), que corresponde a $P1s$, y probabilidad de excitacion doble $Pss$ (verde). Se observa una supresión de excitación doble conforme aumenta el término de interacción. Los parámetros utilizados son: $rabip = 0.5$, $rabic = 20.0$, $g = 15.0$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.0$, $nmax = 3$.]
)} <fig:2at4lvl_bloqueo_excitado>

Cuando los átomos interactúan débilmente ($Oee=0.1$), el sistema apenas alcanza a percibir el potencial repulsivo; en el pico izquierdo ($scan \/ kappa approx -0.9$) la probabilidad de encontrar a ambos átomos excitados de manera simultánea $Pss$ alcanza un valor no despreciable, lo que presenta un comportamiento similar al discutido en la sección anterior.

A medida que se incrementa el valor de la fuerza de interacción ($Oee=1.0$), el desplazamiento de energía del estado $kss$ empieza a alcanzar el ancho de línea de la cavidad [CIAR AKI]. Esto se traduce en la caída de la población del estado doblemente excitado, reduciéndose más o menos la mitad. El sistema se está volviendo opaco a la absorción de un segundo fotón.

Finalmente, el estado $kss$ queda completamente suprimido cuando la interacción se encuentra en el régimen fuerte ($Oee >= 10.0$), donde su probabilidad de ocupación se vuelve nula. Por lo tanto, se confirma el bloqueo de Rydberg, donde la fuerte repulsión impide el acceso a $kss$.

No está de más hacer el contraste de este colapso con el comportamiento de la probabilidad de una sola excitación $P1s$ que, a pesar de la anulación de $Pss$, la probabilidad de encontrar exactamente un átomo excitado se mantiene a pie. Esto nos dice que la interacción interatómica de cualquier magnitud no _apaga_ al sistema, sino que simplemente permite absorber el primer fotón sin problema pero prohíbe al segundo gracias a la existencia de $kp$, como si fuera un filtro [CITAR AKI].


==== Modificación del espectro de la cavidad


La supresión de la probabilidad $Pss$ no es aislada al comportamiento de la población de la cavidad. En un sistema sin interacciones, la cavidad actúa de forma linea a la entrada de fotones [CITAR AKI]. Sin embargo, al involucrar el nivel $kp$ para permitir el bloqueo de Rydberg, esta linealidad se pierde y se transforma en un sistema fuertemente no lineal [CITAR AKI].

#{
  let escala = 75%
  figure(
  stack(
    dir: ttb,
    spacing: 0em,
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: (top, top),
      [*(a)*],
      image("../assets/figuras/2at4lvl_fotones01.png", width: escala),
    ),
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: (top, top),
      [*(b)*],
      image("../assets/figuras/2at4lvl_fotones1.png", width: escala),
    ),
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: (top, top),
      [*(c)*],
      image("../assets/figuras/2at4lvl_fotones10.png", width: escala),
    ),
    grid(
      columns: (auto, 1fr),
      column-gutter: 0.3em,
      align: (top, top),
      [*(d)*],
      image("../assets/figuras/2at4lvl_fotones50.png", width: escala),
    ),
  ),
  caption: [Espectroscopía del sistema de dos átomos acoplados dentro de la cavidad con distintos valores de interacción de Rydberg $Oee$ *(a)* $0.1$ *(b)* $1.0$ *(c)* $10.0$ *(d)* $50.0$. Se observa una supresión de excitación doble conforme aumenta el término de interacción. Los parámetros utilizados son: $rabip = 0.5$, $rabic = 20.0$, $g = 15.0$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.0$, $nmax = 3$.]
)} <fig:2at4lvl_bloqueo_fotones>

En la @fig:2at4lvl_bloqueo_fotones se muestra el espectro de transmisión de la cavidad conforme aumenta la fuerza de interacción entre los átomos. Al comparar este comportamiento con el de la @fig:2at4lvl_independientes con los átomos independientes, hay dos modificaciones destacables con la presencia del bloqueo.

La primera, es que se deforma la estructura de los polaritones y aparece un pequeño pico central, en contraste con el régimen de interacción débil ($Oee=0.1$ y $1.0$) que se conserva el doble pico del _vacuum Rabi splitting_. En esta interacción fuerte $Oee >= 10.0$, la zona central que antes presentaba un mínimo de absorción ($scan \/ kappa approx 0.5$) y ahora posee una absorción no nula, evidencía la anharmonicidad inducida por el bloqueo [CITAR AKI].

En un sistema lineal (sin bloqueo), la cavidad puede escalar de manera libre por los estados de Jaynes-Cummings $ket(G 0) <-> ket(+ 1) <-> ket(ss 2)$; al bloquear el acceso a $kss$ mediante el nivel $kp$, se trunca esta escalera de excitación [CITAR AKI] y los fotones inyectados a la cavidad chocan contra la barrera de energía formada, alterando la interferencia de la luz dentro de la cavidad y generando nuevas formas de transmisión que no existían en el sistema lineal.

La segunda modificación es el ensanchamiento del desdoblamiento de los polaritones. Se observa que al cambiar del régimen de interacción débil al fuerte, los picos principales tienen una separación ligeramente mayor. Este desplazamiento es consecuencia de la redistribución de los eigenestados del sistema.