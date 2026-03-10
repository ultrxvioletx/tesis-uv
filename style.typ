// style.typ
#import "@preview/chic-hdr:0.5.0": * //encabezado y pie de página
#import "@preview/equate:0.3.2": equate //sub-ecuaciones numeradas
#import "@preview/cetz:0.4.1" //drawing
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge //diagramas con flechas
#import "@preview/i-figured:0.2.4" //numeración de ecuaciones y figuras
#import "@preview/physica:0.9.8": * //sintáxis matemática
#import "@preview/quick-maths:0.2.1": shorthands //shorthands de escritura de ecuaciones
#import "@preview/super-suboptimal:0.1.0": * //lectura de sub y superindies unicode

// ESTADOS GLOBALES
#let in-appendix = state("in-appendix", false)
#let show-headers = state("show-headers", false)
#let global-chapter = counter("global-chapter")

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
  title: "Tesis",
  author: "Andrea Rodríguez",
  lang: "es",
  paper: "a4",
  fontsize: 11pt,
  captionfontsize: 10pt,
  binding-correction: 5mm,
  body-font: "Iwona",
  sans-font: "FreeMono",
  mono-font: "B612 Mono",
) = {
  return (doc) => {
    set document(
      title: title,
      author: author,
    )
    // COLORES
    let colors = (
      semi-gray: rgb("#8C8C8C"), // gray 0.55
      title: rgb("#990000"),     // Maroon
      link: rgb("#0000CD"),      // RoyalBlue
      citation: rgb("#008000"),  // WebGreen
      url: rgb("#990000"),       // Maroon
    )
    // MÁRGENES
    set page(
      paper: paper,
      margin: (
        top: 2.5cm,
        bottom: 2.5cm,
        inside: 2.5cm + binding-correction,
        outside: 3.5cm,
      )
    )
    // TIPOGRAFÍA
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
    // ENCABEZADOS
    set heading(numbering: (..nums) => {
      let nums = nums.pos()
      if nums.len() == 1 {
        numbering("I", nums.at(0))
      } else if nums.len() == 2 {
        str(global-chapter.get().first())
      } else if nums.len() == 3 {
        numbering("1.1.", global-chapter.get().first(), nums.at(2))
      } else if nums.len() == 4 {
        numbering("1.1.1.", global-chapter.get().first(), nums.at(2), nums.at(3))
      } else if nums.len() == 5 {
        numbering("1.1.1.a ", global-chapter.get().first(), nums.at(2), nums.at(3), nums.at(4))
      }
    })
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

    let spaced-caps(it) = upper(text(tracking: 0.1em, it))
    let spaced-smallcaps(it) = smallcaps(text(tracking: 0.03em, it))
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
      // incrementa el contador global de capítulos
      global-chapter.step()
      // reinicia contadores al cambiar de capítulo
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(figure.where(kind: raw)).update(0)
      pagebreak()
      if not in-appendix.get() {
        block(
          width: 100%,
          inset: 0pt,
          grid(
            columns: (30pt, 10pt, auto),
            stroke: none,
            gutter: 15pt,
            [#text(size: 3em, fill: colors.semi-gray, weight: "bold", str(global-chapter.get().first()))],
            [#line(length: 2.7em, angle: 90deg, stroke: 0.5pt + colors.semi-gray)],
            [#spaced-caps(it.body)],
          )
        )
        v(3em)
      } else {
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
      spaced-smallcaps(text(size: 1.4em, it.body))
      v(0.8em)
    }
    // Estilo de SUBSECCIONES
    show heading.where(level: 4): it => {
      v(1.2em)
      context counter(heading).display(heading.numbering)
      text(style: "italic", size: 1.1em, it.body)
      v(0.6em)
    }
    // Estilo de SUBSUBSECCIONES
    show heading.where(level: 5): it => {
      v(1em)
      context counter(heading).display(heading.numbering)
      text(style: "oblique", weight: "regular", size: 1em, it.body)
      v(0.6em)
    }

    // ÍNDICE
    show outline: it => {
      v(1em)
      text(size: 2em, "Índice general")
      v(1em)
      it
    }
    show outline.entry.where(level: 1): it => { spaced-smallcaps(it) }
    //para indice de figuras, ecuaciones y tablas, recuerda usar el paquete i-figured
    
    // BIBLIOGRAFÍA
    show bibliography: set text(size: 10pt) // Letra un poco más pequeña
    
    // REFERENCIAS Y ENLACES
    show link: it => text(fill: colors.link, it.body)
    // show cite: it => link(it.target, "[" + it.content + "]")

    // ECUACIONES
    set math.equation(numbering: (..num) => {
      numbering("(1.1)", global-chapter.get().first(), num.pos().first())
    })
    show: super-subscripts //lee unicode para superindices y subindices
    show: shorthands.with(
      ($+-$, $plus.minus$),
      ($-+$, $minus.plus$),
      ($**$, $times.o$),
    )

    // FIGURAS
    show figure: it => {
      align(center, it.body)
      set par(first-line-indent: 0pt)
      align(
        left,
        pad(
          x: 2cm,
          strong(text(size: captionfontsize, it.caption))
        )
      )
    }
    set figure(numbering: (..num) =>{
      numbering("1.1", global-chapter.get().first(), num.pos().first())
    })
    set figure.caption(
      separator: parbreak()
    )
    
    // CÓDIGO
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