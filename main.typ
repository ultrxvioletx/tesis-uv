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
  #text(2.5em, "Átomos de Rydberg interacuando dentro de una cavidad óptica")
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


= Herramientas y fundamentos teóricos

#include "capitulos/01_introduccion.typ"

#include "capitulos/02_introduccion.typ"
#include "capitulos/02_operador_densidad.typ"
#include "capitulos/02_lindblad.typ"

= Interacción átomo-luz
#include "capitulos/03_introduccion.typ"
#include "capitulos/03_atomo_libre.typ"
#include "capitulos/03_atomo_campo.typ"
#include "capitulos/03_decaimiento_espontaneo.typ"
#include "capitulos/03_simulacion.typ"

#include "capitulos/04_introduccion.typ"
#include "capitulos/04_cuantizacion_campo.typ"
#include "capitulos/04_oscilador_armonico.typ"
#include "capitulos/04_cavidad_abierta.typ"
#include "capitulos/04_simulacion.typ"

#include "capitulos/05_introduccion.typ"
#include "capitulos/05_jaynes-cummings.typ"


// --- Apéndice ---
// #appendix // Esto cambia el estilo de los capítulos siguientes.
// #include "capitulos/appendix-a.typ"


// --- Bibliografía ---
#bibliography(
  "references.bib",
  title: "Bibliografía"
)