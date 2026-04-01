// ===================================================================
// 03_implem_numerica.typ
// ===================================================================
#import "../style.typ": *


=== Implementación numérica <sec:implem-numerica>


Para el sistema propuesto en este trabajo, el espacio de Hilbert total se construye como el producto tensorial de los subespacios individuales:

$ HH = HH_"cavidad" ** HH_"átomo1" ** HH_"átomo2". $ <eq:hilbert_total>

Dado que cada átomo posee 4 niveles de energía, y el espacio de Fock de la cavidad debe ser truncado un número máximo de fotones, $nmax$, la dimensión total del espacio de Hilbert es $D = 4^2 nmax$. Por lo tanto, la matriz densidad $rr(t)$ contiene $D = (16 nmax)^2$ elementos #footnote[En realidad, la dimensión final es $2D$, debido que cada elemento de la matriz densidad tiene una parte real y una parte imaginaria, que se operan como elementos independientes.].

Para un truncamiento típico de $nmax = 10$, el sistema requiere la resolución simultánea de $(160)^2 = 25,600$ ecuaciones diferenciales ordinarias (EDOs) acopladas y con coeficientes complejos. Además, a medida que se incrementa el truncamiento $nmax$ para obtener resultados más precisos, la dimensión del espacio de Hilbert crece exponencialmente, lo que hace que la solución analítica sea inaccesible.

Por tanto, se hace necesario recurrir a métodos numéricos para resolver la dinámica del sistema. Sin embargo, aún así resolverlo directamente usando solamente un lenguaje interpretado como Python resulta lento y poco eficiente, por lo que se opta por una alternativa numérica más optimizada.


==== Paquetería OpenKet


Para la resolución numérica de la ecuación maestra de Lindblad se utilizó OpenKet, una paquetería desarrollada en Python y especializada en la manipulación de objetos cuánticos en notación de Dirac. La ventaja más importante de OpenKet es que permite definir el problema del sistema cuántico en lenguaje simbólico utilizando la notación de Dirac, y luego traducirlo a objetos numéricos listos para ser resueltos utilizando librerías como SciPy (de Python) o GSL (de C).

El flujo de trabajo en OpenKet se dividió en tres etapas descritas a continuación.

===== Definición simbólica del espacio de Hilbert y operadores

Esta etapa consistió en construir las expresiones algebráicas que describen al sistema.

Primero, se definieron simbólicamente los estados base de cada subsistema mediante objetos tipo `Ket` y `Bra`, utilizando la notación de Dirac. La base ortonormal completa se generó con el producto tensorial de las bases individuales: ${ket(i)_"A1" ** ket(j)_"A2" ** ket(N)_"cav"}$, donde $i,j in {g,e,s,p}$ y $N in {0,1,2,...,nmax}$. De ahora en adelante, al elemento de la base completa lo denotaremos simplemente como $ket(l_1 l_2 n)$, donde $l_1$ y $l_2$ es el nivel del átomo 1 y 2, respectivamente, y $n$ el número de fotones dentro de la cavidad.

Luego, se instanciaron los operadores de creación ($cre$) y aniquilación ($anh$), así como los operadores de transición atómica $sigma_(i j)^((k)) = ket(i)_k bra(j)$. Y gracias a la capacidad de OpenKet de manejar objetos simbólicos, se pudo escribir el Hamiltoniano total $hat(H)$ y los superoperadores de disipación $LL[OO]$ de forma idéntica a sus expresiones analíticas (presentadas en la sección anterior), manteniendo las constantes de acoplamiento, desintonías y tasas de decaimiento como parámetros libres que se pueden modificar fácilmente para explorar diferentes regímenes del sistema.

===== Generación de EDOs y proyección de ecuación maestra

Una vez definido el sistema en términos de objetos simbólicos, se utilizó la función `build_ode` de OpenKet para traducir la ecuación maestra de Lindblad a un sistema de EDOs acopladas. Esta función toma la expresión algebráica de $dot(rr)$, calcula los conmutadores y productos de operadores, y proyecta el resultado sobre la base completa del espacio de Hilbert. Posteriormente, OpenKet genera de forma automática un archivo de código en lenguaje C que contiene el sistema de EDOs acopladas explícitamente desarrollado, y adicionalmente se genera un diccionario de mapeo (escrito en lenguaje Python), que vincula las variables simbólicas de Python con los índices del arreglo numérico en C.

===== Integración temporal en GSL

Finalmente, se obtiene la evolución temporal del sistema a partir de un estado inicial puro, expresado simbólicamente y que es mapeado a una expresión numérica trabajable usando el diccionario creado en el paso anterior. Para este trabajo se estableció que el sistema inicia en el estado base absoluto, es decir, sin fotones en la cavidad y ambos átomos en su estado base $ket(g)$:

$ rr(t_(=0)) = ket(g g 0) bra(g g 0). $

La integración temporal se ejecutó a través del uso de la función `gsl_main`, la cual genera la función `main` de C para obtener el archivo final listo para ser compilado y ejecutado, utilizando la biblioteca _GNU Scientific Library (GSL)_. GSL aplica algoritmos de integración de paso adaptativo para resolver el sistema de EDOs de manera más precisa, y los resultados de la integración se exportaron a archivos de formato HDF5 para su posterior análisis.


==== Definición y extracción de observables físicos


La matriz de densidad $rr(t)$ resultante de la integración numérica contiene toda la información estadística del sistema; sin embargo, para poder exprimir su sentido físico, es necesario traducirla a magnitudes físicas medibles calculando los valores esperados de los observables.


En OpenKet, el cálculo de un observable $expval(OO) = tr(rr OO)$ se realiza definiendo primero el operador simbólico $OO$ correspondiente, para así luego extraer su valor numérico en cada instante de tiempo usando las funciones `trace` y `sub_qexpr`. La función `sub_qexpr` mapea cada elemento del operador densidad $rr_(n,m) = mel(n,rr,m)$, obtenidos tras evaluar analíticamente la traza $tr(rr OO)$, hacia sus correspondientes índices en el arreglo numérico unidimensional resuelto por el integrador, utilizando el diccionario generado durante la compilación.

Para el análisis de la dinámica del sistema de estudio, se definieron los siguientes observables.

===== Dinámica de poblaciones de los niveles atómicos

Para estudiar el fenómeno de bloqueo y la distribución de excitaciones, se calculó la probabilidad de encontrar al par de fotones en cada uno de los 16 estados atómicos posibles. El operador de proyeccion para el estado conjunto $ket(i j)$, donde el átomo 1 está en el estado $ket(i)$ y el átomo 2 en el $ket(j)$, se define como $PP_(i j) = sigk(i,i,1) ** sigk(j,j,2) ** II_"cav"$.

La evolución temporal de la población está dada por:

$ PP_(i j) (t) = tr[rr(t) PP_(i j)]. $

===== Número de fotones dentro de la cavidad

La respuesta de la configuración de dos átomos altera el estado del campo EM en la cavidad. Para cuantificar este efecto, se evaluó el número medio de fotones utilizando el operador de número $NN = cre anh$, por lo tanto,

$ expval(NN)(t) = tr[rr(t) cre anh]. $

Este observable permite constrastar la absorción y emisión de luz entre los átomos y la cavidad en el régimen de átomos independientes frente al de fuerte interacción interatómica, sirviendo así como evidencia del comportamiento colectivo del sistema.