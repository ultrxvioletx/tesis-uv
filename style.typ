// style.typ
#import "@preview/chic-hdr:0.5.0": * //encabezado y pie de página
#import "@preview/equate:0.3.2": equate //sub-ecuaciones numeradas
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge //diagramas con flechas
#import "@preview/i-figured:0.2.4" //numeración de ecuaciones y figuras
#import "@preview/numbly:0.1.0": numbly //numeración de encabezados
#import "@preview/physica:0.9.5": * //sintáxis matemática
#import "@preview/quick-maths:0.2.1": shorthands //shorthands de escritura de ecuaciones
#import "@preview/super-suboptimal:0.1.0": * //lectura de sub y superindies unicode

// ESTADOS GLOBALES
#let in-appendix = state("in-appendix", false)
#let show-headers = state("show-headers", false)

#let vecop(it) = math.upright(math.bold(math.hat(it)))
#let vecb(it) = math.upright(math.bold(it))

// FUNCIONES EXPORTABLES
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
    // --- Márgenes ---
    set page(
      paper: paper,
      margin: (
        top: 2.5cm,
        bottom: 2.5cm,
        inside: 2.5cm + binding-correction,
        outside: 3.5cm,
      )
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
    // --- Encabezados ---
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
    // --- Índices ---
    show outline: it => {
      v(1em)
      text(size: 2em, "Índice general")
      v(1em)
      it
    }
    show outline.entry.where(level: 1): it => { spaced-smallcaps(it) }
    //para indice de figuras, ecuaciones y tablas, recuerda usar el paquete i-figured
    
    // --- Bibliografía ---
    show bibliography: set text(size: 10pt) // Letra un poco más pequeña
    
    // --- Enlaces y Referencias ---
    show link: it => text(fill: colors.link, it.body)
    // show cite: it => link(it.target, "[" + it.content + "]")

    // --- Ecuaciones y figuras ---
    set math.equation(numbering: "(1.1)", supplement: [])
    set figure(numbering: "1.1")
    show: super-subscripts //lee unicode para superindices y subindices
    show: shorthands.with(
      ($+-$, $plus.minus$),
      ($-+$, $minus.plus$),
    )
    // show math.equation: i-figured.show-equation
    show heading.where(level: 2): it => {
      counter(math.equation).update(0)
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(figure.where(kind: raw)).update(0)
      it
    }
    set math.equation(numbering: (..num) =>{
      let heading_nums = counter(heading).get()
      if heading_nums.len() > 1{
        numbering("(1.1)", counter(heading).get().at(1), num.pos().first())
      } else{
        numbering("(1.1)", counter(heading).get().first(), num.pos().first())
      }
    })
    set figure(numbering: (..num) =>{
      let heading_nums = counter(heading).get()
      if heading_nums.len() > 1{
        numbering("(1.1)", counter(heading).get().at(1), num.pos().first())
      } else{
        numbering("(1.1)", counter(heading).get().first(), num.pos().first())
      }
    })

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