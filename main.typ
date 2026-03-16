// ===================================================================
// main.typ: Archivo principal
// ===================================================================

#import "style.typ": *

#show: style(
  lang: "es",
)

// --- Materia Preliminar ---
// #include "front-matter/titlepage.typ"
// #include "front-matter/dedication.typ"
// #include "front-matter/abstract.typ"

#align(center)[
  #text(2.5em, "Átomos de Rydberg interactuando dentro de una cavidad óptica")
  #v(2cm)
  #text(1.5em, "Andrea Fernanda Rodríguez Rojas")
  #v(8cm)
  "Universidad Nacional Autónoma de México"
]
#pagebreak()

// Tabla de Contenidos (Índice)
#outline(
  title: none,
  depth: 4,
)

// --- Cuerpo Principal ---
// #state("show-headers").update(true)

= Átomos, luz y cavidades ópticas

== Introducción
#include "capitulos/01_introduccion.typ"

== Fundamentos teóricos
  === Interacción luz-materia
    ==== Átomo de dos niveles y la aproximación de onda rotante (RWA)
    ==== Cuantización del campo: Modelo de Jaynes-Cummings
  === Entornos disipativos
    ==== Operador densidad y pérdida de coherencia
    ==== Ecuación maestra de Lindblad
  === Interacciones de largo alcance
    ==== Átomos de cuatro niveles en configuración cascada
    ==== Fenómeno de bloqueo de excitación

= Modelado computacional y herramientas de simulación

== Formulación del sistema: dos átomos de Rydberg dentro de una cavidad óptica
#include "capitulos/03_descripcion_sistema.typ"
#include "capitulos/03_implem_numerica.typ"


= Resultados y análisis

== Calibración del modelo y dinámica de sistemas de referencia
  === Validación con sistemas fundamentales
    ==== Oscilaciones de Rabi en un átomo de dos niveles
    ==== Inyección y disipación de fotones en una cavidad vacía
  === Exploración de un átomo de cuatro niveles
    ==== Respuesta del sistema ante el barrido de desintonía (detuning)
    ==== Efectos del láser de control en las poblaciones atómicas

== Bloqueo y reducción dimensional del sistema
  === Dinámica acoplada de dos átomos de cuatro niveles
    ==== Evolución temporal de las poblaciones conjuntas
    ==== Comportamiento del campo intracavidad ante la presencia de dos átomos
  === Evidencia del bloqueo de excitación
    ==== Supresión de los estados doblemente excitados ($|s,s>$, $|p,p>$)
    ==== El rol de las interacciones $H_(e e)$ y $H_(d r)$
  === Comportamiento colectivo efectivo
    ==== Comparativa entre el ensamble interactuante y un átomo de dos niveles
    ==== Discusión física de la reducción del espacio de Hilbert

== Conclusiones y perspectivas
  === Síntesis de resultados y el éxito de la simulación
  === Implicaciones físicas del bloqueo en sistemas multinivel
  === Trabajo futuro y posibles extensiones del modelo

// --- Apéndice ---
// #appendix // Esto cambia el estilo de los capítulos siguientes.
// #include "capitulos/appendix-a.typ"


// --- Bibliografía ---
#bibliography(
  "references.bib",
  title: "Bibliografía"
)