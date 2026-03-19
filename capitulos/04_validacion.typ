// ===================================================================
// 04_validacion.typ
// ===================================================================
#import "../style.typ": *

=== Validación con sistemas fundamentales
#let kg = $ket(g)$ //g
#let ke = $ket(e)$ //e
#let rabip = $Omega_p$ //rabi prueba
#let rabic = $Omega_c$ //rabi control
#let rabir = $Omega_R$ //rabi generalizado

#let Ha= $hat(H)_"atomo"$ //hamiltoniano atomo
#let Hi= $hat(H)_"interaccion"$ //hamiltoniano interaccion
#let Hb = $hat(H)_"bombeo"$ //hamiltoniano bombeo
#let Hc = $hat(H)_"cavidad"$ //hamiltoniano cavidad
#let cre = $hat(a)^dagger$ //creacion
#let anh = $hat(a)$ //aniquilacion
#let rr = $hat(rho)$ //operador densidad
#let LL = $cal(L)$ //lindblad
#let sig(ii,jj) = $sigma_(ii jj)$ //sigma

#let Nexp = $expval(N)$
#let Nss = $expval(N)_"ss"$

Antes de estudiar la dinámica acoplada de dos átomos interaccionando, es importante validar la precisión del modelo numérico implementado con OpenKet. En este capítulo se analizan sistemas de referencia bien conocidos analíticamente: un átomo de dos niveles con un láser (teoría semiclásica de interacción átomo-campo) y una cavidad óptica disipativa. Estos resultados, además de confirmar la confiabilidad del código, también nos permite construir por partes el modelo final y comprender mejor el bloqueo de excitación.


==== Oscilaciones de Rabi en un átomo de dos niveles


El sistema cuántico de interacción luz-materia más elemental es un átomo de dos niveles (con estado base $kg$ y estado excitado $ke$), interactuando con un campo electromagnético clásico. De acuerdo con la teoría clásica de interacción, ignorando efectos de decaimiento y bajo la aproximación de onda rotante (RWA), la probabilidad de encontrar al átomo en el estado excitado evoluciona en el tiempo y está dada analíticamente por la fórmula de Rabi [CITAR AKI (gerry-knigh)]:

$ P_e (t) = rabic^2 / rabir^2 sin^2((rabir t) / 2) $

donde $rabic$ es la frecuencia de Rabi que caracteriza la intensidad de acomplamiento entre los niveles $kg <-> ke$, y $rabir = sqrt(rabic^2 + Delta^2)$ es la frecuencia de Rabi generalizada, la cual depende del detuning $Delta$ entre la frecuencia del láser y la frecuencia de transición atómica.

Para poder simular este sistema, se truncó el espacio de Hlbert a un sistema sin cavidad y de un solo átomo, del que se consideraron únicamente sus primeros dos niveles, aislando los términos correspondientes en el Hamiltoniano general (@eq:hamiltoniano_total). Así, los Hamiltonianos utilizado son

$ Ha= hbar Delta sig(g,g) $
$ Hi= -hbar/2 rabic (sig(e,g) + sig(g,e)) $

y el Hamiltoniano total para esta Sección:

$ hat(H) = Ha+ Hi $

Además, no se consideraron efectos de decaimiento, por lo que la ecuación maestra de Lindblad se reduce simplemente a la ecuación de Von Neumman.

#figure(
  image("../assets/figuras/fig:deltas_atomo.png", width: 80%),
  caption: [Evolución temporal de la probabilidad de excitación $P_e (t)$ para un átomo de dos niveles interactuando con un campo clásico, partiendo del estado base $kg$. Los marcadores cuadrados representan los resultados obtenidos numéricamente usando la integración de la ecuación maestra con OpenKet, mientras que las líneas continuas corresponden a la solución analítica. Se observan tres valores de detuning: total resonancia $Delta = 0$ (rosa), y fuera de resonancia $Delta = 2.0$ (beige) y $Delta = 4.0$ (morado). El tiempo está normalizado respecto a la frecuencia de Rabi $rabic$, cuyo valor es $rabic = 2.0$.],
) <fig:deltas_atomo>

Como se observa en la @fig:deltas_atomo, la integración numérica es bastante precisa con la solución analítica para todos los regímenes de detuning evaluados. En el caso de total resonancia $Delta = 0.0$, el sistema oscila perfectamente entre los valores 0 y 1 a una frecuencia dada puramente por $rabic$.

Al introducir detuning no nulo ($Delta = 2.0$ y $Delta = 4.0$), se observan dos efectos explicados por la teoría semiclásica [CITAR AKI]: por un lado, la amplitud máxima de excitación es menor, disminuyendo drásticamente la probabilidad de que el átomo se encuentre excitado; y, por otro lado, la frecuencia de las oscilaciones aumenta conforme el sistema oscila a la frecuencia de Rabi generalizada $rabir$.

