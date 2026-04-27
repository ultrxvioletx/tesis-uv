// ===================================================================
// 05_elim_adiabatica.typ
// ===================================================================
#import "../style.typ": *


==== Eliminación adiabática del estado intermedio <sec:elim_adiabatica>


En los apartados anteriores, se estudiaron regímenes donde el campo de prueba se encontraba en cuasi-resonancia con el estado intermedio $ke$. Sin embargo, como se menciona en la introducción de esta sección, el rápido decaimiento asociado el nivel intermedio destruye la coherencia del sistema antes de que las interacciones interatómicas de Rydberg puedan presentarse (las cuales son de especial interés en esta tesis).

Además, inducir EIT no es viable debido a que se necesita estar en resonancia perfecta en la transición simultánea de dos fotones entre $kg <-> ks$ para que funcione. Si por alguna razón $ks$ se mueve un poquito, la interferencia se rompe, el electrón cae en $ke$ y el átomo decae.

Por ello, se implementa la técnica de desintonía muy grande (_large detuning_) para suprimir esta decoherencia, y se usa la eliminación adiabática #footnote[Las ideas, conceptos y fórmulas relacionados con esta sección fueron sacadas de @lambropoulos_fundamentals_2007[$section 3.6$, $section 10.2.2$], @gerry_introductory_2005[$section 4.8$], @scully_quantum_2008[$section 5.5.2$, $section 10.2.2$], @loudon_quantum_2010[$section 2.7$].] para hacer la descripción de manera sencilla.

El esquema físico, mostrado en la @fig:1at4lvl_sistema, se configura tal que ambos láseres se encuentren fuertemente desintonizados del nivel intermedio $ke$ por una cantidad $Delta$, pero manteniendo la resonancia de dos fotones de la transición $kg <-> ks$ discutida en la sección anterior (i.e., $Delta = Dpa = -Dac$). Cuando la desintonía es mucho mayor que cualquier otra escala del sistema ($Delta >> g, rabic, kappa, dece$), el nivel intermedio $ke$ se vuelve un estado virtual y su función es solamente mediar la transición, por lo que su población real es despreciable. Esto permite reducir el sistema de tres niveles a un sistema efectivo de dos niveles que acopla los estados $kg$ y $ks$.

#{
  let hg = 3
  let he = 2.5
  let hev = 1.4
  let hs = 0
  let d = 0.6
  figure(diagrama(
    cell-size: 1mm,
    mark-scale: 130%,
    
    edge((0,hs),(2.5,hs),),
    node((2.5,hs), $ks$),
    edge((0,he),(2.5,he),),
    node((2.5,he), $ke$),
    edge((0,hev),(2.5,hev),"--"),
    node((2.7,hev), $ke_"virt"$),
    edge((0,hg),(2.5,hg),),
    node((2.5,hg), $kg$),
    // láseres
    edge((1.5,hg),(1.5,hev), "<->", $wp$, label-side: left, "wave"),
    edge((1.7,hev),(1.7,hs), "<->", $wc$, label-side: left, "wave"),
    // deltas
    edge((-0.5,he),(-0.5,hev), "<->", $Delta$, label-side: left),
  ),
  caption: [Diagrama de la interacción de un átomo de tres niveles fuertemente desintonizado por $Delta$.]
)} <fig:1at4lvl_sistema>

Como el sistema se encuentra fuertemente desintonizado, el átomo oscila entre los estados de los extremos con una frecuencia de Rabi efectiva de dos fotones dada por:

$ rabieff approx (rabip rabic)/(2 Delta), $ <eq:rabi_eff>

y decaimiento efectivo del nivel $ks$ dado por $decs approx dece (rabic/(2 Delta))^2$.

Por otro lado, cuando el átomo es acoplado a una cavidad en régimen de acoplamiento fuerte, el sistema se reduce a un modelo de Jaynes-Cummings efectivo con una frecuencia de acoplamiento dada por:

$ geff approx (g rabic)/(2 Delta). $ <eq:geff>

Ahora que las magnitudes del sistema efectivo están reajustadas, la intensidad del campo clásico $rabic$ y del acoplamiento $g$ tienen que aumentar considerablemente para poder compensar la disminución ocasionada por $Delta$.

