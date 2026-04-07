// ===================================================================
// 02_luz_materia.typ
// ===================================================================
#import "../style.typ": *


=== Interacción luz-materia <sec:luz_materia>


#let w = $omega$
#let rabi = $Omega$
#let detu = $Delta$
==== Átomo de dos niveles y la aproximación de onda rotante (RWA)


En el estudio de la interacción de la materia con la radiación, partimos del modelo más sencillo que consiste en un átomo de dos niveles con estado base $kg$ y un estado excitado $ke$, con energías $E_g$ y $E_n$, respectivamente #footnote[Desarrollo obtenido de @gerry_introductory_2005[$section 4.1$] y complementado con @fox_quantum_2006[$section 9.5$] y @orszag_quantum_2008[$section 2.2$].].

El Hamiltoniano del átomo libre se escribe como:

$ Ha = E_g sig(g,g) + E_e sig(e,e). $

Si fijamos el origen de energías en el estado base $E_g=0$, la diferencia de energía entre los niveles se define como $hbar weg = E_e - E_g$.

Consideramos ahora que el átomo interactúa con un campo electromagnético clásico de frecuencia $w$, dado por $vecb(E)(t) = vecb(E_0) cos (w t)$. Bajo la aproximación dipolar, donde asumimos de la longitud de onda de la radiación es mucho mayor que el tamaño del átomo, el término del potencial es:

$ vecop(V) (t) = -vecop(d) dot vecop(E) (t) = -hat(d) E_0 cos(w t) $

donde $hat(d)$ es el operador de momento dipolar eléctrico. Como los elementos de matriz diagonales del dipolo son nulos para estados de paridad definida ($braket(g, hat(d), g) = braket(e, hat(d), e) = 0$) y los antidiagonales tienen el mismo valor ($braket(g, hat(d), e) = braket(e, hat(d), g) = d$), el operador dipolo se reduce a $hat(d) = d (sig(g,e) + sig(e,g))$. Por lo tanto, el Hamiltoniano total del sistema es:

$
hat(H) &= Ha + Hla \
      &= hbar weg sig(e,e) - hbar rabi (sig(g,e) + sig(e,g))(e^(i w t) + e^(-i w t))
$

donde hemos definido la frecuencia de Rabi como $rabi = d E_0 \/ hbar$, que caracteriza la fuerza de acoplamiento entre el átomo y el campo.

Luego, para tiempos $t>0$ podemos expandir el vector de estado como $ket(psi (t)) = C_g (t) kg + C_e e^(-i weg t) ke)$, y al sustituir en la ecuación de Schrödinger, aparecen términos que oscilan con frecuencias $(w - weg)$ y $(w + weg)$. En el régimen de resonancia o cerca de ella ($w approx weg$), los términos que oscilan a $weg + w$ cambian tan rápido que su efecto se promedia a cero en las escalas de tiempo de la dinámica del átomo. Bajo la aproximación de onda rotante (RWA), omitimos estos términos de alta frecuencia, lo que resulta en un Hamiltoniano en el marco rotante dado por:

$ Hla &= -hbar/2 rabi mat(0, e^(i detu t); e^(-i detu t), 0) \
 &=-hbar/2 rabi (e^(i detu t) sig(g,e) + e^(-i detu t) sig(e,g)) $ <eq:ham_luzmateria>

donde $detu = w - weg$ es el _detuning_ o desintonía entre el campo y la transición atómica.

Además, la evolución de las amplitudes $C_g (t)$ y $C_e (t)$ están descritas por el sistema de ecuaciones diferenciales acopladas:

$
  i dot(C_g) = rabi/2 e^(- i detu t) C_e \
  i dot(C_e) = rabi/2 e^( i detu t) C_g
$

Asumiendo que el átomo inicia en el estado base ($C_g (0)=1$), la probabilidad de trancisión por absorción es:

$ abs(C_e (t))^2 = abs(rabir / rabi)^2 sin^2(rabi/2 t) $ <eq:rabi>

donde $rabir = sqrt(detu^2 + rabi^2)$ es la frecuencia de Rabi generalizada; esta ecuación muestra que la población del átomo oscila entre el estado base y el estado excitado a una frecuencia $rabi$.


