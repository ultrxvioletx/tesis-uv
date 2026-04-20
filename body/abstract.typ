// ===================================================================
// abstract.typ
// ===================================================================
#import "../style.typ": *

#heading(level: 2, outlined: false, numbering: none)[Resumen]


Esta tesis presenta el estudio teórico y numérico de la dinámica cuántica de dos átomos de Rydberg de cuatro niveles (en configuración cascada) interactuando dentro de una cavidad óptica disipativa y excitados por campos láser externos. El objetivo principal es explorar la combinación de electrodinámica cuántica de cavidades (CQED) e interacciones de los átomos de Rydberg para analizar cómo la interacción interatómica condiciona las poblaciones de los estados excitados y altera la respuesta óptica en la cavidad. Para ello, la evolución del sistema abierto se modela a través de la ecuación maestra de Lindblad, que es implementada numéricamente usando OpenKet.

Para no perder la coherencia cuántica a través del decaimiento del nivel intermedio, se reduce el modelo a un sistema efectivo de dos niveles a través de la reducción adiabática, a precio de obtener corrimientos asimétricos que modifican en el espectro de transmisión. El análisis muestra que, en ausencia de interacciones interatómicas, el sistema tiene un comportamiento dado por los estados de Dicke debido a la interacción con el campo de la cavidad. Al activar la interacción dipolo-dipolo mediante resonancia de Föster, se presenta una anulación de la probabilidad de excitación doble, que obliga al par de electrones a comportarse como un súper-átomo que comparte una sola excitación.