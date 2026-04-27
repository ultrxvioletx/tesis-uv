// style.typ
#import "@preview/chic-hdr:0.5.0": * //encabezado y pie de página
#import "@preview/equate:0.3.2": equate //sub-ecuaciones numeradas
#import "@preview/cetz:0.4.1" //drawing
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge //diagramas con flechas
#import "@preview/physica:0.9.8": * //sintáxis matemática
#import "@preview/quick-maths:0.2.1": shorthands //shorthands de escritura de ecuaciones
#import "@preview/super-suboptimal:0.1.0": * //lectura de sub y superindies unicode
#import "@preview/codly:1.3.0": * //formato de código
#import "@preview/codly-languages:0.1.1": *

// COLORES
#let colors = (
  title: rgb("#CFB1B7"), //cotton rose
  ref: rgb("#CFB1B7"), //cotton rose
  link: rgb("#9490a2"), //lavender graye
  diagrams: rgb("#94a89a"), //verde
  lines: rgb("#9490a2"), //lavender gray
)

// ESTADOS GLOBALES
#let in-appendix = state("in-appendix", false)
#let show-headers = state("show-headers", false)
#let global-chapter = counter("global-chapter")

// EXPRESIONES MATEMÁTICAS COMÚNES
// operadores
#let Ha = $hat(H)_A$ //hamiltoniano atomo
#let Haa = $hat(H)_"atomos"$ //hamiltoniano atomos
#let Hb = $hat(H)_"bombeo"$ //hamiltoniano bombeo
#let Hc = $hat(H)_"cavidad"$ //hamiltoniano cavidad
#let Hca = $hat(H)_(I C)$ //hamiltoniano interaccion cavidad-atomo
#let Hla = $hat(H)_(I L)$ //hamiltoniano interaccion luz-atomo
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
#let HHa = $cal(H)_"átomo"$ //hilbert átomo
#let HHa1 = $cal(H)_"átomo1"$ //hilbert átomo 1
#let HHa2 = $cal(H)_"átomo2"$ //hilbert átomo 2
#let LL = $cal(L)$ //lindblad
#let OO = $cal(hat(O))$ //operador arbitrario
#let tr = $"Tr"$ //formato traza
#let Nexp = $expval(N)$ //valor medio fotones
#let Nss = $expval(N)_"ss"$ //valor medio fotones estado estacionario
#let Wdd = $W_(d d)$ //interacción dipolo-dipolo
// kets
#let kg = $ket(g)$ //g
#let ke = $ket(e)$ //e
#let ks = $ket(s)$ //s
#let kp = $ket(p)$ //p
#let kgg = $ket(g g)$ //gg
#let kss = $ket(s s)$ //ss
#let kpp = $ket(p p)$ //pp
#let dicke1 = $ket(Psi_+)_"Dicke"$ //superradiante
#let dicke2 = $ket(Psi_-)_"Dicke"$ //subradiante
#let fost1 = $ket(Psi_+)_"Föster"$ //interaccion
#let fost2 = $ket(Psi_-)_"Föster"$ //interaccion
// poblaciones
#let Pg = $P_g$
#let Pe = $P_e$
#let Ps = $P_s$
#let Pp = $P_p$
#let Pss = $P_(s s)$
#let P1s = $P_(g s) + P_(s g)$
// parámetros
#let nmax = $N_"max"$ //truncamiento base Fock
#let nat = $N_"at"$ //número de átomos
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
#let scan = $delta_p$ //delta scan
#let Dpa = $Delta_(p)$ //detuning prueba-atomo
#let Dac = $Delta_(c)$ //detuning atomo-control
#let Cdr = $C_3^((12))$
#let Cee = $C_3^((23))$
#let Oee = $Omega_"EE"$ //intensidad estado excitado
// variables
#let rabieff = $Omega_"eff"$ //rabi efectiva
#let geff = $g_"eff"$ //rabi generalizada
#let Deff = $Delta_"eff"$ //rabi generalizada
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
    edge-stroke: 0.6pt + colors.diagrams,
    ..args
)}
#let appendix() = {
  in-appendix.update(true)
  counter(heading).update(0)
}
// OTROS TÍTULOS
#let otrotitulo(it) = {
  align(center, text(size: 11pt, weight: "bold", fill: colors.lines, ". ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁.. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁.. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁.. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁.."))
  align(center, text(1.5em, fill: colors.title, tracking: 0.1em, upper(it)))
  v(1em)
}

