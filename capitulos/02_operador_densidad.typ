// ===================================================================
// 02_operador_densidad.typ
// ===================================================================
#import "../style.typ": *

=== Operador densidad (Cohen) <operador-densidad>
_Descripción de porqué es importante el operador densidad, y porqué es necesario para describir sistemas disipativos y estados mezclados._

Si consideramos un sistema cuyo vector de estado en el instante $t$ es

#let Psi = $Psi (t)$
#let cn = $c_n (t)$
#let cm = $c_m^* (t)$
#let hH = $hat(H)$
#let Hmn = $H_(m n)$
#let den = $rho (t)$
#let dmn = $rho_(m n) (t)$
#let dnn = $rho_(n n) (t)$
$ ket(Psi) = sum_n cn ket(n) $

// tal como en en caso de la ec. @eq:total-dep-state con $n=2$, 
los coeficientes $cn$ satisfacen

$ sum_n |cn|^2 = 1 $ <eq:sum-coeficientes>

lo cual implica que $Psi$ está normalizada.\
Sea $hH$ en Hamiltoniano del sistema, que es un observable, sus elementos de matriz están dados por

$ braket(m,hH,n) = Hmn $

y el valor promedio de $hH$ en el instante $t$ es

$ <hH>(t) = braket(Psi, hH, Psi) = sum_(m,n) cm cn Hmn $ <eq:mean-t>

lo cual introduce el concepto del operador densidad, definido como

$ den = ketbra(Psi) $

cuya matriz, llamada *matriz de densidad*, está representada en la base ${ket(n)}$ y sus elementos son

$ dmn = braket(m, den, n) = cm cn $ <eq:density-matrix-elements>

Con esta nueva definición, podemos expresar las ecuaciones @eq:sum-coeficientes y @eq:mean-t en términos del operador $den$, tales que

$
  &sum_n |cn|^2 = sum_n dnn = Tr den = 1 \
  &<hH>(t) = Tr(den hH)
$

y, finalmente, la evolución temporal del operador $den$ conocida como ecuación de Von Neumann, es

$ dv(,t) den = -i/hbar [hH(t), den] $

Por lo tanto, para determinar la evolución temporal de $den$, basta con conocer la evolución de sus elementos de matriz expresados en @eq:density-matrix-elements, lo que nos lleva a trabajar con un sistema de ($2n^2$)#footnote[En general, tendríamos $n^2$ ecuaciones que se duplican a $2n^2$ al considerar números complejos.] ecuaciones diferenciales acopladas.

$ dv(,t) rho_(m n) (t) = braket(m,[hH, den], n) $