===== AC Stark Shift y Vacuum Stark Shift <sec:stark>

#{
  let hg = 3
  let he = 2.5
  let hev = 1.4
  let hs = 0
  let dS = 0.3
  figure(diagrama(
    cell-size: 1mm,
    mark-scale: 130%,

    // niveles sin corrimiento
    edge((0,hs),(2.5,hs),),
    node((2.5,hs), $ks$),
    edge((0,he),(2.5,he),),
    node((2.5,he), $ke$),
    edge((0,hev),(2.5,hev), "--"),
    node((2.7,hev), $ke_"virt"$),
    edge((0,hg),(2.5,hg),),
    node((2.5,hg), $kg$),
    // niveles con corrimiento
    edge((0,hs -dS),(2,hs -dS), "--"),
    edge((0,hg+dS),(2,hg+dS), "--"),
    // flechas de corrimiento
    edge((0.1,hg),(0.1,hg+dS), "->", label-side: left, text(size:8pt)[$-S_g$]),
    edge((0.1,0),(0.1,hs -dS), "->", label-side: right, text(size:8pt)[$S_s$]),
    // láseres
    edge((1.5,hg),(1.5,hev), "<->", $wp$, label-side: left, "wave"),
    edge((1.7,hev),(1.7,hs), "<->", $wc$, label-side: left, "wave"),
    // deltas
    edge((-0.5,he),(-0.5,hev), "<->", $Delta$, label-side: left),
  ),
  caption: [Diagrama de corrimiento de niveles de energía ocasionados por campos fuertes.]
)}

El costo de esta compensación en la eliminación adiabática, es que la interacción con estos campos muy intensos provoca que el sistema sufra una perturbación adicional en los niveles de energía del átomo, que se conoce como _AC Stark Shift_.

En el régimen de gran desintonía, la magnitud del desplazamiento energético del nivel $ket(i)$ acoplado al nivel $ket(j)$ por un campo con frecuencia de Rabi $Omega_(i j)$ y con desintonía $Delta_(i j)$ puede aproximarse por la teoría de perturbaciones de segundo orden como $S_i approx (hbar Omega^2_(i j))/(4 Delta_(i j))$.

En nuestro sistema, el corrimiento particularmente relevante es el del estado de Rydberg $ks$. El láser de control acopla los niveles $ke$ y $ks$ con una desintonía $Dac<0$, por lo que la energía del láser es menor que la energía de la transición. Como la desintonía es negativa, empuja al nivel $ks$ hacia arriba, provocando un desplazamiento de

$ ss = rabic^2/(4 Dac) >0. $ <eq:shifts>

Por otro lado, en la configuración de la cavidad, el papel que juega el láser de prueba clásico ($rabip$) es reemplazado por el modo electromagnético cuantizado. Como consecuencia, el corrimiento en el estado $g$ ya no es provocado por un láser externo, sino por la interacción luz-materia con la cavidad. La expresión para este corrimiento tiene la forma $sg approx (g^2 (n+1))/Dpa$, donde $n$ es el número de fotones en la cavidad.

Notemos que incluso en el vacío ($n=0$), el nivel $kg$ presenta un desplazamiento no nulo ocasionado por la interacción con el campo del punto cero de la cavidad, lo que se conoce como _Vacuum Stark shift_.

Como $Dpa>0$, la energía del láser es mayor que la energía de la transición entre $kg$ y $ke$, por lo que el láser está por arriba y empuja al nivel hacia abajo. Entonces, se genera un desplazamiento permanente del estado base de:

$ sg = - g^2/Dpa <0. $ <eq:shiftg>

La consecuencia de estos corrimientos es la pérdida de resonancia de la transición de dos fotones $kg <-> ks$ @anton_spontaneously_2005. Por ello, para que la transición de dos fotones sea eficiente, se tiene que aplicar una compensación ajustando las frecuencias de los láseres. La condición de resonancia ya no ocurre cuando $Dpa+Dac=0$, sino cuando:

$ Dpa + Dac = ss + sg $

por tanto, las desintonías se reajustan a:

$
Dpa &= Delta + sg \
Dac &= - Delta + ss.
$

===== Átomo aislado con dos campos clásicos en el espacio libre