// Función principal que encapsula y aplica todo el estilo.
#let style(
  title: "Tesis",
  author: "Andrea Rodríguez",
  lang: "es",
  paper: "a4",
  fontsize: 12pt,
  captionfontsize: 9pt,
  binding-correction: 5mm,
  body-font: "Iwona",
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
      skip: (1,2,3,),
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
      align(center)[
        #text(1.2em, "Parte " + counter(heading).display())
        #v(1em)
        #text(2.5em, fill: colors.title, spaced-caps(it.body))
      ]
    }
    // Estilo de CAPITULOS
    show heading.where(level: 2): set heading(supplement: "Capítulo")
    show heading.where(level: 2): it => {
      if it.numbering != none {
        // incrementa el contador global de capítulos
        global-chapter.step()
        // reinicia contadores al cambiar de capítulo
        counter(figure.where(kind: image)).update(0)
        counter(figure.where(kind: table)).update(0)
        counter(figure.where(kind: raw)).update(0)
        pagebreak()
        block(
          width: 100%,
          inset: 0pt,
          grid(
            columns: (70pt, 10pt, 1fr),
            stroke: none,
            gutter: 25pt,
            [#text(size: 10em, fill: colors.title, weight: "bold", str(global-chapter.get().first()))],
            [
              // #line(length: 5em, angle: 90deg, stroke: 1pt + colors.title)
              // #place(dx: -4pt, rotate(90deg, text(size: 10pt, fill: colors.title, " .✦♡")))
              #place(dx: -4pt, dy: 90pt, rotate(-90deg, 
                box(width: 7em, align(center,
                  text(size: 10pt, fill: colors.title, "· · ✦ · · · ✦ · · · ✦ · ·")
                ))
              ))
            ],
            [#text(size: 20pt, fill: colors.title, weight: "bold", spaced-caps(it.body))],
          )
        )
        v(3em)
      } else{
        if in-appendix.get() {
          counter(heading).step()
          pagebreak()
          block(
            width: 100%,
            inset: 0pt,
            grid(
              columns: (70pt, 10pt, 1fr),
              stroke: none,
              gutter: 25pt,
              align(center,
                text(size: 10em, fill: colors.title, weight: "bold", 
                  numbering("A", counter(heading).get().first())
                )
              ),
              [#place(dx: -4pt, dy: 90pt, rotate(-90deg,
                box(width: 7em, align(center,
                  text(size: 10pt, fill: colors.title, "· · ✦ · · · ✦ · · · ✦ · ·")
                ))
              ))],
              [#text(size: 20pt, fill: colors.title, weight: "bold", spaced-caps(it.body))],
            )
          )
          v(3em)
        } else {
          otrotitulo(it.body)
        }
      }
    }
    // Estilo de SECCIÓN
    show heading.where(level: 3): set heading(supplement: $section$)
    show heading.where(level: 3): it => {
      if it.numbering != none {
        v(1.5em)
        context counter(heading).display(heading.numbering)
        h(0.5em)
        spaced-smallcaps(text(size: 1.4em, it.body))
        v(0.8em)
      } else {
        v(0.8em)
        pad(left: 0em, align(left, spaced-smallcaps(text(size: 1.2em, it.body))))
        v(0.8em)
      }
    }
    // Estilo de SUBSECCIONES
    show heading.where(level: 4): set heading(supplement: $section$)
    show heading.where(level: 4): it => {
      v(1.2em)
      context counter(heading).display(heading.numbering)
      h(0.5em)
      text(style: "italic", size: 1.1em, it.body)
      v(0.6em)
    }
    // Estilo de SUBSUBSECCIONES
    show heading.where(level: 5): set heading(supplement: $section$)
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
      heading(level: 2, outlined: false, numbering: none)[Índice general]
      v(2em)
      it
    }
    show outline.entry.where(level: 1): it => { spaced-smallcaps(it) }
    show outline.entry.where(level: 2): it => { strong(text(size: 1.1em, it)) }
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

    show outline.where(target: figure.where(kind: image)): it => {
      v(1em)
      text(size: 2em, "Índice de figuras")
      v(1em)
      it
    }
    
    // BIBLIOGRAFÍA
    show bibliography: set text(size: 10pt)
    show bibliography: it => {
      set page(header: none)
      show heading: set heading(numbering: none)
      text(size: 12pt, weight: "bold", fill: colors.lines, ". ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁.. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁.. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁.. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁..")
      show heading: h => {
        align(center, text(1.5em, fill: colors.title, tracking: 0.1em, upper(h.body)))
      }
      show regex("\[\d+\]"): it => text(fill: colors.ref, it)
      it
    }
  
    // REFERENCIAS Y ENLACES
    show link: it => text(fill: colors.link, it.body)
    show ref: it => text(fill: colors.ref, weight: "bold", it)
    show ref: it => {
      let el = it.element
      if el != none and el.func() == heading and el.depth >= 3 {
        let nums = counter(heading).at(el.location()).slice(1)
        let displayed = if el.depth == 3 {
          numbering("1.1", ..nums)
        } else if el.depth == 4 {
          numbering("1.1.1", ..nums)
        } else {
          numbering("1.1.1.a", ..nums)
        }
        link(el.location(), text(fill: colors.ref, $section$ + displayed))
      } else {
        it
      }
    }

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
      placement: top,
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
    show figure.where(kind: "wide"): it => {
      set par(first-line-indent: 0pt)
      block(
        width: 100% + 0.5cm,
        outset: (right: 0.5cm),
        stack(
          dir: ttb,
          spacing: 0.5em,
          align(center, it.body),
          align(left, text(size: captionfontsize, it.caption)),
        )
      )
    }
    show figure.caption: it => {
      strong(it.supplement + [ ] + context it.counter.display(it.numbering))
      it.separator
      it.body
    }

    //LISTAS
    set list(marker: text(fill: colors.lines, "•"))
        
    // CÓDIGO
    show: codly-init.with()
    codly(
      languages: codly-languages,
      // fill: rgb("#1e1e1e"),
      number-format: (n) => text(fill: colors.lines, str(n)),
      stroke: 1pt + colors.lines,
      radius: 4pt,
      inset: 2.5pt,
      zebra-fill: none,
      smart-indent: true
    )
    show raw: set text(font: "Cascadia Code", size: 10pt)
    // show raw: set par(justify: false)

    // RENDERIZADO
    doc
  }
}