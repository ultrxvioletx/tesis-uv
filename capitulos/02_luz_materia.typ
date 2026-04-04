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

Luego, para estudiar la interacción, acoplamos un átomo de dos niveles ($kg, ke$), al modo cuantizado de la cavidad. El Hamiltoniano total del sistema combinado es $hat(H) = Ha + Hc + Hca$, donde $Hca$ es el Hamiltoniano de interacción bajo aproximación dipolar $Hca = -vecop(d) dot vecop(E) (t)$.

Así, el término de interacción resulta en:

$
  Hca &= hbar g (sig(e,g) + sig(g,e))(anh + cre) \
  &=hbar g (sig(e,g) anh + sig(e,g) cre + sig(g,e) anh + sig(g,e) cre)
$

donde $g = -d xi_0 \/ hbar$ es la constante de acoplamiento átomo-cavidad y cuantifica la fuerza de la interacción entre un sólo átomo y un sólo fotón.

Al igual que en el caso semiclásico, aplicamos la aproximación de onda rotante para simplificar la dinámica. Sin embargo, en el contexto cuántico, la interpretación física de RWA está basada en la conservación de energía: los términos $sig(e,g) anh$ (absorción de fotón y excitación del átomo) y $sig(g,e) cre$ (emisión de fotón y desexcitación del átomo) conservan la energía del sistema, mientras que los términos $sig(e,g) cre$ y $sig(g,e) anh$ implican procesos donde el átomo se excita creando un fotón o se desexcita absorbiendo uno, los cuales oscilan a frecuencias muy altas y se desprecian.

Al eliminar los términos rápidos, obtenemos finalmente el Hamiltoniano de Jaynes-Cummings:

$ hat(H)_(J C) = hbar w cre anh + 1/2 hbar weg (sig(e,e) - sig(g,g)) + hbar g (cre sig(e,g) + anh sig(g,e)) $ <eq:ham_jaynescummings>

y describe el intercambio coherente de una sola excitación entre el átomo y la cavidad. El segundo término reprensenta el Hamiltoniano del átomo aislado, asumiendo que la energía cero se encuentra justo en medio. Sin embargo, como en este sistema la energía cero se encuentra en el estado base, el término se reescribe como $hbar weg$.

===== Inyección externa de fotones

Finalmente, la cavidad debe ser alimentada por una fuente externa para poder llenarse de fotones, que no se encuentra incluida en el Hamiltoniano de Jaynes-Cummings. Esto se modela como un campo cásico que entra por uno de los espejos de la cavidad y, de acuerdo a la literatura de sistemas cuánticos abiertos, se introduce simulando un _drive_ o forzamiento externo sobre un oscilador cuántico, tal que $H_"drive" prop hat(x) E(t)$, donde $hat(x)$ es el operador de posición del oscilador.

Para la cavidad, el operador análogo a la posición es $hat(x) prop (anh + cre)$, añadiendo el término de interacción entre la cavidad y el bombeo con una intensidad de bombeo $eta_b$:

$ Hb = hbar eta_b (anh + cre) cos(w t). $

De la misma forma que con el átomo, es mejor situarnos en un marco de referencia que rota a la frecuencia del bombeo, y despreciando términos que oscilan rápido aplicando RWA, el Hamiltoniano queda como:

$ Hb = (i hbar)/2 eta_b (cre e^(-i(w-wp)t) - anh e^(i(w-wp)t)). $

La presencia de $i$ significa que el bombeo está a $90^degree$ fuera de fase con la cavidad, lo que hace posible la inyección de energía eficiente. Si asumimos que el marco de referencia rota justamente a la frecuencia de la cavidad ($wp - w$), los términos exponenciales desaparecen y podemos reescribir la expresión a simplemente:

$ Hb = i hbar rabip (cre - anh) $

donde se absobió el factor en $rabip = eta_b/2$. Además, veamos que este Hamiltoniano no conserva el número de fotones, pues describe un proceso externo que puede crearlos o destruirlos en la cavidad, por lo que representa totalmente un proceso cuántico abierto.