El primer paso para observar numéricamente cómo un átomo de tres niveles se puede reducir efectivamente a uno de dos, consiste en analizar la dinámica de un solo un átomo aislado ($HH = HHa$). En esta configuración, el sistema es afectado por dos campos clásicos en el espacio libre: un láser de prueba débil que acopla la transición inferior $kg <-> ke$ con intensidad $rabip$, y un láser de control fuerte que acopla la transición superior $ke <-> ks$ con intensidad $rabic$. Bajo aproximación de onda rotante, el Hamiltoniano de interacción semiclásico para este sistema es:

$ Hi = -hbar/2 {rabip (sig(g,e) + sig(e,g)) + rabic (sig(e,s) + sig(s,e))} $

y la ecuación maestra de Lindblad con términos de decaimiento para el nivel intermedio $ke$ y el estado de Rydberg $ks$:

$ dot(rr) = -i/hbar [Ha + Hi, rr] + dece/2 LL[sig(g,e)] + decs/2 LL[sig(e,s)]. $

#figure(
  image("../assets/figuras/1at4lvl.png"),
  caption: [Evolución temporal de las poblaciones atómicas en el régimen de eliminación adiabática. Se observa que la población del estado intermedio $Pe$ (cuadrados) permanece en cero a lo largo de la evolución, mientras que el átomo muestra oscilaciones de Rabi entre el estado base $kg$ y el estado de Rydberg $ks$ (triángulos), comportándose como un sistema de dos niveles efectivo. Los parámetros utilizados son: $rabip = 0.5 kappa$, $rabic = 20.0 kappa$, $Delta = 100.0 kappa$, $dece = 0.0 kappa$, $decs = 0.0 kappa$.]
) <fig:1at4lvl>

Se simuló la evolución temporal partiendo del estado base $rr(t_(=0)) = ketbra(0,0)$ y aplicando las compensaciones de desintonía $Dpa$ y $Dac$ discutidas anteriormente para garantizar la resonancia de dos fotones.

En la @fig:1at4lvl se observa que, a lo largo de la evolución temporal, la población del estado intermedio $Pe$ permanece prácticamente nula, lo que confirma que el electrón salta al nivel superior sin poblar físicamente el estado $ke$, por lo que el sistema queda protegido ante la tasa de decaimiento $dece$.

De igual forma, vemos que se muestran oscilaciones de Rabi asociadas al nivel de Rydberg $ks$. La población $Ps$ oscila de forma periódica entre $0$ y $sim 1$, lo que confirma la existencia del sistema efectivo de dos niveles con probabilidad de excitación $Ps (t) = sin^2(rabieff/2 t)$. Para los parámetros dados, la frecuencia de Rabi efectiva es $rabieff approx 0.05 kappa$, lo que corresponde a un periodo de oscilación de $T = (2 pi)/rabieff approx 125.6 kappa^(-1)$.

===== Átomo acoplado a la cavidad óptica

Ya que hemos aplicado la eliminación adiabática en el átomo aislado, ahora se introduce el modo de la cavidad ($HHa ** Hc$). En esta configuración, la cavidad bombeada reemplaza al láser de prueba clásico, acoplando la transición inferior $kg <-> ke$ con un acoplamiento de Jaynes-Cummings $g$, y es alimentado por el láser de prueba externo de intensidad $rabip$. El láser intenso de control que acopla $ke <-> ks$ se mantiene sin cambios. Por lo tanto, el Hamiltoniano total y la ecuación maestra de Lindblad para este sistema son los mismos que los usados en @eq:1at3lvl_hamtotal y @eq:1at3lvl_maestra, respectivamente, pero con los términos de interacción y disipación correspondientes a esta nueva configuración.

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
  caption: [*(a)* Número medio de fotones en el estado estacionario *(b)* Probabilidad de excitación atómica del nivel intermedio $Pe$ (cuadrados) y el nivel de Rydberg $Ps$ (triángulos), para el sistema átomo-cavidad bajo eliminación adiabática, en función de la variación $scan$ de la desintonía alrededor de $Dpa = 100$. Se exhibe un desdoblamiento asimétrico de los estados luz-materia. Los parámetros utilizados son: $rabip = 0.5 kappa$, $rabic = 20.0 kappa$, $g = 15.0 kappa$, $kappa = 1.0$, $dece = 1.0 kappa$, $decs = 0.0 kappa$, $nmax = 3$.]
) <fig:1at4lvl_cavidad>

