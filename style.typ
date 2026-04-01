// style.typ
#import "@preview/chic-hdr:0.5.0": * //encabezado y pie de página
#import "@preview/equate:0.3.2": equate //sub-ecuaciones numeradas
#import "@preview/cetz:0.4.1" //drawing
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge //diagramas con flechas
#import "@preview/i-figured:0.2.4" //numeración de ecuaciones y figuras
#import "@preview/physica:0.9.8": * //sintáxis matemática
#import "@preview/quick-maths:0.2.1": shorthands //shorthands de escritura de ecuaciones
#import "@preview/super-suboptimal:0.1.0": * //lectura de sub y superindies unicode

// COLORES
#let colors = (
  title: rgb("#CFB1B7"), //cotton rose
  citation: rgb("#9490a2"), //lavender gray
  link: rgb("#152b42"), //deep space blue
  url: rgb("#c9b7ad"), //almond
  diagrams: rgb("#94a89a"), //verde
)

// ESTADOS GLOBALES
#let in-appendix = state("in-appendix", false)
#let show-headers = state("show-headers", false)
#let global-chapter = counter("global-chapter")

// EXPRESIONES MATEMÁTICAS COMÚNES
// operadores
#let Ha = $hat(H)_"atomos"$ //hamiltoniano atomos
#let Hb = $hat(H)_"bombeo"$ //hamiltoniano bombeo
#let Hc = $hat(H)_"cavidad"$ //hamiltoniano cavidad
#let Hi = $hat(H)_"interaccion"$ //hamiltoniano interaccion
#let Hdr = $hat(H)_"DR"$ //hamiltoniano dipolo resonante
#let Hee = $hat(H)_"EE"$ //hamiltoniano estados excitados
#let cre = $hat(a)^dagger$ //creacion
#let anh = $hat(a)$ //aniquilacion
#let NN = $hat(N)$ //numero
#let rr = $hat(rho)$ //operador densidad
#let sigk(ii,jj,at) = $sigma_(ii jj)^((at))$ //sigma
#let sig(ii,jj) = $sigma_(ii jj)$ //sigma
#let PP = $cal(P)$ //probabilidad
// otros
#let HH = $cal(H)$ //espacio de hilbert
#let HHc = $cal(H)_"cavidad"$ //hilbert cavidad
#let HHa1 = $cal(H)_"átomo1"$ //hilbert cavidad
#let HHa2 = $cal(H)_"átomo2"$ //hilbert cavidad
#let LL = $cal(L)$ //lindblad
#let OO = $cal(hat(O))$ //operador arbitrario
#let tr = $"Tr"$ //formato traza
#let Nexp = $expval(N)$ //valor medio fotones
#let Nss = $expval(N)_"ss"$ //valor medio fotones estado estacionario
// kets
#let kg = $ket(g)$ //g
#let ke = $ket(e)$ //e
#let ks = $ket(s)$ //s
#let kp = $ket(p)$ //p
// parámetros
#let nmax = $N_"max"$ //truncamiento base Fock
#let wp = $omega_p$ //frecuencia prueba
#let wc = $omega_c$ //frecuencia control
#let weg = $omega_(e g)$ //distancia eg
#let wse = $omega_(s e)$ //distancia se
#let wps = $omega_(p s)$ //distancia ps
#let dece = $gamma_e$ //decaimiento e->g
#let decs = $gamma_s$ //decaimiento s->e
#let dec12 = $gamma_(12)$ //decaimiento colectivo
#let rabip = $Omega_p$ //rabi prueba
#let rabic = $Omega_c$ //rabi control
#let rabir = $Omega_R$ //rabi generalizada
#let rabieff = $Omega_"eff"$ //rabi efectiva
#let scan = $delta_p$ //delta scan
#let Dpa = $Delta_(p)$ //detuning prueba-atomo
#let Dac = $Delta_(c)$ //detuning atomo-control
#let geff = $g_"eff"$ //rabi generalizada
#let Odr = $Omega_"12"$ //intensidad dipolo resonante
#let Oee = $C_3$ //intensidad estado excitado
#let sg = $S_g$ //stark |g>
#let ss = $S_s$ //stark |s>
#let d1 = $d_"1at"$ //distancia 1at
#let d2 = $d_"2at"$ //distancia 2at
#let d2b = $d_"bloqueo"$ //distancia bloqueo
// funciones
#let sim = $dash.wave$
#let vecop(it) = math.upright(math.bold(math.hat(it)))
#let vecb(it) = math.upright(math.bold(it))

