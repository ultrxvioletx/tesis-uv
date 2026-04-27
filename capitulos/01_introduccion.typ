// ===================================================================
// 01_introduccion.typ
// ===================================================================
#import "../style.typ": *


La comprensión y manipulación del mundo a escalas cuánticas ha sido una de las causas de grandes revoluciones científicas en la física moderna. Ha transformado nuestra compresión de la naturaleza al proporcionarnos una nueva forma de describir sistemas donde la teoría clásica deja de ser válida. En esta nueva visión, uno de los fundamentos más importantes para el desarrollo de tecnologías contemporáneas, tales como la información cuántica, ha sido el estudio de la coherencia y la superposición. Sin embargo, para lograrlo se requiere un control en las interacciones de los elementos que componen los sistemas cuánticos, tales como átomos y fotones.

Con esto en mente, la óptica cuántica nace como el campo de conocimiento mediante el cual se estudia la interacción entre luz y materia a un nivel meramente cuántico, donde la radiación ya no se describe únicamente como una onda clásica, sino a través de la cuantización del campo. En este contexto, la electrodinámica cuántica en cavidades (CQED) ha sido una de las teorías más exitosas para el estudio de estas interacciones. Al encerrar uno o varios átomos dentro de una cavidad óptica de alta calidad, es posible alcanzar regímenes de acoplamiento fuerte, donde un solo átomo y un solo fotón pueden intercambiar energía de manera coherente y controlada.

La motivación principal de este trabajo está en el análisis de fenómenos colectivos y cooperativos que surgen cuando múltiples átomos interactúan simultáneamente con el campo de la cavidad y entre sí. Para que esos fenómenos puedan existir, se requieren sistemas con tiempos de coherencia largos e interacciones suficientemente intensas para vencer las tasas de disipación de la interacción con el entorno. Por ello se utilizan los átomos de Rydberg (átomos excitados a estados con un número cuántico principal muy alto), que son los ideales para este propósito, pues sus momentos dipolares enormes provocan fuerzas grandes en sus interacciones interatómicas.

La combinación de CQED con átomos de Rydberg ocasiona un fenómeno cooperativo llamado bloqueo de Rydberg, mediante el cual la interacción dipolar entre dos átomos cercanos impide la doble excitación simultánea. Este comportamiento convierte al par de átomos en un superátomo efectivo que solo puede tener una sola excitación compartida, generando una no-linealidad óptica y estados entrelazados de manera controlada.

En este contexto, esta tesis tiene como objetivo principal simular y analizar la dinámica cuántica del modelo que el Dr. Asaf Paris Mandoki propone realizar experimentalmente, el cual consiste en dos átomos de cuatro niveles en configuración cascada fuertemente acoplados a una cavidad óptica y sometidos a láseres externos. Se utiliza un enfoque numérico que está fundamentado en sistemas cuánticos abiertos y la ecuación maestra de Lindblad, que se resuelve numéricamente con el lenguaje simbólico-numérico de la paquetería #link("https://github.com/pbbmx/openket")[OpenKet], y se busca explorar la transición desde una estructura en que los átomos interactúan únicamente vía la cavidad hacia uno de interacción colectiva. De esta forma, se analiza el impacto del bloqueo de Rydberg y se aplica la técnica matemática de reducción adiabática de un nivel, que en este caso es usado para conservar la coherencia.


=== Organización


Para abordar el objetivo, la tesis se organiza de la siguiente forma:

- Capítulo 2: Fundamentos teóricos

  Se estudian las bases conceptuales y matemáticas necesarias para comprender el modelo. Inicia con la teoría de interacción luz-materia, que abarca aproximaciones semiclásicas bajo RWA y la interacción del campo cuantizado con el átomo mediante el modelo de Jaynes-Cummings. Se tratan después los fenómenos que surgen al combinar estos dos enfoques usando átomos de tres niveles, tales como la creación de estados vestidos (_dressed states_) y transparencia inducida electromagnéticamente (EIT). Luego, como los sistemas no están aislados, se introduce al operador densidad para describir sistemas abiertos fuera del equilibrio y estados mezcla. El operador densidad es indispensable para tratar la ecuación maestra de Lindblad, que incorpora operadores de salto que modelan los procesos irreversibles como la emisión espontánea y la pérdida de fotones. Finalmente, se exponen las propiedades de los átomos de Rydberg y sus procesos de interacción interatómica que dan origen al bloqueo.

- Capítulo 3: Formulación del sistema

  Se hace una descripción del modelo físico central de la tesis: dos átomos de cuatro niveles en configuración cascada acoplados a una cavidad óptica. Se detallan las transiciones permitidas y se construye el Hamiltoniano total en el marco rotante, incluyendo los términos de acoplamiento, intensidad de los láseres externos y de interacción interatómica. Además, se describe la metodología numérica para resolver la ecuación de Lindblad, haciendo uso de la paquetería OpenKet para la resolución de las EDO y la definición de los observables físicos.

- Capítulo 4: Dinámica de los sistemas base

  Antes de discutir el modelo principal, en este capítulo se analizan, de manera aislada, los subsistemas necesarios para construir intuición física. Se estudia la dinámica de las oscilaciones de Rabi en un átomo de dos niveles y el espectro de una cavidad vacía con disipación. Se analiza también la aparición de fenómenos de interferencia cuántica como el desdoblamiento _Vacuum Rabi_ y EIT, y se desarrolla e implementa la técnica de reducción adiabática del estado intermedio, analizando sus consecuencias espectrales, tales como corrimientos Stark.

- Capítulo 5: Excitación colectiva y bloqueo de Rydberg

  En este capítulo se presentan los resultados principales de la tesis, dividiendo el análisis en dos partes. En la primera, se asume que los átomos están espacialmente separados y no presentan interacciones vía Rydberg entre ellos, provocando efectos de formación de estados de Dicke. En la segunda, se agrega la interacción dipolo-dipolo de Rydberg, mediante la resonancia de Föster, para observar la anulación de la probabilidad de doble excitación. Se analiza la forma en que esta repulsión genera una transparencia electromagnética inducida por dipolos (DIET) y altera el espectro de transmisión de la cavidad.

- Capítulo 6: Conclusiones

  Finalmente, se presentan los resultados más relevantes obtenidos a lo largo de la investigación.