// ===================================================================
// 01_introduccion.typ
// ===================================================================
#import "../style.typ": *


La comprensión y manipulación del mundo a escalas cuánticas ha sido uno de las causas de grandes revoluciones científicas en la física moderna. Ha transformado nuestra compresión de la naturaleza al proporcionarnos una nueva forma de describir sistemas donde la teoría clásica deja de ser válida. En esta nueva visión, uno de los fundamentos más importantes para el desarrollo de tecnologías contemporáneas, tales como la información cuántica, ha sido el estudio de la coherencia y la superposición. Sin embargo, para lograrlo se requiere un control en las interacciones de los elementos que componen los sistemas cuánticos, tales como átomos y fotones.

Con esto en mente, la óptica cuántica nace como el campo de conocimiento mediante el cual se estudia la interacción entre luz y materia a un nivel meramente cuántico, donde la radiación ya no se describe únicamente como una onda clásica, sino a través de la cuantización del campo en fotones. En este contexto, la electrodinámica cuántica en cavidades (CQED) ha sido uno de las configuraciones más exitosas para el estudio de estas interacciones. Al encerrar uno o varios átomos dentro de una cavidad óptica de alta calidad, es posible alcanzar regímenes de acoplamiento fuerte, donde un solo átomo y un solo fotón pueden intercambiar energía de manera coherente y controlada.

La motivación principal de este trabajo está en el análisis de fenómenos colectivos y cooperativos que surgen cuando múltiples átomos interactúan simultáneamente con el campo de la cavidad y entre sí. Para que esos fenómenos puedan existir, se requieren sistemas con tiempos de coherencia largos e interacciones suficientemente intensas para vencer las tasas de disipación de la interacción con el entorno. Por ello se utilizan los átomos de Rydberg (átomos excitados a estados con un número cuántico principal muy alto), que son los ideales para este propósito, pues sus momentos dipolares enormes provocan fuerzas grandes en sus interacciones interatómicas.

La combinación de CQED con átomos de Rydberg ocasiona un fenómeno cooperativo llamado bloqueo de Rydberg, mediante el cual la repulsión energética entre dos átomos cercanos impide la doble excitación simultánea. Este comportamiento convierte al par de átomos en un súper-átomo efectivo que solo puede tener una sola excitación compartida, generando una no-linealidad óptica y estados entrelazados de manera controlada.

En este contexto, esta tesis tiene como objetivo principal simular y analizar la dinámica cuántica de dos átomos de cuatro niveles en configuración cascada fuertemente acoplados a una cavidad óptica y sometidos a láseres externos. Se utiliza un enfoque numérico que está fundamentado en sistemas cuánticos abiertos y la ecuación maestra de Lindblad, que se resuelve numéricamente con el lenguaje simbólico-numérico de la paqueretía OpenKet, y se busca explorar la transición desde una estructura en que los átomos se comportan de forma independiente hacia uno de interacción colectiva. De esta forma, se analiza el impacto de bloqueo de Rydberg y el uso de ténicas de conservación de coherencia, tales como la reducción adiabática de un nivel.


=== Organización


Para abordar el objetivo, la tesis se organiza de la siguiente forma:

- Capítulo 2: Fundamentos teóricos

  Se establecen las bases conceptuales y metemáticas necesarias para comprender el modelo. Inicia con la teoría de interacción luz-materia, que abarca aproximaciones semiclásicas bajo RWA y la cuantización del campo mediante el modelo de Jaynes-Cummings. Se tratan despúes los fenómenos que surgen al combinar estas dos teorías usando átomos de tres niveles, tales como la creación de _dressed states_ y EIT. Luego, como los sistemas no están aislados, se introduce al operador densidad para describir sistemas fuera del equilibrio y estados mezcla, indispensable para tratar la ecuación maestra de Lindblad, que incorpora operadores de salto que modelan los procesos irreversibles como la emisión espontánea y la pérdida de fotones. Finalmente, se exponen las propiedades de los átomos de Rydberg y sus procesos de interacción interatómica que dan origen al bloqueo.

- Capítulo 3: Formulación del sistema

  Se hace una descripción del modelo físico central de la tesis: dos átomos de cuatro niveles en configuración cascada acoplados a una cavidad óptica. Se detallan las transiciones permitidas y se construye el Hamiltoniano total en el marco rotante, incluyendo los términos de acoplamiento, intensidad de los láseres externos y de interacción interatómica. Además, se describe la metodología numérica para resolver la ecuación de Lindblad, haciendo uso de la paquetería OpenKet para la resolución de las EDOs y la definición de los observables físicos.

- Capítulo 4: Dinámica de los sistemas base

  Antes de discutir el modelo principal, en este capítulo se aíslan y analizan los subsistemas necesarios para construir intuición física. Se estudia la dinámica de las oscilaciones de Rabi en un átomo de dos niveles y la espectroscopía de una cavidad vacía con disipación, se analiza la aparición de fenómenos de interferencia cuántica como el desdoblamiento _Vaccum Rabi_ y EIT, y se desarrolla e implementa la técnica de reducción adiabática del estado intermedio, analizando sus consecuencias espectales, tales como corrimientos Stark.

- Capítulo 5: Excitación colectiva y bloqueo de Rydberg

  En este capítulo se presentan los resultados principales de la tesis, diviendo el análisis en dos partes. En la primera, se asume que los átomos están espacialmente separados y no presentan interacciones entre ellos, provocando efectos de formación de estados de Dicke. En la segunda, se agrega la interacción dipolo-dipolo de Rydberg, mediante la resonancia de Föster, para observar la anulación de la probabilidad de doble excitación. Se analiza la forma en que esta repulsión genera una DIET y altera el espectro de transmisión de la cavidad.

- Capítulo 6: Conclusiones

  Finalmente, se presentan los resultados más relevantes obtenidos a lo largo de la investigación.