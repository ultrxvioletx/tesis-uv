// ===================================================================
// 05_2at4lvl_bloqueo.typ
// ===================================================================
#import "../style.typ": *


=== Interacción interatómica y bloqueo de Rydberg


Ahora que finalmente se considera la interacción entre los átomos, es importante discutir por un momento la presencia del nivel $kp$, que por primera vez es relevante en los modelos simulados. El modelo que se considera y que es implementado en OpenKet genera el bloqueo de manera tal que se requiere un átomo de 4 niveles: los niveles $kg$ y $ks$ constituyen el sistema efectivo de dos niveles donde ocurre toda la dinámica principal; $ke$ funciona exclusivamente como el escalón que permite la transición de múltiples fotones y que queda suprimido bajo eliminación adiabática; y $kp$ es un estado auxiliar de Rydberg cuyo propósito es permitir el bloqueo. A diferencia de los otros niveles, $kp$ es el único que no es acoplado bajo ningún láser.

El bloqueo surge de forma natural a través de la interacción dipolo-dipolo bajo resonancia de Föster, como se explica en @sec:descripcion-sistema. Para observarlo, se simula mediante el término $Oee$, el cual acopla el estado doblemente excitado $kss$ con el estado auxiliar $kpp$, y cuantifica la fuerza de la interacción repulsiva.


==== Supresión de $Pss$


Se simuló la probabilidad de excitación en estado estacionario, fijando el láser de prueba en la frecuencia de resonancia del pico izquierdo $scan \/ kappa approx -0.7722$ (valor obtenido del sistema en la sección anterior), y se realizó el barrido incrementando la fuerza de interacción $Oee$ (@fig:2at4lvl_excitado_omegas).

Veamos que la @fig:2at4lvl_excitado_omegas muestra la disminución de probabilidad de doble excitación. Para valores de interacción tales que $Oee approx 0$, la probabilidad de encontrar al sistema en el estado doblemente excitado es $Pss approx 0.25$ (curva verde), lo que coincide con la mitad de probabilidad de una sola excitación $P1s$ (curva beige).

Sin embargo, a medida que la fuerza de interacción $Oee$ aumenta, la curva de $Pss$ experimenta una disminución hasta cero, lo que confirma el bloqueo de Rydberg y que el sistema se vuelve incapaz de absorber dos fotones de manera simultánea.

#pagebreak()
#figure(
  placement: top,
  stack(
    dir: ttb,
    spacing: 0em,
    image("../assets/figuras/2at4lvl_excitado_omegas.png"),
  ),
  caption: [Probabilidad de ocupación de los estados $Pss$ (círculos) y $P1s$ (triángulos) para distintos valores de interacción $Oee$. Se obverva una supresión total de la doble excitación cuando la interacción aumenta. Los parámetros utilizados son: $rabip = 0.5$, $rabic = 20.0$, $g = 15.0$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.0$, $scan=-0.7722$, $nmax = 3$.]
) <fig:2at4lvl_excitado_omegas>

#figure(
  kind: "wide",
  image("../assets/figuras/2at4lvl_excitado_grid.png", width: 100%),
  caption: [Probabilidad de excitación de dos átomos acoplados dentro de la cavidad con distintos valores de interacción $Oee$. Se muestra la probabilidad de encontrar una sola excitación $Ps$ (triángulos), que corresponde a $P1s$, y probabilidad de excitacion doble $Pss$ (círculos). Se observa una supresión de excitación doble conforme aumenta el término de interacción. Los parámetros utilizados son: $rabip = 0.5$, $rabic = 20.0$, $g = 15.0$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.0$, $nmax = 3$.]
) <fig:2at4lvl_excitado_bloqueo>
#pagebreak()

Es importante notar que la probabilidad de una sola excitación, $P1s$, también muestra una disminución inicial hasta estabilizarse en un valor de $sim 0.4$ para $Oee$ grandes. Como lo mencionaremos en la siguiente sección, esto no es consecuencia de que el sistema no pueda tener una sola excitación, sino de un dezplazamiento extra en los niveles de energía que mueve la resonancia fuera del valor inicial en $scan \/ kappa approx -0.7722$.

Físicamente, al estar $kss$ energéticamente prohibido, el sistema se "trunca" a un espacio de Hilbert que oscila entre $kgg$ y $ket(Psi^+)$ con frecuencia de Rabi $sqrt(2) rabic$ @gaetan_observation_2009, formando un súper-átomo efectivo de dos niveles. A pesar de tener dos átomos y que ambos interactúan con un campo, el súper-átomo absorbe solamente un fotón a la vez, y el sistema completo se convierte en uno que emite fotones individuales de manera no localizada.


==== Desdoblamiento por interacciones y DIET


Ahora que hemos observado la supresión del nivel $kss$, queremos ver cómo se manifiesta este bloqueo en los picos de los estados vestidos. Para ello, se realiza el barrido de $scan$ para distintos valores de $Oee \/ kappa in {0.1, 1.0, 5.0, 10.0, 15.0, 20.0}$ (@fig:2at4lvl_excitado_bloqueo).


Recodemos que en el modelo que se implementó, el término $Oee$ actúa como un acoplamiento resonante entre $kss$ y el estado $kpp$ (resonancia de Föster). De manera análoga a lo que se discutió en @sec:vacuum_rabi para el caso de un átomo, al hacer actuar esta interacción los estados desnudos originales dejan de ser eigenestados del Hamiltoniano total del sistema, y la repulsión dipolar desplaza el nivel de energía $kss$ en un nuevo par de estados vestidos colectivos (@fig:bloqueo):

