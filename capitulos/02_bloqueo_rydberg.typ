// ===================================================================
// 02_bloqueo_rydberg.typ
// ===================================================================
#import "../style.typ": *


=== Interacciones interatómicas y bloqueo de Rydberg <sec:bloqueo_rydberg>


#let ryd = $R_0$
#let ph(it) = $phi.alt_(it)$
Hasta este punto, el marco teórico ha descrito la dinámica de átomos aislados interactuando con campos electromagnéticos y con el entorno; sin embargo, también queremos poder explicar mecanismos de interacciones fuertes y controlables entre los propios átomos.

Queremos poder trabajar con sistemas atómicos que cumplan dos condiciones importantes: tener tiempos de coherencia lo suficientemente largos para poder operar con ellos, y que sean capaces de tener interacciones a larga distancia lo suficientemente intensas para superar las tasas de disipación con el entorno. Los mejores candidatos para estos requisitos son los átomos de Ryberg #footnote[Desarrollo obtenido de @gerry_introductory_2005[$section 10.1, section 10.2$], @cohentannoudji_quantum_2005[$section "C.XI"$], @peña_introduccion_2014[$section 17.2$]].

Un átomo de Rydberg es un átomo en el cual uno de sus electrones de valencia ha sido excitado a un estado con número cuántico principal $n$ muy alto ($n>=20$), típicamente $n sim 50$. La energía de la ligadura electrónica de un estado de Rydberg está dada por la expresión:

$ E_(n l) = - ryd/(n-delta_l)^2 approx -ryd /n^2 $

donde $ryd approx 13.6 "eV"$ es la constante de Rydberg y $delta_l$ es un defecto cuántico que corrige la desviación del potencial central respecto a un potencial hidrogenoide debido a la penetración del electrón en el _core_. Este defecto depende del momento angular orbital $l$, pero para estados con $l$ alto, $delta_l$ es muy pequeño y el número cuántico efectivo $n^* = n - delta_l$ se aproxima al número cuántico principal $n$.

En los experimentos de electromagnética cuántica de cavidades (CQED), se utilizan los estados de Rydberg circulares. Son estados donde el electrón obtiene el máximo momento angular permitido para un $n$ dado ($l=n-1$) y su máxima proyección en el eje de cuantización ($abs(m)=n-1$). Se llaman así porque en el límite clásico, estos estados expresan a un electrón en una órbita circular.

Son de interés especial porque poseen numerosas propiedades que los vuelven ideales. La primera de ellas es que solo una trancisión dipolar eléctrica está permitida, $n <-> n-1$, lo que hace que la dinámica esté aislada y pueda aproximarse bastante a un átomo a dos niveles. Su radio "clásico" escala como $n^2 a_0$, donde $a_0$ es el radio de Bohr, por lo que para $n sim 100$ el átomo tiene dimensiones no microscópicas. El elemento de matriz del operador momento dipolar eléctrico entre dos estados circulares adyacentes ($Delta n =1$) escala como:

