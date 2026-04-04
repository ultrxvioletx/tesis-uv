// ===================================================================
// 02_atomo3lvl.typ
// ===================================================================
#import "../style.typ": *


==== Átomo de tres niveles


En esta tesis, se estudia principalmente la participación de átomos de tres niveles en configuración cascada o _ladder_. Cuando la intensidad del campo que acopla la transición superior $ke <-> ks$ (con frecuencia de Rabi $rabic$ y desintonía $Dac$) es lo suficientemente alta, el sistema ya no se puede describir en términos de niveles de energía _desnudos_, y el átomo y campo deben tratarse como un único sistema acoplado #footnote[Desarrollo obtenido de @cohentannoudji_atomphoton_2008[$section 6.4$] y @chiao_amazing_1996[$section 9$] para la parte *a*, y de @scully_quantum_2008[$section 7.2$, $section 7.3$] para la parte *b*.].

===== Dressed states y fenómeno de Autler-Townes

En este sistema acoplado se considera al átomo-campo como una única cantidad. En lugar de ver al átomo como un solo sistema que absorbe y emite fotones, se diagonaliza el Hamiltoniano del sistema átomo-láser (@eq:ham_luzmateria) para encontrar sus eigenestados y eigenvalores. Estos nuevos eigenestados representan una mezcla de los estados atómicos y estados del campo y son llamados _dressed states_.

Supongamos un sistema con un campo de control intenso y en cuasi-resonancia con la transición $ke <-> ks$, con frecuencia $wc$ e intensidad $rabic$; y un láser débil de prueba con frecuencia $wp$ que sondea la transición inferior $kg <-> ke$ y detuning $Dpa$.

El Hamiltoniano puede escribirse como $hat(H) = Ha + Hc + hat(V)_(A C)$, donde $Ha$ es el Hamiltoniano del átomo libre, $Hc = hbar wc cre anh$ y $hat(V)_(A C)$ es la interacción dipoloeléctrica.

Cuando no hay interacción, $hat(V)_(A C)=0$, los eigenestados del sistema son los estados $ket(i N)$, que representan al átomo en el estado $i in {g,e,s}$ con $N$ fotones del láser de control. Cerca de la resonancia, los estados $ket(s N)$ y $ket(e [N+1])$ están casi degenerados y separados por una energía $hbar Dac$

Al introducir el acoplamiento $hat(V)_(A C)$, estos dos estados desnudos se acoplan mediante el elemento de matriz:

$ braket(s N, hat(V)_(A C), e [N+1]) = (hbar rabic)/2, $

lo que levanta la cuasi-degeneración y fuerza a los niveles a repelerse energéticamente (fenómeno que se conoce como _anticrossing_). Al diagonalizar este subespacio bidimensional, se producen dos nuevos eigenestados perturbados que denotaremos como $ket(+)$ y $ket(-)$, y son superposiciones ortogonales de los estados desnudos originales:

$
  ket(+) &= sin theta ket(s N) + cos theta ket(e [N+1]) \
  ket(-) &= cos theta ket(s N) - sin theta ket(e [N+1])
$

donde la relación entre la fuerza de acomplamiento y la desintonía determina al ángulo de mezcla $theta = -rabic/Dac$. A su vez, las energías de estos estados vestidos tienen una separación dadas por una frecuencia de Rabi efectiva:

$ hbar rabieff = hbar sqrt(rabic^2 + Dac^2) $

Veamos que en resonancia exacta $Dac=0$, se tiene $theta = pi/4$, por lo que los _dressed states_ son combinaciones simétricas y antisimétricas puras (50/50) de $ke$ y $ks$; y bajo esta condición, la separación de la energía alcanza el valor mínimo $hbar rabic$.

Finalmente, una de las consecuencias de la formación de _dressed states_, es el desdoblamiento de Autler-Townes en el espectro de absorción del láser de prueba débil.

Debido a que el estado desnudo $ke$ está distribuido en los dos estados vestidos $ket(+)$ y $ket(-)$, la transición original de frecuencia se divide. El láser de prueba ahora resuena con las dos transiciones permitidas: $ket(g [N+1]) -> ket(+)$ y $ket(g [N+1]) -> ket(-)$. En consecuencia, la línea de absorción se divide en dos picos (doblete) separadas por una frecuencia $rabieff$.

Este desdoblamiento de los niveles de energía es la evidencia macroscópica del acoplamiento fuerte y coherente entre el átomo y el campo electromagnético.

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