$ ket(Psi_(+-))_"Föster" = 1/sqrt(2) (kss +- kpp) $

cuyos eigenvalores (energías) están desplazadas por $+- hbar Oee$ respecto a la energía del estado $kss$. Esto ocasiona un desdoblamiento Autler-Townes que afecta a los estados $kss$ y $kpp$, pero sólo provocado por interacciones interatómicas.

A medida que $Oee$ va aumentando, el estado $ket(Psi_+)_"Föster"$ es desplazado hacia frecuencias mayores. Notemos en la @fig:2at4lvl_excitado_bloqueo que, para valores de $Oee \/ kappa = 10.0, 15.0$, el estado no desaparece sino que reaparece como un pico más pequeño de $Pss$. Precisamente, no es que el estado de doble excitación se destruya, sino que se es inaccesible energéticamente por el doble láser, pero si es alcanzado por el ancho de línea del láser de prueba de la cavidad, aún puede ser poblado. En el caso de interacción fuerte ($Oee \/ kappa >= 20.0$), este estado ha sido desplazado tan lejos de la resonancia de la cavidad y del sistema que ya no es posible excitarlo, mostrando el bloqueo.

Sin embargo, el desplazamiento de la energía no es el único fenómeno actuando. En el centro de la resonancia de dos fotones, el bloqueo está presente por el fenómeno de Transparencia Electromagnética Inducida por Dipolos (DIET) @puthumpallyjoseph_dipoleinduced_2014. Bajo este fenómeno, la interacción dipolo-dipolo genera una interferencia cuántica destructiva (como la discutida en @sec:EIT) entre los caminos para la excitación colectiva.

Partiendo del estado base colectivo $kgg$, la absorción del primer fotón está permitida hacia el estado superradiante:

$ kgg --> dicke1 = 1/sqrt(2) (ket(s g) + ket(g s)) $

y desde $dicke1$ el sistema intentaría absorber un segundo fotón para alcanzar el estado $kss$, con dos caminos de excitación posibles:

1. $dicke1 --> fost1$ (con desintonía $+Oee$)
2. $dicke1 --> fost2$ (con desintonía $-Oee$)

Y las amplitudes de probabilidad de estos dos caminos tienen fases opuestas (pero ahora en el punto de resonancia de dos fotones), por lo que se genera una interferencia cuántica destructiva.

A diferencia del EIT normal, que es ocasionado por la existencia del estado oscuro, en DIET es la interacción repulsiva la que controla la transparencia. Al cancelar las amplitudes de probabilidad de absorber un segundo fotón, el sistema se vuelve transparente a la doble absorción incluso para valores de interacción moderados.


==== Modificación del espectro de la cavidad


Ahora que hemos discutido sobre la dinámica a nivel átomico, por último analizaremos el comportamiento macroscópico del sistema visualizando la cantidad de fotones en la cavidad.

El cambio del sistema cooperativo al bloqueo se observa al medir la transmisión de la cavidad en una frecuencia fija (dada por el pico izquierdo, $scan \/ kappa approx 0.7722$). Vemos en la @fig:2at4lvl_fotones_omegas que cuanto menor es la interacción, la cavidad soporta un mayor número de fotones. Sin embargo, al incrementar $Oee$, la transmisión de la cavidad decae hasta estabilizarse en un valor no nulo, característica de una saturación cuántica @vogt_electricfield_2007: se produce una limitación del número de fotones que pueden ser absorbidos por el sistema, sin importar la potencia del láser.

También se realizó la evolución del espectro completo de la cavidad (@fig:2at4lvl_fotones_bloqueo), en función de la fuerza de interacción, con el objetivo de obtener un panorama más completo del comportamiento de los nuevos estados vestidos.

#pagebreak()
#figure(
  placement: top,
  stack(
    dir: ttb,
    spacing: 0em,
    image("../assets/figuras/2at4lvl_fotones_omegas.png"),
  ),
  caption: [Número promedio de fotones en la cavidad en función de $Oee$. Se obverva una saturación en el número de fotones que pueden ser absorbidos. Los parámetros utilizados son: $rabip = 0.5$, $rabic = 20.0$, $g = 15.0$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.0$, $scan=-0.7722$, $nmax = 3$.]
) <fig:2at4lvl_fotones_omegas>

#figure(
  kind: "wide",
  image("../assets/figuras/2at4lvl_fotones_grid.png", width: 100%),
  caption: [Número promedio de fotones en el caso de dos átomos acoplados dentro de la cavidad con distintos valores de interacción $Oee$. Observamos una desdoblamiento en el pico izquierdo, disminuyendo la amplitud de absorción. Los parámetros utilizados son: $rabip = 0.5$, $rabic = 20.0$, $g = 15.0$, $kappa = 1.0$, $dece = 1.0$, $decs = 0.0$, $nmax = 3$.]
) <fig:2at4lvl_fotones_bloqueo>

De forma análoga a lo observado en las poblaciones del átomo, el desdoblamiento Autler-Townes de la interacción repulsiva también aparece en el espectro de los fotones. El estado $fost1$ interactúa con el pico derecho (con mayor carácter fotónico) y se superpone con él, como se muestra cuando $Oee \/ kappa = 10.0$, deformándolo antes de desaparecer para interacciones más fuertes.

Finalmente, analizando la separación de los picos principales en el límite del bloqueo fuerte, la distancia entre ellos se mantiene constante en $d2 approx 5.71 kappa$ (tal como en la @fig:2at4lvl_independientes), conservando la distancia original dado por el sistema cooperativo independiente.