$ d = braket(n, hat(q) r, n\') sim q n^2 a_0. $

Para $n=50$, el momento dipolar es aproximadamente 300 veces más grande que el de una transición óptica normal, lo que se traduce en un acoplamiento luz-materia $g$ bastante fuerte. La frecuencia de radiación emitida en una transición entre estados de Rydberg adyacentes está dada por:

$ omega_0 = (E_(n l) - E_(n\' l\'))/hbar approx (2 ryd)/(hbar n^3) $

por lo que, para $n sim 50$, la frecuencia se encuentra en el rango de las microondas con longitudes de onda de milímetros, precisamente las dimensiones que soporta la cavidad para ondas estacionarias. Finalmente, la tasa de emisión espontánea escala como $Gamma sim Gamma_0 n^(-5)$, por lo que los estados circulares de Rydberg tienen tiempos de vida extremadamente largos del orden de $10^(-1)$ segundos en comparación con los $10^(-9)$ segundos de las transiciones ordinarias.

Esta combinación de acoplamientos dipolares enormes (que permiten frecuencias de Rabi muy altas) y tiempos de vida radiativos largos (que minimizan la decoherencia) es precisamente lo que permite alcanzar el régimen de acoplamiento fuerte en cavidades y estudiar cómodamente los fenómenos cooperativos.

Ahora que tenemos claras las propiedades interesantes de los átomos de Rydberg, queremos ver cómo interactúan entre sí. Cuando dos átomos neutros se encuentran una distancia $R >> a_0$ (no confundir $R$ con la constante de Rydberg $ryd$), el solapamiento de sus nubes electrónicas es despreciable y los efectos de intercambio pueden omitirse. Sin embargo, a distancias de varias micras, los átomos interactúan a través del acoplamiento de sus momentos dipolares electromagnéticos que fluctúan, y la contribución dominante en la interacción de largo alcance viene del acoplamiento entre sus dipolos eléctricos.

Consideremos un sistema dado por dos átomos, $A$ y $B$, cuyos núcleos están fijos y separados por un vector $vecb(R) = R vecb(n)$. El hamiltoniano total del sitema es $hat(H) = hat(H)_A+hat(H)_B+W$, donde $W$ es el término de interacción electrostática y puede expandirse en multipolos. El primer término no nulo de esta expansión es la interacción dipolo-dipolo $Wdd$ que, una vez alineado el eje $z$ de cuantización a lo largo del vector internuclear $vecb(n)$, tiene la forma:

$ Wdd = e^2/(pi epsilon_0 R^3) (X_A X_B + Y_A Y_B -2 Z_A Z_B) $

donde $(X,Y,Z)$ representan las coordenadas de los electrones de valencia respecto a sus núcleos. Esta interacción $Wdd$ se trata como una perturbación sobre los autoestados del Hamiltoniano no perturbado $hat(H)_0 = hat(H)_A+hat(H)_B$, cuyos estados base se denotan como $ket(ph(A) ph(B))$.

El efecto de esta perturbación sobre $ket(ph(A) ph(B))$ depende del estado inicial de los átomos:

===== Interacción fuera de resonancia (fuerzas de van der Waals)

Si ambos átomos están en el estado base (o cualquier estado donde no exista una trancisión degenerada acoplada por el dipolo), el valor esperado de primer orden de la perturbación es cero: $braket(ph(A) ph(B), Wdd, ph(A) ph(B))=0$. Esto ocurre porque los átomos neutros aislados no tienen momento dipolar eléctrico permanente, pues $expval(X), expval(Y), expval(Z)$ son nulos por paridad.

Por lo tanto, la corrección a la energía debe calcularse utilizando teoría de perturbaciones de segundo orden:

$ Delta E^((2)) = sum_(k != 0) abs(braket(ph(k), Wdd, ph(0)))^2/(E_0 - E_k) = -C_6/R^6. $

Dado que los denominadores energéticos son negativos (pues partimos del estado base), esta interacción a segundo orden da lugar a un potencial atractivo que decae como $1/R^6$, conocido como fuerzas de van der Waals. Físicamente, surgen porque la fluctuación cuántica del dipolo en el átomo $A$ induce un dipolo instantáneo en el átomo $B$, y la interacción que resulta de estos dos dipolos correlacionados reduce la energía total del sistema.

===== Interacción resonante (intercambio dipolo-dipolo)

La interacción cambia de si el sistema se prepara en un estado excitado degenerado. Si suponemos (sin pérdida de generalidad) que el átomo $A$ está en un estado excitado $ke$ y el átomo $B$ en un estado inferior $kg$, de manera que el sistema se encuentra en el estado $ket(e_A g_B)$, este estado es degenerado (o cuasi-degenerado) con el estado intercambiado $g_A e_B$.

En este caso, la teoría de perturbaciones para estados degenerados pide diagonalizar la matriz de perturbación $Wdd$ en el subespacio degenerado. Los elementos fuera de la diagonal, $braket(g_A e_B, Wdd, e_A g_B)$, son en general distintos de cero si la transición $kg <-> ke$ es dipolo-permitida.

Esta diagonalización de este subespacio genera nuevos estados simétricos y antisimétricos:

$ ket(Psi_(+-)) = 1/sqrt(2)(ket(e_A g_B) +- ket(g_A e_B)) $

cuyas energías sufren una correción de primer orden:

$ Delta E^((1)) = +- C_3/R^3 $

representado en la @fig:bloqueo. Esta interacción resonante, llamada resonancia de Föster, es muy distintia a la de van der Waals. Escala como $1\/R^3$ (por lo que su alcance es mucho mayor) y describe el intercamio coherente de la excitación entre los dos átomos, por lo que en el Hamiltoniano del sistema se manifiesta como un acoplamiento directo de la forma:

$ hat(H) = hbar C_3/R^3 (ketbra(e_A g_B, g_A e_B) + ketbra(g_A e_B, e_A g_B)). $

#{
      let gg = 3
      let gs = 1.5
      let ss = 0
      let d = 0.3
      let sep = 1
      let L = 1.2
      let J = 0.8
      let mark = 0.1
      figure(diagrama(
        cell-size: 1mm,
        mark-scale: 130%,
        //diagrama 1
        //niveles
        edge((0,gg),(L,gg)),
        edge((0,gs),(L,gs)),
        edge((0,ss),(L,ss), "--"),
        node((L -L/4,gg -0.3), $ket(g g)$),
        node((L -L/4,gs -0.3), $ket(g e), ket(e g)$),
        node((L/4,ss -0.3), $ket(e e)$),
        //distancias energias
        edge((0,ss),(L,ss -d), bend: -10deg),
        edge((0,ss),(L,ss+d), bend: 10deg),
        node((L +0.2,ss -d - 0.2), $Oee$),
        node((L +0.2,ss +d + 0.2), $-Oee$),
        //laseres
        edge((L/4,gg),(L/4,gs), "-|>", "wave"),
        edge((L/4,gs),(L/4,ss), "-|>", "wave"),
        //ejes
        edge((-0.2,gg +0.2),(-0.2,ss -d -0.3), "-|>"),
        edge((-0.2,gg +0.2),(L+0.2,gg +0.2), "-|>", $C_3$, label-side: right),
        edge((-0.2 -mark,gg),(-0.2 +mark,gg)),
        edge((-0.2 -mark,gs),(-0.2 +mark,gs)),
        edge((-0.2 -mark,ss),(-0.2 +mark,ss)),
        node((-0.2 -mark -2*mark,gg), $0$),
        node((-0.2 -mark -2*mark,gs), $E$),
        node((-0.2 -mark -2*mark,ss), $2E$),
        

        //diagrama 2
        //niveles
        edge((L+0.5+J+sep/2 -J/2,gg),(L+0.5+J+sep/2 +J/2,gg)),
        edge((L+0.5,gs),(L+0.5+J,gs)),
        edge((L+0.5+sep+J,gs),(L+0.5+sep+2*J,gs)),
        edge((L+0.5+J+sep/2 -J/2,ss),(L+0.5+J+sep/2 +J/2,ss), "--"),
        edge((L+0.5+J+sep/2 -J/2,ss+d),(L+0.5+J+sep/2 +J/2,ss+d)),
        edge((L+0.5+J+sep/2 -J/2,ss -d),(L+0.5+J+sep/2 +J/2,ss -d)),
        node((L+0.5+J+sep/2 -J/2 -0.3,gg), $ket(g g)$),
        node((L+0.5,gs), $ket(Psi_+)$),
        node((L+0.5+sep+J,gs), $ket(Psi_-)$),
        //laseres
        edge((L+0.5+J +sep/2,gg),(L+0.5 +J/2,gs), "-|>", "wave"),
        edge((L+0.5 +J/2,gs),(L+0.5+J +sep/2,ss), "-|>", "wave"),
        //distancia energías
        edge((L+0.5+J+sep/2 +J/2 +0.1,ss),(L+0.5+J+sep/2 +J/2 +0.1,ss -d), "<->", $Delta E$),
      ),
      caption: [Diagrama de la correción de primer orden $Delta E^((1)) = +- C_3\/R^3$ ocasionada por la resonancia de Föster. El diseño del diagrama está basado en el que se muestra en @gaetan_observation_2009.]
    )} <fig:bloqueo>

===== Bloqueo de Rydberg

Como ya se estableció anteriormente, los estados de Rydberg tienen momentos dipolares muy grandes $d prop n^2$, y dado que las interacciones dipolares escalan con el cuadrado del momento de transición $C_3 prop d^2, C_6 prop d^4$, la magnitud de la repulsión energética entre los átomos de Rydberg se amplifica bastante (hasta por un factor de $n^11$ para van der Waals).

Entonces, cuando dos átomos cercanos son excitados de manera simultánea al mismo estado de Rydberg $ket(s_A s_B)$, la fuerte interacción (provocada por el acoplamiento resonante $C_3\/R^3$ inducido por estados vecinos, o por van der Waals $C_6\/R^6)$ desplaza la energía del estado doblemente excitado. Este desplazamiento, denotado en esta tesis como $Oee$, es tan grande que saca a la transición de dos fotones fuera de resonancia con el láser.

La consecuencia de ello es que el láser, que tiene la energía exacta para excitar a un solo átomo, no tiene energía suficiente para excitar al segundo, provocando un bloqueo de Rydberg. Bajo este fenómeno, se prohíbe la excitación simultánea al estado $ket(s_A s_B)$ y se fuerza al sistema a evolucionar solo en el subespacio de una sola excitación colectiva.