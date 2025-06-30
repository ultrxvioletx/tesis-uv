// ===================================================================
// main.typ: Archivo principal
// ===================================================================

#import "style.typ": style, appendix

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
  depth: 2,
)

// --- Cuerpo Principal ---
// #state("show-headers").update(true)


= Preparación teórica
#include "capitulos/capitulo01.typ"
#include "capitulos/capitulo02.typ"
#include "capitulos/capitulo03.typ"




// --- Apéndice ---
// #appendix // Esto cambia el estilo de los capítulos siguientes.
// #include "capitulos/appendix-a.typ"


// --- Bibliografía ---
#bibliography(
  "references.bib",
  title: "Bibliografía",
)