==== Cuantización del campo: Modelo de Jaynes-Cummings


Ahora, en lugar de suponer al campo electromagnético como una onda clásica, para descibir la interacción en una cavidad se requiere tratar a la luz como un sistema cuántico. En este sistema, el campo atrapado en la cavidad se comporta matemáticamente como un oscilador armónico cuántico #footnote[Desarrollo obtenido de @gerry_introductory_2005[$section 4.5, section 4.3$] y complementado con @carmichael_statistical_2008[$section 9.2.4$] y @lambropoulos_fundamentals_2007[$section 3.4$].].

Si consideramos un único modo del campo electromagnético de frecuencia $w$ confinado en una cavidad de volumen V, el Hamiltoniano que describe la energía de este modo de radiación es:

$ Hc = hbar w (cre anh + 1/2) $

donde $cre$ y $anh$ son los operadores de creación y aniquilación, respectivamente, y satisfacen la relación de conmutación $[anh,cre]=1$; además, definimos el operador $NN=cre anh$ que representa el número de fotones en la cavidad. Bajo esta representación, el campo eléctrico dentro de la cavidad se expresa como:

$ hat(E) (z,t) = xi_0 (anh + cre) sin(k z) $

donde $xi_0 = sqrt(hbar w \/ epsilon_0 V)$ es la amplitud del campo por fotón. Con esta expresión se sustituye al coseno clásico y permite que el campo interactúe con el átomo a través del intercambio discreto de cuantos de energía.

Luego, para estudiar la interacción, acoplamos un átomo de dos niveles ($kg, ke$) con frecuencia de transición $weg$, al modo cuantizado de la cavidad. El Hamiltoniano total del sistema combinado es $hat(H) = Ha + Hc + Hca$, donde $Hca$ es el Hamiltoniano de interacción bajo aproximación dipolar $Hca = -vecop(d) dot vecop(E) (t)$.

Así, el término de interacción resulta en:

$
  Hca &= hbar g (sig(e,g) + sig(g,e))(anh + cre) \
  &=hbar g (sig(e,g) anh + sig(e,g) cre + sig(g,e) anh + sig(g,e) cre)
$

donde $g = -d xi_0 \/ hbar$ es la constante de acoplamiento átomo-cavidad y cuantifica la fuerza de la interacción entre un sólo átomo y un sólo fotón.

Al igual que en el caso semiclásico, aplicamos la aproximación de onda rotante para simplificar la dinámica. Sin embargo, en el contexto cuántico, la interpretación física de RWA está basada en la conservación de energía: los términos $sig(e,g) anh$ (absorción de fotón y excitación del átomo) y $sig(g,e) cre$ (emisión de fotón y desexcitación del átomo) conservan la energía del sistema, mientras que los términos $sig(e,g) cre$ y $sig(g,e) anh$ implican procesos donde el átomo se excita creando un fotón o se desexcita absorbiendo uno, los cuales oscilan a frecuencias muy altas y se desprecian.

Al eliminar los términos rápidos, obtenemos finalmente el Hamiltoniano de Jaynes-Cummings:

$ hat(H)_(J C) = hbar w cre anh + 1/2 hbar weg (sig(e,e) - sig(g,g)) + hbar g (cre sig(e,g) + anh sig(g,e)) $ <eq:ham_jaynescummings>

y describe el intercambio coherente de una sola excitación entre el átomo y la cavidad. El segundo término reprensenta el Hamiltoniano del átomo aislado, asumiendo que la energía cero se encuentra justo en medio. Sin embargo, como en este sistema la energía cero se encuentra en el estado base, el término se reescribe como $hbar weg sig(e,e)$.

===== Inyección externa de fotones

Finalmente, la cavidad debe ser alimentada por una fuente externa para poder llenarse de fotones, que no se encuentra incluida en el Hamiltoniano de Jaynes-Cummings. Esto se modela como un campo cásico que entra por uno de los espejos de la cavidad y, de acuerdo a la literatura de sistemas cuánticos abiertos, se introduce simulando un _drive_ o forzamiento externo sobre un oscilador cuántico, tal que $H_"drive" prop hat(x) E(t)$, donde $hat(x)$ es el operador de posición del oscilador.

