// style.typ
#import "@preview/numbly:0.1.0": numbly
#import "@preview/chic-hdr:0.5.0": *

// --- ESTADOS GLOBALES ---
#let in-appendix = state("in-appendix", false)
#let show-headers = state("show-headers", false)


// --- FUNCIONES EXPORTABLES ---
#let appendix() = {
  in-appendix.update(true)
  set heading(numbering: "A")
  counter(heading).update(1)
}

// Función principal que encapsula y aplica todo el estilo.
#let style(
  title: "Sin Título",
  author: "Anónimo",
  lang: "es",
  paper: "a4",
  fontsize: 11pt,
  binding-correction: 5mm,
  body-font: "Iwona",
  sans-font: "FreeMono",
  mono-font: "B612 Mono",
) = {
  return (doc) => {

    // --- Configuración del Documento Base ---
    set document(
      title: title,
      author: author,
    )
    // --- Colores ---
    let colors = (
      semi-gray: rgb("#8C8C8C"), // gray 0.55
      title: rgb("#990000"),     // Maroon
      link: rgb("#0000CD"),      // RoyalBlue
      citation: rgb("#008000"),  // WebGreen
      url: rgb("#990000"),       // Maroon
    )

    // --- Geometría y Márgenes de Página ---
    set page(
      paper: paper,
      margin: (
        top: 2.5cm,
        bottom: 2.5cm,
        inside: 2.5cm + binding-correction,
        outside: 3.5cm,
      ),
      // // Cabecera
      // header: context {
      //   // No mostrar nada si es una página de "Parte"
      //   locate(loc => {
      //     let part-headings = query(heading.where(level: 1, outlined: false).at(loc))
      //     if part-headings.len() > 0 {
      //       return // No mostrar cabecera en páginas de "Parte"
      //     }
      //     if show-headers.get() {
      //       align(right, text(size: 9pt)[
      //         #locate(loc => {
      //           let active = query(heading.where(level: 2), loc).last()
      //           if active != none {
      //             spaced-smallcaps(active.body)
      //           }
      //         })
      //         #h(1em)
      //         #line(length: 1.5em, angle: 90deg, stroke: 0.5pt + colors.semi-gray)
      //         #h(1em)
      //         #counter(page).display()
      //       ])
      //     }
      //   })
      // },
      // // Pie de pagina
      // footer: context {
        
      // },
    )

    // --- Tipografía ---
    set text(
      font: body-font,
      size: fontsize,
      lang: lang,
    )
    set par(
      leading: 0.65em,
      first-line-indent: 1.2em,
      justify: true,
    )
    // show par: it => {
    //   if it.text.len() < 40 { it }
    //   else { block(breakable: true, tight: false, it) }
    // }


    // --- Estilos de Encabezados (Capítulos, Secciones...) ---
    set figure(numbering: "1.1")
    set heading(numbering: numbly(
      "{1:I}",
      "{2:1}",
      "{2:1}.{3:1}. ",
      "{2:1}.{3:1}.{4:1}. "
    ))
    let spaced-caps(it) = upper(text(tracking: 0.1em, it))
    let spaced-smallcaps(it) = smallcaps(text(tracking: 0.03em, it))

    show: chic.with(
      chic-height(2.5cm),
      chic-offset(30pt),
      skip: (3,),
      chic-header(
        side-width: (auto,380pt,20pt),
        center-side: align(right, chic-heading-name()),
        right-side: chic-page-number()
      )
    )

    // Estilo de PARTE
    show heading.where(level: 1): it => {
      pagebreak()
      align(center)[
        #text(1.2em, "Parte " + counter(heading).display())
        #v(1em)
        #text(2.5em, fill: colors.title, spaced-caps(it.body))
      ]
    }
    // Estilo de CAPITULOS
    show heading.where(level: 2): it => {
      pagebreak()
      if not in-appendix.get() {
        block(
          width: 100%,
          inset: 0pt,
          grid(
            columns: (30pt, 10pt, auto),
            stroke: none,
            gutter: 15pt,
            [#text(size: 3em, fill: colors.semi-gray, weight: "bold", counter(heading).display())],
            [#line(length: 2.7em, angle: 90deg, stroke: 0.5pt + colors.semi-gray)],
            [#spaced-caps(it.body)],
          )
        )
        v(3em)
      // Estilo de APÉNDICE
      } else {
        pagebreak()
        align(center, text(size: 2em, weight: "bold", [
          Apéndice #counter(heading).display("A"): #it.body
        ]))
        v(2em)
      }
    }
    // Estilo de SECCIÓN
    show heading.where(level: 3): it => {
      v(1.5em)
      context counter(heading).display(heading.numbering)
      spaced-smallcaps(text(size: 1.2em, it.body))
      v(0.8em)
    }
    // Estilo de SUBSECCIONES
    show heading.where(level: 4): it => {
      v(1.2em)
      context counter(heading).display(heading.numbering)
      text(style: "italic", size: 1.1em, it.body)
      v(0.6em)
    }

    // --- Tabla de Contenidos (Índice) ---
    show outline: it => {
      v(1em)
      text(size: 2em, "Índice general")
      v(1em)
      it
    }
    show outline.entry.where(level: 1): it => { spaced-smallcaps(it) }
    
    // --- Bibliografía ---
    show bibliography: set text(size: 10pt) // Letra un poco más pequeña
    
    // --- Enlaces y Referencias ---
    show link: it => text(fill: colors.link, it.body)
    show cite: it => link(it.target, "[" + it.content + "]")

    // --- Listados de Código ---
    show raw.where(lang: "tex"): it => block(
      fill: luma(245), // Fondo gris claro
      inset: 10pt,
      radius: 4pt,
      width: 100%,
      text(font: mono-font, size: 9pt, it),
    )

    // RENDERIZADO
    doc
  }
}