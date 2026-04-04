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

== Introducción
#include "capitulos/01_introduccion.typ"

== Fundamentos teóricos <cap:teoría>
#include "capitulos/02_luz_materia.typ" 
#include "capitulos/02_atomo3lvl.typ"
  === Entornos disipativos
    ==== Operador densidad y pérdida de coherencia
    ==== Ecuación maestra de Lindblad
  === Interacciones interatómicas y bloqueo de Rydberg


== Formulación del sistema
#include "capitulos/03_descripcion_sistema.typ"
#include "capitulos/03_implem_numerica.typ"


== Dinámica de la base constructiva
#include "capitulos/04_validacion.typ"
=== Múltiples átomos en la cavidad
#include "capitulos/04_1at3lvl.typ"
#include "capitulos/04_elim_adiabatica.typ"


== Excitación colectiva y bloqueo de Rydberg <cap:bloqueo>
#include "capitulos/05_2at4lvl_independientes.typ"
#include "capitulos/05_2at4lvl_bloqueo.typ"
==== Amplificación de acoplamiento provocada por interacciones

== Conclusiones

// --- Apéndice ---
// #appendix // Esto cambia el estilo de los capítulos siguientes.
// #include "capitulos/appendix-a.typ"


// --- Bibliografía ---
#bibliography(
  "references.bib",
  title: "Bibliografía"
)