Debido a que el nivel $ke$ no tiene población en ningún momento de la evolución, la interacción efectiva ya no ocurre entre el átomo de dos niveles aislado y el modo de la cavidad, sino que ahora el modo de la cavidad interactúa con la transición de dos fotones $kg <-> ks$. Para los parámetros usados, el acoplamiento de la @eq:geff tiene un valor de $geff approx 1.5 kappa$, lo que coloca al sistema en el régimen de acoplamiento fuerte cooperativo ($geff > kappa$). Para estudiar este sistema, se simuló el espectro de la cavidad realizando un barrido de $scan$ alrededor de la desintonía $Delta=100 kappa^(-1)$.

Como se observa en @fig:1at4lvl_cavidad, la población del estado intermedio $Pe$ (curva rosa) permanece nula a lo largo del barrido, lo que confirma que, incluso en el régimen de acoplamiento fuerte con la cavidad, el sistema de 3 niveles continúa comportándose efectivamente como uno de 2 niveles.

Luego, se muestra un desdoblamiento en dos picos de resonancia, causados por el acoplamiento entre la cavidad y el átomo, y explicados con ayuda de los estados vestidos $ket(0 +-)$ del _Vacuum Rabi splitting_. Sin embargo, a comparación del desdoblamiento observado en la @fig:1at3lvl_sinrabi, estos picos se encuentran desplazados rígidamente hacia la derecha del origen y con una evidente asimetría en sus amplitudes.

La asimetría es causada por los corrimientos Stark clásicos y cuánticos introducidos en @sec:stark. Por un lado el láser de control desplaza al estado de Rydberg una cantidad de $ss = rabic^2/(4 Delta) = 1.0 kappa$ y, por otro lado, las fluctuaciones del vacío en la cavidad desplazan al estado base por $sg = g^2/Delta = 2.25 kappa$.

Como la cavidad y el átomo tienen corrimientos de magnitudes distintas, $ss != sg$, los subsistemas quedan desintonizados por una distancia $Delta S = sg - ss = 1.25 kappa$ (ocasionando la asimetría en la amplitud de los picos) y, en consecuencia, se rompe la degeneración de los estados vestidos híbridos @kolaric_strong_2018 @kavokin_microcavities_2007[$section 5.3.2$]. Por lo tanto, los nuevos estados dejan de ser mezclas mitad luz mitad materia, y se desequilibran de la siguiente forma:

- Tipo átomo: El pico izquierdo, $scan\/kappa approx -0.4$, se encuentra más cercano a la resonancia del átomo desplazado, por lo que tiene un mayor carácter de excitación material, y se refleja en una mayor probabilidad de encontrar al átomo en el estado $ks$ con un menor número de fotones en la cavidad.

- Tipo luz: De forma inversa, el pico derecho en $scan\/kappa approx 2.5$ está más cerca de la resonancia que posee la cavidad intrínsecamente, por lo que tiene un mayor carácter fotónico y se refleja maximizando la transmisión dentro de la cavidad, mientras que el nivel de excitación del átomo decrece.

La diferencia de las nuevas energías con las que resuena el sistema (separación de los picos) ahora que se comporta como un sistema efectivo de dos niveles, se calcula usando la @eq:delta_energias. Donde la frecuencia de Rabi del campo clásico se reemplaza por el acoplamiento del campo del vacío (usando @eq:rabi_g para cero fotones), $2 geff$, y la desintónia de láser se reemplaza por la desintonía efectiva entre el átomo y la cavidad, $Deff = ss - sg$.

Así, tenemos que:

$ d1 = delta E &= sqrt((2geff)^2 + (ss - sg)^2) \
    &= sqrt(4 geff^2 + (ss - sg)^2) approx 3.25 kappa $

Finalmente, la asimetría de los _shifts_ provoca que la transición efectiva de dos fotones entre los estados desnudos $ket(g 1)$ y $ket(s 0)$ ya no ocurra a la frecuencia natural del átomo, y el sistema ahora se rige por una renormalización del Hamiltoniano no perturbado, cuya energía central ha sido desplazada.