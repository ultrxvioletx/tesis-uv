// ===================================================================
// 02_luz_materia.typ
// ===================================================================
#import "../style.typ": *


En la presente tesis se tiene como objetivo simular y analizar la dinámica de un par de átomos confinados en una cavidad óptica, interactuando entre sí a través del modo que comparten con la cavidad y por las interacciones dipolares de Rydberg cuando están suficientemente cerca, mientras se encuentran bajo distintos campos láser. Para interpretar los fenómenos cooperativos que surgen de este sistema, es necesario establecer primero algunas ideas y conceptos teóricos de la óptica cuántica.

En este capítulo se aborda la interacción entre la materia y la radiación, partiendo del modelo semiclásico y procediendo con la cuantización del campo electromagnético. Luego, se estudia el formalismo de sistemas cuánticos abiertos, necesarios para modelar los procesos no-reversibles de disipación y pérdida de coherencia, inevitables en cualquier experimento de física. Finalmente, en @sec:bloqueo_rydberg se detalla sobre la física de los átomos de Rydberg y las interacciones de largo alcance, quienes conforman los ingredientes del bloqueo de excitación.


=== Interacción luz-materia <sec:luz_materia>


La descripción del modelo comienza por estudiar cómo un sistema atómico intercambia energía con un campo electromagnético. Esta interacción puede formularse tratando a la luz como una onda electromagnética clásica o con una descripción puramente cuántica. En esta sección se desarrollan ambos tipos de interacciones con el objetivo de plantear algunos de los Hamiltonianos usados, así como dejar ideas preliminares que nos permitan estudiar otros fenómenos e interacciones.


==== Átomo de dos niveles y la aproximación de onda rotante (RWA)


En el estudio de la interacción de la materia con la radiación, partimos del modelo más sencillo que consiste en un átomo de dos niveles con estado base $ke$ y un estado excitado $ks$, con energías $E_e$ y $E_s$, respectivamente #footnote[Desarrollo obtenido de @gerry_introductory_2005[$section 4.1$] y complementado con @fox_quantum_2006[$section 9.5$] y @orszag_quantum_2008[$section 2.2$].].

El Hamiltoniano del átomo libre se escribe como:

$ Ha = E_e sig(e,e) + E_s sig(s,s). $

donde la diferencia de energía entre los niveles se define como $hbar wse = E_s - E_e$.

Consideramos ahora que el átomo interactúa con un campo electromagnético clásico de frecuencia #footnote[La definimos con ese subíndice por motivos que se entenderán más adelante.] $wc$, dado por $vecb(E)(t) = vecb(E_0) cos (wc t)$. Bajo la aproximación dipolar, donde asumimos de la longitud de onda de la radiación es mucho mayor que el tamaño del átomo, el término del potencial es:

$ vecop(V) (t) = -vecop(d) dot vecop(E) (t) = -hat(d) E_0 cos(wc t) $

donde $hat(d)$ es el operador de momento dipolar eléctrico. Como los elementos de matriz diagonales del dipolo son nulos para estados de paridad definida ($braket(e, hat(d), e) = braket(s, hat(d), s) = 0$) y los antidiagonales tienen el mismo valor #footnote[Sin pérdida de generalidad, en esta tesis no afecta asumir que estos elementos de matriz son números reales, pues la elección de fase no influye en los estados estacionarios.] ($braket(e, hat(d), s) = braket(s, hat(d), e) = d$), el operador dipolo se reduce a $hat(d) = d (sig(e,s) + sig(s,e))$. Por lo tanto, el Hamiltoniano total del sistema es:

$
hat(H) &= Ha + Hla \
      &= hbar wse sig(s,s) - hbar rabic (sig(e,s) + sig(s,e))(e^(i wc t) + e^(-i wc t))
$

donde hemos definido la frecuencia de Rabi como $rabic = d E_0 \/ hbar$, que caracteriza la fuerza de acoplamiento entre el átomo y el campo.

