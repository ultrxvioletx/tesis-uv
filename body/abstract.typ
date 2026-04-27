// ===================================================================
// abstract.typ
// ===================================================================
#import "../style.typ": *

#set text(size: 10pt)
#set par(first-line-indent: 0pt, justify: true)


#heading(level: 2, outlined: false, numbering: none)[Resumen]
#align(center)[
Esta tesis presenta el estudio teórico y numérico de la dinámica cuántica de dos átomos de Rydberg de cuatro niveles en configuración cascada interactuando dentro de una cavidad óptica disipativa y excitados por campos láser externos. El objetivo principal es explorar la combinación de electrodinámica cuántica de cavidades (CQED) e interacciones de los átomos de Rydberg para analizar cómo la interacción interatómica condiciona las poblaciones de los estados excitados y altera la respuesta óptica en la cavidad. Para ello, la evolución del sistema abierto se modela a través de la ecuación maestra de Lindblad, que es implementada numéricamente usando OpenKet.

Para no perder la coherencia cuántica a través del decaimiento del nivel intermedio, se reduce el modelo a un sistema efectivo de dos niveles a través de la reducción adiabática, a precio de obtener corrimientos asimétricos que modifican en el espectro de transmisión. El análisis muestra que, en ausencia de interacciones interatómicas, el sistema tiene un comportamiento dado por los estados de Dicke debido a la interacción con el campo de la cavidad. Al activar la interacción dipolo-dipolo mediante resonancia de Föster, se presenta una anulación de la probabilidad de excitación doble, que obliga al par de electrones a comportarse como un superátomo que comparte una sola excitación. Los efectos del bloqueo de Rydberg se manifiestan también en el espectro de transmisión del sistema, provocando una saturación cuántica en la cavidad. Los resultados obtenidos muestran que la relación entre CQED y las interacciones de Rydberg forman una fuerte herramienta para el control coherente de la luz y la materia.]

#v(5em)

#heading(level: 2, outlined: false, numbering: none)[Abstract]
#align(center)[
This thesis presents the theoretical and numerical study of the quantum dynamics of two four-level Rydberg atoms in cascade configuration interacting inside a dissipative optical cavity and excited by external laser fields. The main objective is to explore the combination of cavity quantum electrodynamics (CQED) and Rydberg atom interactions to analyze how the interatomic interaction conditions the populations of the excited states and alters the optical response in the cavity. To this end, the evolution of the open system is modeled through the Lindblad master equation, which is numerically implemented using OpenKet.

To preserve quantum coherence against decay of the intermediate level, the model is reduced to an effective two-level system through adiabatic elimination, at the cost of obtaining asymmetric shifts that modify the transmission spectrum. The analysis shows that, in the absence of interatomic interactions, the system exhibits behavior governed by Dicke states due to the interaction with the cavity field. Upon activating the dipole-dipole interaction through Föster resonance, a suppression of the double excitation probability arises, forcing the pair of atoms to behave as a superatom sharing a single excitation. The effects of Rydberg blockade also manifest in the transmission spectrum of the system, inducing quantum saturation in the cavity. The results obtained show that the interplay between CQED and Rydberg interactions constitutes a powerful tool for the coherent control of light and matter.]