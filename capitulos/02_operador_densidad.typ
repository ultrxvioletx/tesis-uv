// ===================================================================
// 02_operador_densidad.typ
// ===================================================================
#import "../style.typ": *


=== Entornos disipativos


Hasta ahora, se ha explicado toda la dinámica utilizando vectores de estado $ket(psi)$, lo que supone que el sistema se encuentra aislado de su entorno y que es un estado puro. Sin embargo, en los procesos reales, el sistema interactúa con los grados de libertad del entorno. Estos grados de libertad son, en principio, observables, pero en la práctica son muy difíciles de calcular y de nulo interés para el modelo de esta tesis.

Al describir solamente el sistema de interés e ignorar la información del entorno, se necesita trabajar con un enfoque estadístico #footnote[Desarrollo obtenido de @cohentannoudji_quantum_20051[$section "E.III"$] y @breuer_theory_2002[$section 3.1, section 3.2$]] que sea capaz de explicar la pérdida de información. Este es el propósito de definir el operador densidad.


==== Operador densidad y pérdida de coherencia


Para describir un sistema del cual no se puede conocer toda su información y no puede ser descrito por un único vector $ket(psi)$, se utiliza una mezcla estadística de varios estados posibles $ket(psi_k)$, cada uno con su propia probabilidad $p_k$ de ocurrir.

Para tratar con los estados puros y los estados mezcla, se introduce al operador densidad definido como:

$ rr = sum_k p_k ketbra(psi_k) $

donde se debe satisfacer $0 <= p_k <= 1$ y $sum_k p_k = 1$.

Este operador contiene toda la información física que conocemos del sistema y tiene propiedades de naturaleza probabilísitica: es un operador hermitiano ($rr^dagger=rr$) y de traza unitaria ($tr(rr)=1$, lo que garantiza que se preserve la probabilidad total), además para cualquier $ket(u)$ se cumple que $braket(u,rr,u)>=0$ y, finalmente, ofrece un criterio de pureza, tal que para un estado puro se tiene $rr^2=rr => tr(rr^2)=1$, mientras que para las mezclas estadísticas (llamadas estados mixtos) se cumple la desigualdad $tr(rr^2)<1$. 

Con estas propiedades, se puede demostrar que el valor esperado de cualquier observable físico $OO$, se calcula de la siguiente forma:

$ expval(OO) = tr(rr OO) $

y, además, se puede estimar la evolución temporal del operador $rr$ aplicándole la ec. de Schrödinger, y obtenemos la ec. de Von Neumann:

$ dv(,t) rr(t) = 1/(i hbar) [hat(H)(t), rr(t)]. $ <eq:von_neumann>

Para obtener una interpretación física, se calculan los elementos de matriz del operador densidad en una base ortonormal discreta {$ket(u_n)$}. A los elementos diagonales de esta representación matricial, $rr_(n n)=braket(u_n,rr,u_n)$, se le denominan poblaciones y se expresan como:

$
  rr_(n n) &= bra(u_n) (sum_k p_k ketbra(psi_k)) ket(u_n) \
    &= sum_k p_k braket(u_n, psi_k) braket(psi_k, u_n) \
    &= sum_k p_k abs(braket(u_n, psi_k))^2.
$

Estas poblaciones son números reales positivos tales que $sum_n rr_(n n)=1$, y físicamente representan la probabilidad de encontrar al sistema en el estado $ket(u_n)$ al realizar una medición.


Por otro lado, los elementos fuera de la diagonal definidos como $rr_(n m)=braket(u_n,rr,u_m)$ son denominados como coherencias y son, en general, números complejos:

$ rr_(n m) = sum_k p_k braket(u_n,psi_k) braket(psi_k, u_m). $

Estas coherencias representan los efectos de interferencia cuántica entre los estados $ket(u_n)$ y $ket(u_m)$. A diferencia de las poblaciones, las coherencias son el resultado de sumas de números complejos, por lo que si no existe una relación de fase entre los estados $ket(psi_k)$ que componen la mezcla, la suma sobre $k$ ocasiona que los términos interfieran de manera destructiva y se vuelven cero $rr_(n m)=0$.

Esta anulación de elementos no diagonales se le conoce como pérdida de coherencia, y representa la transición de un proceso puro cuántico (en donde las superposiciones de los estados sobreviven) a uno estadístico clásico.


==== Ecuación maestra de Lindblad


Como ya se estableció en el apartado anterior, la evolución de un sistema cuántico cerrado está descrita por la ecuación de Von Neumann (@eq:von_neumann).

Describe una evolución unitaria y reversible que conserva la pureza del estado, pues $tr(rr^2) = "cte"$. Sin embargo, la teoría de sistemas cuánticos abiertos establece que un sistema $S$ rara vez se encuentra aislado, normalmente interactúa con un entorno que tiene números infinitos de grados de libertad.

La dinámica del sistema reducido $S$, que se obtiene de tomar la traza parcial sobre los grados de libertad del entorno ($rr_S = tr_B (rr_(S+B))$), es en general no-Markoviano y se vuelve computacionalmente difícil o imposible de modelar. Para poder obtener una descripción de la evolución no-reversible de $rr_S (t)$, se recurre a la teoría de los semigrupos dinámicos cuánticos.

Bajo suposiciones de acoplamiento débil entre el sistema y el entorno (llamado aproximación de Born) y de que el entorno olvida rápidamente las correlaciones con el sistema (aproximación de Markov), la dinámica del sistema reducido pierde la memoria de sus estados pasados. En este límite, existe un teorema que establece la forma más general posible para obtener la evolución temporal del operador densidad y que preserve sus propiedades de hermiticidad y conservación de la traza.

A esta ecuación se le conoce como ecuación maestra en la forma de Lindblad, y se expresa como:

$ dv(,t)rr_S (t) = -i/hbar [hat(H), rr_S (t)] + sum_k gamma_k (hat(L)_k rr_S hat(L)_k^dagger - 1/2{hat(L)_k^dagger hat(L)_k, rr_S (t)}) $

donde ${hat(A), hat(B)} = hat(A) hat(B) + hat(B) hat(A)$ denota al anticonmutador.

El primer término describe la evolución unitaria y coherente dada por el Hamiltoniano del sistema, $hat(H)$. El segundo término, correspondiente a la suma, es el disipador y comúnmente es denotado como un súperoperador $LL[hat(L)]$; este es el responsable de la dinámica no unitaria y de decoherencia. La interpretación física de sus componentes es:

- Operador de salto de Lindblad ($hat(L)$): Estos operadores, no necesariamente hermitianos, describen los procesos a través de los cuales el sistema cambia energía con el entorno. Por ejemplo, en un átomo el operador de salto sería el operador de bajada $sig(g,e)$, que representa el salto del electrón desde el estado excitado al estado base causado por emisión espontánea de un fotón al entorno.

- Tasas de decaimiento ($gamma_k$): Son coeficientes reales y positivos que representan la probabildad por unidad de tiempo de que ocurra un proceso dado por $hat(L)$. Pueden ser la tasa de emisión espontánea de un átomo o la tasa de pérdida de una cavidad, por ejemplo.

El disipador, a su vez, se compone del término $hat(L)_k rr_S hat(L)_k^dagger$, denominado _feeding term_, que describe el incremento de población en el estado final del salto; y del anticonmutador $- 1/2{hat(L)_k^dagger hat(L)_k, rr_S (t)}$ que corresponde al _depletion term_, y disminuye la población del estado inicial e induce decaimientos exponenciales de las coherencias.