// FUNCIONES DE ESTILO
#let diagrama(..args) = {
  //show math.equation: set text(fill: colors.diagrams)
  //show text: set text(fill: colors.diagrams)
  diagram(
    node-fill: none,
    node-stroke: none,
    edge-stroke: colors.diagrams,
    ..args
)}
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
  captionfontsize: 9pt,
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
    //ESTILO DE ENUMERACIÓN
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
    // ENCABEZADOS Y NÚMERO DE PÁGINA
    show: chic.with(
      chic-height(2.5cm),
      chic-offset(30pt),
      skip: (3,),
      chic-header(
        side-width: (auto,380pt,20pt),
        center-side: align(right, context {
          let current = query(heading.where(level: 2))
            .filter(h => h.location().page() == here().page())
          if current.len() > 0 {
            current.first().body
          } else {
            chic-heading-name(level: 2, dir: "prev", fill: false)
          }
        }),
        right-side: chic-page-number()
      )
    )

    let spaced-caps(it) = upper(
      par(
        leading: 1em,
        justify: false,
        text(
          hyphenate: false,
          size:1em,
          tracking: 0.1em,
          it)
      ))
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
    show heading.where(level: 2): set heading(supplement: "Capítulo")
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
            columns: (70pt, 10pt, 1fr),
            stroke: none,
            gutter: 25pt,
            [#text(size: 10em, fill: colors.title, weight: "bold", str(global-chapter.get().first()))],
            [#line(length: 7em, angle: 90deg, stroke: 1pt + colors.title)],
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
      h(0.5em)
      spaced-smallcaps(text(size: 1.4em, it.body))
      v(0.8em)
    }
    // Estilo de SUBSECCIONES
    show heading.where(level: 4): it => {
      v(1.2em)
      context counter(heading).display(heading.numbering)
      h(0.5em)
      text(style: "italic", size: 1.1em, it.body)
      v(0.6em)
    }
    // Estilo de SUBSUBSECCIONES
    show heading.where(level: 5): it => {
      v(1em)
      context counter(heading).display(heading.numbering)
      h(0.5em)
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
    show outline.entry.where(level: 5): it => none
    show outline.entry.where(level: 4): it => {
      it
      context {
        let current-loc = it.element.location()
        let all-lvl5 = query(heading.where(level: 5))
        let all-lvl4 = query(heading.where(level: 4))
        // encuentra el siguiente heading de nivel 4 después del actual
        let next-lvl4 = all-lvl4.find(h => h.location().position().y > current-loc.position().y and h.location().page() >= current-loc.page() or h.location().page() > current-loc.page()
        )
        // filtra los lvl5 que pertenecen a este lvl4
        let children = all-lvl5.filter(h => {
          let after-current = h.location().page() > current-loc.page() or (h.location().page() == current-loc.page() and h.location().position().y > current-loc.position().y)
          let before-next = next-lvl4 == none or h.location().page() < next-lvl4.location().page() or (h.location().page() == next-lvl4.location().page() and h.location().position().y < next-lvl4.location().position().y)
          after-current and before-next
        })
        if children.len() > 0 {
          block(
            inset: (left: 4em),
            above: 0.7em,
            below: 0.5em,
            text(size: 0.85em, fill: luma(80), style: "italic", children.map(h => h.body).join([, ]))
          )
        }
      }
    }
    //para indice de figuras, ecuaciones y tablas, recuerda usar el paquete i-figured
    
    // BIBLIOGRAFÍA
    show bibliography: set text(size: 10pt) // Letra un poco más pequeña
    
    // REFERENCIAS Y ENLACES
    show link: it => text(fill: colors.link, it.body)
    // show cite: it => link(it.target, "[" + it.content + "]")

    // ECUACIONES
    show math.equation.where(block: false): it => box(it)
    set math.equation(
      supplement: "ec.",
      numbering: (..num) => {
        numbering("1.1", global-chapter.get().first(), num.pos().first())
    })
    show: super-subscripts //lee unicode para superindices y subindices
    show: shorthands.with(
      ($+-$, $plus.minus$),
      ($-+$, $minus.plus$),
      ($**$, $times.o$),
    )

    // FIGURAS
    set figure(
      supplement: "Fig.",
      numbering: (..num) =>{
        numbering("1.1", global-chapter.get().first(), num.pos().first())
    })
    set figure.caption(
      separator: parbreak()
    )
    show figure: it => {
      set par(first-line-indent: 0pt)
      v(1.5em)
      block(
        width: 100% + 0.5cm,
        outset: (right: 0.5cm),
        grid(
          columns: (1fr, 0.55fr),
          column-gutter: 0.8em,
          align: (top, top),
          align(center, it.body),
          align(left, text(size: captionfontsize, it.caption)),
        ),
      )
      v(1em)
    }
    show figure.caption: it => {
      strong(it.supplement + [ ] + context it.counter.display(it.numbering))
      it.separator
      it.body
    }
        
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