Para la cavidad, el operador análogo a la posición es $hat(x) prop (anh + cre)$, añadiendo el término de interacción entre la cavidad y el bombeo con una intensidad de bombeo $eta_b$:

$ Hb = hbar eta_b (anh + cre) cos(w t). $

De la misma forma que con el átomo, es mejor situarnos en un marco de referencia que rota a la frecuencia del bombeo, y despreciando términos que oscilan rápido aplicando RWA, el Hamiltoniano queda como:

$ Hb = (i hbar)/2 eta_b (cre e^(-i(w-wp)t) - anh e^(i(w-wp)t)). $

La presencia de $i$ significa que el bombeo está a $90^degree$ fuera de fase con la cavidad, lo que hace posible la inyección de energía eficiente. Si asumimos que el marco de referencia rota justamente a la frecuencia de la cavidad ($wp - w$), los términos exponenciales desaparecen y podemos reescribir la expresión a simplemente:

$ Hb = i hbar rabip (cre - anh) $

donde se absobió el factor en $rabip = eta_b/2$. Además, veamos que este Hamiltoniano no conserva el número de fotones, pues describe un proceso externo que puede crearlos o destruirlos en la cavidad, por lo que representa totalmente un proceso cuántico abierto.


==== Átomo de tres niveles


En esta tesis, se estudia principalmente la participación de átomos en configuración cascada o _ladder_, que además se encuentran acoplados con la cavidad de un modo. Cuando este acoplamiendo es lo suficientemente fuerte o cuando la intensidad del campo que acopla la transición superior $ke <-> ks$ es lo suficientemente alta, el sistema ya no se puede describir en términos de niveles de energía _desnudos_, y el átomo y campo deben tratarse como un único sistema acoplado que se debe rediagonalizar, dando lugares a estados híbridos conocidos como _dressed states_. #footnote[Desarrollo obtenido de @cohentannoudji_atomphoton_2008[$section 6.4$], @gerry_introductory_2005[$section 4.6$] y @chiao_amazing_1996[$section 9$] para la parte *a*, y de @scully_quantum_2008[$section 7.2$, $section 7.3$] para la parte *b*.].

===== Dressed states y fenómeno de Autler-Townes <sec:dressed_states>

Consideremos un sistema con un campo de control intenso y en cuasi-resonancia con la transición superior $ke <-> ks$, con frecuencia $wc$ y desintonía $Dac = wc - weg approx 0$. En el límite de campo fuerte, la dinámica no se describe por el intercambio de fotones individuales, sino por la oscilación coherente de población entre niveles inducida por el campo del láser, parametrizada por $rabic$.

El Hamiltoniano puede escribirse como $hat(H) = Ha + Hc + hat(H)_(A C)$, donde $Ha$ es el Hamiltoniano del átomo libre, $Hc = hbar wc cre anh$ y $hat(H)_(A C)$ es la interacción dipoloeléctrica.

El modelo anterior (Jaynes-Cummings) describe la interacción de un átomo con un campo cuántido débil (pocos fotones). Aunque el campo es clásico, se puede modelar como un modo electromagnético muy poblado con $N$ fotones ($N -> infinity$), permitiendo diagonalizar el Hamiltoniano, y tal que $rabic(N) = 2 g sqrt(N+1)$ (frecuencia de Rabi de electrodinámica cuántica).

Cuando no hay interacción, $hat(H)_(A C)=0$, los eigenestados del sistema son los estados $ket(i N)$, que representan al átomo en el estado $i in {e,s}$ con $N$ fotones del láser de control. Cerca de la resonancia, los estados $ket(s N)$ y $ket(e [N+1])$ están casi degenerados y separados por una energía $hbar Dac$

Al introducir el acoplamiento $hat(H)_(A C)$, estos dos estados desnudos se acoplan fuertemente mediante el elemento de matriz:

$ braket(s N, hat(V)_(A C), e [N+1]) = (hbar rabic)/2, $

lo que levanta la cuasi-degeneración y fuerza a los niveles a repelerse energéticamente (fenómeno que se conoce como _anticrossing_). Al diagonalizar este subespacio bidimensional, se producen dos nuevos eigenestados perturbados que denotaremos como $ket(+)$ y $ket(-)$, y son superposiciones ortogonales de los estados desnudos originales:

$
  ket(N +) &= sin theta ket(s N) + cos theta ket(e [N+1]) \
  ket(N -) &= cos theta ket(s N) - sin theta ket(e [N+1])
$

donde la relación entre la fuerza de acomplamiento y la desintonía determina al ángulo de mezcla $theta = -rabic\/Dac$. A su vez, las energías de estos estados vestidos tienen una separación dadas por una frecuencia de Rabi efectiva:

$ delta E = hbar rabieff = hbar sqrt(rabic^2 + Dac^2) $

Veamos que en resonancia exacta $Dac=0$, se tiene $theta = pi/4$, por lo que los _dressed states_ son combinaciones simétricas y antisimétricas puras (50/50) de $ke$ y $ks$; y bajo esta condición, la separación de la energía alcanza el valor mínimo $hbar rabic$.

Finalmente, una de las consecuencias de la formación de _dressed states_, es que al sondear el átomo con un segundo láser débil desde el estado $kg$ al estadio intermedio $kg$, aparece un desdoblamiento de Autler-Townes.

Debido a que el láser de control ha modificado al estado desnudo $ke$, distribuyéndolo en los dos estados vestidos $ket(+)$ y $ket(-)$, la transición original $kg <->$ se divide. El láser de prueba ahora resuena con las dos transiciones permitidas: $ket(g [N+1]) -> ket(N +)$ y $ket(g [N+1]) -> ket(N -)$. En consecuencia, la línea de absorción se divide en dos picos (doblete) separadas por una frecuencia $rabieff$.

Si dejamos un poco de lado el láser de control por el momento, tenemos un modelo puramente cuántico que ocurre cuando el átomo se acopla al modo de la cavidad. En este caso, el acoplamiento no depende de un campo externo, sino de la interacción del momento dipolar atómico con el campo del punto cero de la cavidad (fluctuaciones del vacío), dada por la constante de acoplamiento, $g$.

Para el espacio de cero fotones, $N=0$, los estados desnudos $ket(e 0)$ y $ket(g 1)$ se mezclan para formar unos _dressed states_ particulares:

$ ket(0 +-) = 1/sqrt(2) (ket(g 1) +- ket(e 0)) $

cuya separación energética, en resonancia exacta, es independiente de cualquier intensidad de bombeo externa y está dada por:

$ delta E_"vac" = 2 hbar g $

===== Dark states

Por otro lado, mientras que el desdoblamiento Autler-Townes es consecuencia del desplazamiento de los niveles de energía bajo campos intensos, otro caso particular es la interacción del átomo de tres niveles con dos campos coherentes que provoca fenómenos como la existencia de _dark states_.

Considerando el sistema cascada ya descrito, en el caso de resonancia para ambas transiciones $Dpa=Dac=0$, el Hamiltoniano de interacción bajo RWA es:

$ hat(H)_I = -hbar/2 (rabip sig(e,g) + rabic sig(s,e) + rabip^* sig(g,e) + rabic^* sig(e,s)). $

Nos interesa saber si existe un estado estacionario del sistema, que denotaremos como $ket(D)$, y cuya energía de interacción sea estrictamente cero, es decir, $hat(H)_I ket(D)=0$.

Proponemos el estado $ket(D) = C_g kg + C_e ke + C_s ks$ y, aplicando el Hamiltoniano de interacción (por simplicidad, asumimos que las frecuencias de Rabi son reales), se obtiene un sistema de ecuaciones diferenciales acopladas para las amplitudes de probabilidad. En particular, la evolución temporal del estadio intermedio está dada por:

$ dot(C_e) = i/2 (rabip C_g + rabic C_s) $

donde existe una condición para la cual la amplitud de probabilidad del estadio intermedio se anula, tal que $dot(C_e)=0$, lo que implica que $rabip C_g + rabic C_s=0$. Esto define al eigenestado:

$ ket(D) = (rabic kg - rabip ks)/sqrt(rabip^2 + rabic^2). $

A este eigenestado se le conoce como _dark state_, y se caracteriza por no tener contribución del estado intermedio $ke$, por lo que el sistema se vuelve inmune al decaimiento espontáneo $dece$ y queda atrapado coherentemente entre los estados $kg$ y $ks$.