Luego, para tiempos $t>0$ podemos expandir el vector de estado como $ket(psi (t)) = c_e (t) ke + c_s e^(-i wse t) ks$, y al sustituir en la ecuación de Schrödinger, aparecen términos que oscilan con frecuencias $(wc - wse)$ y $(wc + wse)$. En el régimen de resonancia o cerca de ella ($wc approx wse$), los términos que oscilan a $wse + wc$ cambian tan rápido que su efecto se promedia a cero en las escalas de tiempo de la dinámica del átomo. Al pasar al marco rotante, un sistema de referencia que gira a la frecuencia del campo, el Hamiltoniano adquiere términos estacionarios y términos oscilantes a $2 wc$. Bajo la aproximación de onda rotante (RWA), omitimos estos términos de alta frecuencia, lo que resulta en un Hamiltoniano dado por:

$ Hla &= -hbar/2 rabic mat(0, e^(i Dac t); e^(-i Dac t), 0) \
 &=-hbar/2 rabic (e^(i Dac t) sig(e,s) + e^(-i Dac t) sig(s,e)) $ <eq:ham_luzmateria>

donde $Dac = wc - wse$ es el _detuning_ o desintonía entre el campo y la transición atómica.

Además, la evolución de las amplitudes $c_e (t)$ y $c_s (t)$ están descritas por el sistema de ecuaciones diferenciales acopladas:

$
  i dot(c_e) = rabic/2 e^(- i Dac t) c_s \
  i dot(c_s) = rabic/2 e^( i Dac t) c_e
$

Asumiendo que el átomo inicia en el estado base ($c_e (0)=1$), la probabilidad de transición por absorción es:

$ abs(c_s (t))^2 = abs(rabir / rabic)^2 sin^2(rabic/2 t) $ <eq:rabi>

donde $rabir = sqrt(Dac^2 + rabic^2)$ es la frecuencia de Rabi generalizada; esta ecuación muestra que la población del átomo oscila entre el estado base y el estado excitado a una frecuencia $rabic$.


==== Modelo de Jaynes-Cummings <sec:jaynes_cummings>


Ahora, en lugar de suponer al campo electromagnético como una onda clásica, para descibir la interacción en una cavidad se requiere tratar a la luz como un sistema cuántico. El procedimiento formal para lograr esto es la cuantización canónica del campo electromagnético, y es un proceso matemático complejo que parte de las ecuaciones de Maxwell para conducir a la descripción de la luz en terminos de cuantos de energía @cohentannoudji_photons_2004.

Dado que el desarrollo de esta teoría no es el objetivo de la presente tesis, y el procedimiento está muy bien documentado en diversas bibliografías, se usará directamente el modelo resultante para un único modo de campo atrapado en una cavidad de volumen $V$. En este modelo #footnote[Desarrollo obtenido de @gerry_introductory_2005[$section 4.5, section 4.3$], @fox_quantum_2006[$section 10.4$] y complementado con @carmichael_statistical_2008[$section 9.2.4$], @lambropoulos_fundamentals_2007[$section 3.4$].], el campo se comporta matemáticamente como un oscilador armónico cuántico, cuyo Hamiltoniano que describe la energía del modo de radiación es:

$ Hc = hbar wp (cre anh + 1/2) $

donde $cre$ y $anh$ son los operadores de creación y aniquilación, respectivamente, y satisfacen la relación de conmutación $[anh,cre]=1$; además, definimos el operador $NN=cre anh$ que representa el número de fotones en la cavidad. Bajo esta representación, el campo eléctrico dentro de la cavidad se expresa como:

$ hat(E) (z,t) = xi_0 (anh + cre) sin(k z) $

donde a $xi_0 = sqrt(hbar wp \/ epsilon_0 V)$ se le conoce como la amplitud del campo por fotón. Con esta expresión se sustituye al coseno clásico y permite que el campo interactúe con el átomo a través del intercambio discreto de cuantos de energía.

