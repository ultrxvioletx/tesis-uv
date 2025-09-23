// ===================================================================
=== Átomo de 3 niveles (Scully-Zubary) (sigue pendiente) <sec01:3-niveles>
#let H0 = $hat(H)_0$
#let HI = $hat(H)_I (t)$
#let completez = $ketbra(a) + ketbra(b)$
#let ka = $ket(a)$
#let kb = $ket(b)$
#let kc = $ket(c)$
Para estudiar el caso del átomo de 3 niveles, obtendremos el Hamiltoniano RWA como una generalización del Hamiltoniano del átomo de 2 niveles interactuando con un campo clásico a una sola frecuencia, presentado en la sección anterior, y lo aplicaremos para analizar un átomo de 3 niveles interactuando con un campo clásico a dos frecuencias distintas, considerando sus tres configuraciones posibles: cascada, lambda ($Lambda$) y Vee ($"V"$).

Para ello, tomemos el Hamiltoniano de la @sec01:atomo-campo

$ hat(H) = H0 + HI $

Usando la relación de completez $completez = bb(1)$, escribimos $H0$ como

$
  H0
  &= (completez) H0 (completez)\
  &= hbar wa ketbra(a) + hbar wb ketbra(b)
$

donde usamos la propiedad $H0 ka = hbar wa ka$ y $H0 kb = hbar wb kb$. De forma similar, escribimos a $HI$ como

$
  HI
  &= -e (completez) vecb(r) (completez) vecb(E)(t)\
  &= -(dab ketbra(a,b) + dba ketbra(b,a)) vecb(E)(t)
$

==== Lambda $Lambda$
#let bombeo = $Omega_p$
#let sonda = $Omega_s$

En el átomo de 3 niveles en configuración Lambda, tenemos dos estados base, $kb$ y $kc$, y un estado excitado $ka$. Este átomo presenta superposición coherente, es decir, puede existir en un estado que es una superposición de sus niveles base

$ ket(Psi_("coherente")) = c_b kb + c_c kc $

y donde la relación de fase entre los coeficientes $c_b$ y $c_c$ está bien definida y se mantiene estable en el tiempo. Esto quiere decir que es un único estado cuántico donde el átomo está, en cierto sentido, en ambos estados a la vez y con una fase relativa fija.

Ahora tomemos nuestro átomo $Lambda$ y consideremos dos campos con respectivas frecuencias $nu_1$ y $nu_2$
