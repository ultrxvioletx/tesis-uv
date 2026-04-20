// ===================================================================
// glosario.typ
// ===================================================================
#import "../style.typ": *

#heading(level: 2, outlined: false, numbering: none)[Glosario de notación]

#show math.equation: it => math.bold(it)


#heading(level: 3, outlined: false, numbering: none)[Estados cuánticos]

- $kg, ke, ks, kp$: Estados atómicos base, intermedio, de Rydberg y auxiliar, respectivamente.
- $kgg, kss, kpp$: Estados conjuntos de dos átomos.
- $dicke1$: Estado colectivo simétrico (superradiante) de Dicke para un sistema de dos átomos.
- $dicke2$: Estado colectivo antisimétrico (subradiante) de Dicke para un sistema de dos átomos.
- $fost1, fost2$: Estados vestidos colectivos generados por la interacción de Förster entre los estados #kss y #kpp.


#heading(level: 3, outlined: false, numbering: none)[Espacios de Hilbert]

- $HH$: Espacio de Hilbert total del sistema.
- $HHc$: Subespacios de Hilbert de la cavidad.
- $HHa1, HHa2$: Subespacios de Hilbert del átomo 1 y átomo 2, respectivamente.


#heading(level: 3, outlined: false, numbering: none)[Símbolos generales]

- $rr$: Operador densidad (matriz densidad) del sistema.
- $OO$: Operador arbitrario.
- $tr$: Traza de un operador.
- $LL[OO]$: Superoperador de Lindblad que modela la disipación y el decaimiento.


#heading(level: 3, outlined: false, numbering: none)[Hamiltonianos]

- $Ha$: Hamiltoniano de un átomo libre, que describe sus niveles de energía.
- $Hc$: Hamiltoniano del modo de la cavidad óptica, modelado como un oscilador armónico cuántico.
- $Hb$: Hamiltoniano de interacción del bombeo (láser de prueba) con el modo de la cavidad.
- $Hi$: Hamiltoniano de interacción general entre los subsistemas (átomos, cavidad y campos externos).
- $Hca$: Hamiltoniano de interacción cavidad-átomo (Jaynes-Cummings).
- $Hla$: Hamiltoniano de interacción luz-átomo (teoría semiclásica).
- $Hdr$: Hamiltoniano de interacción dipolo-dipolo resonante que media el intercambio de excitación en la transición inferior ($ket(e g) <-> ket(g e)$).
- $Hee$: Hamiltoniano de interacción dipolo-dipolo resonante que acopla los estados doblemente excitados $kss$ y $kpp$.


#heading(level: 3, outlined: false, numbering: none)[Operadores atómicos y de campo]

- $cre, anh$: Operadores de creación y aniquilación de fotones en la cavidad.
- $NN$: Operador de número de fotones ($cre anh$).
- $sig(i, j)$: Operador de transición atómica (o de Pauli) del nivel $ket(i)$ al nivel $ket(j)$, definido como $ket(i) bra(j)$.
- $sigk(i, j, k)$: Operador de transición atómica para el $k$-ésimo átomo.


#heading(level: 3, outlined: false, numbering: none)[Parámetros del sistema]

- $nmax$: Número máximo de fotones considerado para truncar la base de Fock del espacio de Hilbert de la cavidad.
- $g$: Constante de acoplamiento coherente entre un átomo y un fotón de la cavidad (frecuencia vacuum Rabi de un fotón).
- $rabip, rabic$: Frecuencias de Rabi de los láseres de prueba y de control, respectivamente. Caracterizan la intensidad de los campos.
- $wp, wc$: Frecuencias angulares de los campos láser de prueba y control, respectivamente.
- $weg, wse, wps$: Frecuencias de transición atómica.
- $Dpa, Dac$: Desintonías del láser de prueba respecto a la transición $weg$ y del láser de control respecto a la transición $wse$.
- $scan$: Variable de barrido de frecuencia para la sonda láser de prueba, alrededor de $Delta = 100$.
- $rabieff, geff$: Frecuencia de Rabi y constante de acoplamiento átomo-cavidad efectivas tras la supresión del nivel intermedio.
- $Deff$: Desintonía efectiva del sistema de dos fotones.
- $sg, ss$: Corrimientos Stark inducidos en el estado base y en el estado de Rydberg.
- $d1, d2, d2b$: Distancias espectrales entre picos de resonancia para el caso de un átomo, dos átomos independientes y bajo régimen de bloqueo.
- $Oee$: interacción de Förster entre los estados $kss$ y $kpp$, proporcional a $Oee = Cee \/ R^3$.
- $R$: Distancia internuclear entre los dos átomos.
- $Cdr, Cee$: Constantes de acoplamiento para las interacciones dipolares de intercambio.


#heading(level: 3, outlined: false, numbering: none)[Disipación y decaimiento]

- $kappa$: Tasa de pérdida de fotones de la cavidad a través de los espejos.
- $dece, decs$: Tasas de decaimiento espontáneo de los niveles intermedio $ke$ y de Rydberg $ks$, respectivamente.
- $dec12$: Tasa de decaimiento colectivo (superradiancia/subradiancia).


#heading(level: 3, outlined: false, numbering: none)[Poblaciones y observables]


- $Pg, Pe, Ps, Pp$: Probabilidades de ocupación (poblaciones) de los niveles atómicos individuales.
- $Pss$: Población del estado doblemente excitado.
- $P1s$: Población colectiva de una sola excitación.
- $Nexp$: Valor esperado del número de fotones dentro de la cavidad.
- $Nss$: Número medio de fotones en el estado estacionario ($t -> infinity$).