Luego, para estudiar la interacción, acoplamos un átomo de dos niveles ($kg, ke$) con frecuencia de transición $weg$ al modo cuantizado de la cavidad, dando lugar al modelo de Jaynes-Cummings. El Hamiltoniano total del sistema combinado es $hat(H) = Ha + Hc + Hca$, donde $Hca$ es el Hamiltoniano de interacción bajo aproximación dipolar $Hca = -vecop(d) dot vecop(E) (t)$.

Así, el término de interacción resulta en:

$
  Hca &= hbar g (sig(e,g) + sig(g,e))(anh + cre) \
  &=hbar g (sig(e,g) anh + sig(e,g) cre + sig(g,e) anh + sig(g,e) cre)
$

donde $g = -d xi_0 \/ hbar$ es la constante de acoplamiento átomo-cavidad y cuantifica la fuerza de la interacción entre un sólo átomo y un sólo fotón.

Al igual que en el caso semiclásico, aplicamos la aproximación de onda rotante (RWA) para simplificar la dinámica. Esta aproximación es más evidente cuando se transforma al Hamiltoniano de interacción al esquema de interacción (_interaction picture_) respecto al Hamiltoniano libre $H_0$. En este esquema, los operadores tienen una dependencia temporal explícita dada por las frecuencias del sistema: $anh (t) = anh e^(-i wp t)$ y $sig(g,e)(t) = sig(g,e) e^(-i weg t)$.


De esta forma, el Hamiltoniano de interacción se divide en dos tipos de términos. Por un lado, los términos $sig(e,g) anh$ (absorción de fotón y excitación del átomo) y $sig(g,e) cre$ (emisión de fotón y desexcitación del átomo) oscilan a la frecuencia de desintonía $Dpa = wp - weg$. Mientras que por el otro, los términos $sig(e,g) cre$ y $sig(g,e) anh$ oscilan a frecuencias muy altas, proporcionales a $wp + weg$.

Al eliminar los términos rápidos, que no contribuyen significativamente a la dinámica, obtenemos finalmente el Hamiltoniano de Jaynes-Cummings:

$ hat(H)_(J C) = hbar wp cre anh + 1/2 hbar weg (sig(e,e) - sig(g,g)) + hbar g (cre sig(e,g) + anh sig(g,e)) $ <eq:ham_jaynescummings>

y describe el intercambio coherente de una sola excitación entre el átomo y la cavidad.

===== Inyección externa de fotones

Finalmente, la cavidad debe ser alimentada por una fuente externa para poder llenarse de fotones, que no se encuentra incluida en el Hamiltoniano de Jaynes-Cummings. Esto se modela como un campo cásico que entra por uno de los espejos de la cavidad y, de acuerdo a la literatura de sistemas cuánticos abiertos, se introduce simulando un _drive_ o forzamiento externo sobre un oscilador cuántico, tal que $H_"drive" prop hat(x) E(t)$, donde $hat(x)$ es el operador de posición del oscilador.

Para la cavidad, el operador análogo a la posición es $hat(x) prop (anh + cre)$, añadiendo el término de interacción entre la cavidad y el bombeo con una intensidad de bombeo $eta_b$:

$ Hb = hbar eta_b (anh + cre) cos(wp t). $

De la misma forma que con el átomo, es mejor situarnos en un marco de referencia que rota a la frecuencia del bombeo, y despreciando términos que oscilan rápido aplicando RWA, el Hamiltoniano queda como:

$ Hb = (i hbar)/2 eta_b (cre e^(-i(w-wp)t) - anh e^(i(w-wp)t)). $

La presencia de $i$ significa que el bombeo está a $90^degree$ fuera de fase con la cavidad y, aunque la elección de esta fase no es relevante para la inyección de energía total en el sistema en el estado estacionario, se mantiene de esta forma para ser consistente con la literatura. Si asumimos que el marco de referencia rota justamente a la frecuencia de la cavidad ($wp - w$), los términos exponenciales desaparecen y podemos reescribir la expresión a simplemente:

$ Hb = i hbar rabip (cre - anh) $

donde se absobió el factor en $rabip = eta_b/2$. Además, veamos que este Hamiltoniano no conserva el número de fotones, pues describe un proceso externo que puede crearlos o destruirlos en la cavidad, por lo que representa un proceso cuántico abierto.


==== Átomo de tres niveles


En esta tesis, se estudia principalmente la participación de átomos en configuración cascada (_ladder_), que además se encuentran acoplados con la cavidad de un modo. Cuando este acoplamiendo es lo suficientemente fuerte o cuando la intensidad del campo que acopla la transición superior $ke <-> ks$ es lo suficientemente alta, ya no es conveniente describir el sistema en términos de niveles de energía _desnudos_, y el átomo y campo deben tratarse como un único sistema acoplado que se debe rediagonalizar, dando lugares a estados híbridos conocidos como estados vestidos (_dressed states_). #footnote[Desarrollo obtenido de @cohentannoudji_atomphoton_2008[$section 6.4$], @gerry_introductory_2005[$section 4.6$] y @chiao_amazing_1996[$section 9$] para la parte *a*, y de @scully_quantum_2008[$section 7.2$, $section 7.3$] para la parte *b*.].

===== Dressed states y fenómeno de Autler-Townes <sec:dressed_states>

Consideremos un sistema con un campo de control intenso y en cuasi-resonancia con la transición superior $ke <-> ks$, con frecuencia $wc$ y desintonía $Delta = wc - wse approx 0$. En el límite de campo fuerte, no conviene describir la dinámica por el intercambio de fotones individuales, sino por la oscilación coherente de población entre niveles inducida por el campo del láser, parametrizada por $rabic$.

El Hamiltoniano puede escribirse como $hat(H) = Ha + Hc + hat(H)_(A C)$, donde $Ha$ es el Hamiltoniano del átomo libre, $Hc = hbar wp cre anh$ y $hat(H)_(A C)$ es la interacción dipoloeléctrica.

El modelo de Jaynes-Cummings describe la interacción de un átomo con un campo cuántico; aunque el campo es clásico, se puede aproximar como un modo electromagnético muy poblado con $N$ fotones ($N -> infinity$), permitiendo diagonalizar el Hamiltoniano, y tal que:

$ rabic(N) = 2 g sqrt(N+1) $ <eq:rabi_g>

que es la frecuencia de Rabi de electrodinámica cuántica.

Para describir el sistema cerrado dado por el átomo fuertemente acoplado al láser de control, el enfoque más sencillo es encontrar las soluciones del Hamiltoniano total. Cuando no hay interacción ($hat(H)_(A C)=0$), los eigenestados del sistema son los estados desnudos $ket(i N)$, donde el átomo se encuentra en el estado $i in {e,s}$ y el campo de control contiene $N$ fotones. Cerca de la resonancia, los estados $ket(s N)$ y $ket(e [N+1])$ están casi degenerados y separados únicamente por la energía de desintonía $hbar Dac$.

Al introducir el término de interacción ($hat(H)_(A C) != 0$), esta cuasi-degeneración se levanta y la solución del sistema son los denominados estados vestidos. Al diagonalizar este subespacio, acoplado por los elementos de matriz:

$ braket(s N, hat(V)_(A C), e [N+1]) = (hbar rabic)/2, $

las frecuencias de resonancia del sistema cambian y se multiplican. Los nuevos eigenestados resultan ser superposiciones ortogonales de los estados desnudos originales:

$
  ket(N +) &= sin theta ket(s N) + cos theta ket(e [N+1]) \
  ket(N -) &= cos theta ket(s N) - sin theta ket(e [N+1])
$

donde la relación entre la fuerza de acomplamiento y la desintonía determina al ángulo de mezcla $theta = 1/2 arctan(-rabic\/Dac)$. A su vez, las energías de estos estados vestidos se repelen mutuamente (fenómeno de _anticrossing_), adquiriendo una separación dada por una frecuencia de Rabi efectiva:

$ delta E = hbar rabieff = hbar sqrt(rabic^2 + Dac^2) $ <eq:delta_energias>

Veamos que en resonancia exacta $Dac=0$, se tiene $theta = pi/4$, por lo que los estados vestidos son combinaciones simétricas y antisimétricas puras (50/50) de $ke$ y $ks$, y su separación energética alcanza su valor mínimo $hbar rabic$.

La ventaja de utilizar esta base de estados vestidos, es que proporciona una descripción física más sutil de la dinámica del sistema. Por ejemplo, permite explicar la aparición del desdoblamiento de Autler-Townes cuando se sondea al átomo desde el estado base $kg$ con un láser de prueba débil.

Debido a que el láser de control ha modificado al estado desnudo $ke$, distribuyéndolo en los dos estados vestidos $ket(+)$ y $ket(-)$, la transición original $kg <-> ke$ se divide. El láser de prueba ahora resuena con las dos transiciones permitidas: $ket(g [N+1]) -> ket(N +)$ y $ket(g [N+1]) -> ket(N -)$. En consecuencia, la línea de absorción se divide en dos picos (doblete) separadas por una frecuencia $rabieff$.

Si dejamos un poco de lado el láser de control por el momento, tenemos un modelo puramente cuántico que ocurre cuando el átomo se acopla al modo de la cavidad. En este caso, el acoplamiento no depende de un campo externo, sino de la interacción del momento dipolar atómico con el campo del punto cero de la cavidad (fluctuaciones del vacío), dada por la constante de acoplamiento, $g$.

Para el espacio de cero fotones, $N=0$, los estados desnudos $ket(e 0)$ y $ket(g 1)$ se mezclan para formar unos estados vestidos particulares:

$ ket(0 +-) = 1/sqrt(2) (ket(g 1) +- ket(e 0)) $

cuya separación energética, en resonancia exacta, es independiente de cualquier intensidad de bombeo externa y está dada por:

$ delta E_"vac" = 2 hbar g $

===== Dark states

Por otro lado, mientras que el desdoblamiento Autler-Townes es consecuencia del desplazamiento de los niveles de energía bajo campos intensos, otro caso particular es la interacción del átomo de tres niveles con dos campos coherentes que provoca fenómenos como la existencia de estados oscuros (_dark states_).

Considerando el sistema cascada $kg <-> ke <-> ks$, en el caso de resonancia para ambas transiciones $Delta_1=Delta_2=0$, el Hamiltoniano de interacción bajo RWA es:

$ hat(H)_I = -hbar/2 (rabip sig(e,g) + rabic sig(s,e) + rabip^* sig(g,e) + rabic^* sig(e,s)). $

Nos interesa saber si existe un estado estacionario del sistema, que denotaremos como $ket(D)$, y cuya energía de interacción sea estrictamente cero, es decir, $hat(H)_I ket(D)=0$.

Proponemos el estado $ket(D) = c_g kg + c_e ke + c_s ks$ y, aplicando el Hamiltoniano de interacción (por simplicidad, asumimos que las frecuencias de Rabi son reales), se obtiene un sistema de ecuaciones diferenciales acopladas para las amplitudes de probabilidad. En particular, la evolución temporal del estado intermedio está dada por:

$ dot(c_e) = i/2 (rabip c_g + rabic c_s) $

donde existe una condición para la cual la amplitud de probabilidad del estado intermedio se anula, tal que $dot(c_e)=0$, lo que implica que $rabip c_g + rabic c_s=0$. Esto define al eigenestado:

$ ket(D) = (rabic kg - rabip ks)/sqrt(rabip^2 + rabic^2). $

que se le conoce como estado oscuro, y se caracteriza por no tener contribución del estado intermedio $ke$, por lo que el sistema se vuelve inmune al decaimiento espontáneo $dece$ y queda atrapado coherentemente entre los estados $kg$ y $ks$.