Esto valida que OpenKet logra simular correctamente los efectos de desintonía en el acoplamiento átomo-láser.


==== Inyección y disipación de fotones en una cavidad vacía


Ahora, el siguiente paso para la calibración del modelo es la implementación de términos no unitarios, es decir, la inyección y pérdida de excitaciones en un sistema abierto. Para ello, se realizó la simulación de un modo de cavidad en ausencia de átomos.

La dinámica de este sistema se rige por la _competencia_ entre el bombeo externo (con intensidad $rabip$) que inyecta fotones al modo de la cavidad, y la tasa de decaimiento $kappa$ que modela la fuga de los fotones a través de los espejos.

Nuevamente, reducimos el espacio de Hilbert, pero ahora a un sistema de la cavidad sin átomos, por lo que los términos sobrevivientes del Hamiltoniano de la @eq:hamiltoniano_total son:

$ Hc = hbar Delta (cre anh + 1/2) $
$ Hb = i hbar rabip (cre - anh) $

donde $Delta$ en este contexto corresponde a la desintonía entre la frecuencia del láser de bombeo y la resonancia de la cavidad, por lo que la ecuación maestra que describe el proceso de esta Sección es:

$ dot(rr) = -i[Hc + Hb, rr] + kappa/2 LL[a] $ <eq:maestra_cavidad>

Analíticamente, el número medio de fotones dentro de la cavidad $Nexp (t)$ evoluciona hacia un estado estacionario dado por el balance entre la ganacia de fotones y la pérdida de estos, si el sistema parte del vacío cuántico, la solución analítica establece que el campo dentro de la cavidad evoluciona como un estado coherente $ket(alpha (t))$, cuya amplitud compleja está descrita por [CITAR AKI]:

$ alpha(t) = alpha_"ss" (1 - e^(-(kappa/2 + i Delta) t)) $ <eq:analitica_cavidad>

donde $alpha_"ss" = rabip / (kappa/2 + i Delta)$ es la amplitud del campo en el límite $t -> infinity$. Por lo tanto, el número medio de fotones se calcula como $Nexp (t) = abs(alpha(t))^2$.

#figure(
  image("../assets/figuras/fig:conv_cavidad_disipacion.png", width: 80%),
  caption: [Evolución temporal del número medio de fotones $Nexp$ en una cavidad bombeada con disipación, en calidad de resonancia $Delta=0$. Los marcadores cuadrados representan la simulación numérica obtenida de alimentar a OpenKet con la @eq:maestra_cavidad, partiendo del estado de vacío $ket(0)$, mientras que la línea continua representa la solución analítica dada por la @eq:analitica_cavidad. El tiempo está normalizado respecto a la frecuencia de Rabi $rabip$. Los valores de los parámetros usados son: $rabip = 1.0$, $kappa = 1.0$, $N_max = 15$ (truncamiento de estados de Fock), dando un valor de $abs(alpha_"ss")^2 = 4$.]
) <fig:conv_cavidad_disipacion>

El sistema alcanza un estado estacionario, donde la inyección de fotones y la pérdida se equilibran.

Luego, para caracterizar la espectroscopía del sistema, se simuló su dinámica hasta alcanzar el estado estacionario ($t -> infinity$) para un barrido de valores de detuning $Delta$. Como se muestra en la @fig:deltas_cavidad_disipacion, el número medio de fotones dentro de la cavidad $Nss$ muestra una directa dependencia con respecto a $Delta$.

#figure(
  image("../assets/figuras/fig:deltas_cavidad_disipacion.png", width: 80%),
  caption: [Espectro de trasmisión de la cavidad vacía en el estado estacionario. Se grafica el número de fotones $Nss$ en función del detuning del campo de bombeo $Delta$. La curva describe una distrución Lorentziana, con un máximo de transmisión en resonancia exacta $Delta=0$ y un decaimiento simétrico que está determinado por la capacidad de reflexión de la pared de la cavidad [CITAR AKI] $kappa$.]
) <fig:deltas_cavidad_disipacion>

El perfil de la curva obtenida corresponde a una Lorentziana centrada en $Delta=0$, característica de una cavidad óptica [CITAR AKI (orszag)]. Es decir, la máxima inyección de fotones ocurre cuando el láser de bombeo y el modo de la cavidad están perfectamente sincronizados. Además, conforme aumenta la magntud de detuning, $abs(Delta) > 0$, la probabilidad de que un fotón ingrese a la cavidad cae de manera abrupta.

El análisis de este fenómeno se vuelve importante para el del sistema posterior, ya que la modificación de esta curva al introducir la presencia de átomos será una evidencia del acoplamiento luz-materia del régimen de electrodinámica cuántica de cavidades.