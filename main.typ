// ===================================================================
// main.typ: Archivo principal
// ===================================================================

#import "style.typ": *

#show: style(
  lang: "es",
)

#include "body/cover.typ"
#include "body/abstract.typ"
#include "body/agradecimientos.typ"

// Índice
#outline(
  title: none,
  depth: 4,
  target: heading,
)
#include "body/glosario.typ"

// Cuerpo principal

== Introducción
#include "capitulos/01_introduccion.typ"

== Fundamentos teóricos <cap:teoría>
#include "capitulos/02_luz_materia.typ"
#include "capitulos/02_operador_densidad.typ"
#include "capitulos/02_bloqueo_rydberg.typ"


== Formulación del sistema
#include "capitulos/03_descripcion_sistema.typ"
#include "capitulos/03_implem_numerica.typ"


== Dinámica de los sistemas base
#include "capitulos/04_sistemas_base.typ"
#include "capitulos/04_1at3lvl.typ"
#include "capitulos/04_elim_adiabatica.typ"


== Excitación colectiva y bloqueo de Rydberg <cap:bloqueo>
#include "capitulos/05_2at4lvl_independientes.typ"
#include "capitulos/05_2at4lvl_bloqueo.typ"

== Conclusiones
#include "capitulos/06_conclusiones.typ"

// --- Apéndice ---
#appendix() // cambia el estilo de los capítulos siguientes.
#include "capitulos/A_codigos.typ"


// --- Bibliografía ---
#bibliography(
  "references.bib",
  title: "Bibliografía"
)