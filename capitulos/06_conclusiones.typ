// ===================================================================
// 06_conclusiones.typ
// ===================================================================
#import "../style.typ": *

En este trabajo de tesis se simuló y analizó la dinámica de un sistema compuesto por dos átomos de cuatro niveles en configuración cascada, acoplados fuertemente a un modo de una cavidad óptica disipativa y excitados por campos láser externos. El objetivo principal fue estudiar la transición desde un régimen de átomos Rydberg-independientes hacia uno de fuerte interacción colectiva entre ellos acompañada por el bloqueo de Rydberg.

A partir del análisis escalonado del sistema, utilizando la ecuación maestra de Lindblad y OpenKet, se obtienen las siguientes conclusiones:

- Para alcanzar el estado altamente excitado de Rydberg $ks$, se utilizó una arquitectura para excitación de dos fotones pasando por el estado intermedio $ke$. Dado que este estado tiene un decaimiento rápido, se demostró que la aplicación de la técnica de reducción adiabática de un nivel anula efectivamente su población. Esto permitió reducir el modelo a uno efectivo de dos niveles, protegiendo la coherencia cuántica necesaria para mantener las interacciones, aunque se hayan sacrificado las simetrías en el espectro debido a corrimientos Stark.

- Al simular dos átomos separados acoplados a la cavidad, se probó la formación de estados de Dicke. El sistema mostró súperradiancia, donde el acoplamiento átomo-cavidad se amplificó por un factor de $sqrt(2)$ (ignorando los efectos del corrimiento, que modifican este factor), causando por la interacción de $N_"at"=2$ átomos con la cavidad. Aquí, los átomos interactúan de forma Rydberg-independiente, permitiendo la doble excitación simultánea de los electrones al estado de Rydberg ($Pss != 0$).

- El resultado principal se obtuvo al activar la interacción entre los átomos, mediante la introducción el nivel auxiliar $kp$. Se mostró que, al incrementar la fuerza de interacción dipolar ($Oee$), la probabilidad de encontrar al sistema en un estado doblemente excitado cae a cero. La repulsión de las energías saca al sistema de resonancia, evitando la absorción del segundo fotón. Esto provoca que el par de átomos pierda su individualidad y se comporte como un superátomo efectivo de dos niveles que oscila de forma colectiva, reduciendo el espacio de Hilbert.

Se demostró numéricamente que la combinación de CQED con las interacciones de los átomos de Rydberg ofrece un control sobre la luz y la materia a nivel cuántico. Se puede convertir una cavidad óptica en un sistema que emite fotones de uno en uno, debido al bloqueo, lo que podría tener aplicaciones en el desarrollo de fuentes de fotones individuales o en la implementación de compuertas lógicas para el procesamiento de información cuántica.