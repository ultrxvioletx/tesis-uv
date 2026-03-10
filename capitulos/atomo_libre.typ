// ===================================================================
// 03_atomo_libre.typ
// ===================================================================
#import "../style.typ": *

=== Átomo libre <atomo-libre>
#let H0 = $hat(H)_0$
#let en = $e^(-(i E_n t)/hbar)$
#let kn = $ket(n)$
#let psin = $psi_n (vecb(r))$
Partimos del sistema más sencillo al suponer un átomo en ausencia de campos externos, cuyo Hamiltoniano está dado por

$ H0 = 1/(2 m) vecop(P)^2 + V(r) $

donde $V(r)$ es la interacción coulombiana del electrón con el núcleo, y en la representación de espacio $vecop(P)=-i nabla$ y $r = abs(vecb(r))$. Además, como se trata de un átomo libre, podemos describir el sistema mediante la ecuación de Schrödinger dependiente del tiempo

$ i hbar pdv(Psi,t) = H0 Psi $

cuyas soluciones son los estados estacionarios

$ ket(Psi(t)) = en kn $ <eq:free-dep-state>

o, expresados en la representación de espacio

$ braket(r,Psi) = Psi(vecb(r),t) = psin en $ <eq:free-dep-wavefunction>

donde $braket(r,n) = psin$ es la parte espacial y representa a un átomo que se encuentra en un nivel de energía bien definido, llamada función de onda del estado $kn$, $en$ es un factor de fase y $E_n$ la energía del estado $kn$. \
$kn$, $psin$ y $E_n$ son los eigenestados, las eigenfunciones y los eigenvalores de $H_0$, respectivamente

$
  H0 psin = E_n psin \
  H0 kn = E_n kn
$ <eq:free-eigenfunction>

Y además las funciones de onda $psin$ y los estados $kn$ cumplen con la condición de ortonormalidad

$ integral dd(vecb(r),3) psi^*_m (vecb(r)) psin = braket(m,n) = delta_(n m) $

por lo que son una base en el espacio de Hilbert.