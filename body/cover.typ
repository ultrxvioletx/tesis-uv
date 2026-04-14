#import "../style.typ": *

#let portada(
  universidad: "Universidad Nacional Autónoma de México",
  facultad: "Facultad de Ciencias",
  titulo: "Átomos de Rydberg interactuando dentro de una cavidad óptica",
  grado: "Física",
  autor: "Andrea Fernanda Rodríguez Rojas",
  tutor: "Dr. Pablo Barberis Blostein",
  lugar: "Ciudad de México",
  anio: "2026",
  logo-uni: "../assets/logos/unam.png",
  logo-fac: "../assets/logos/fciencias.png",
) = {
  set page(margin: (top: 2cm, bottom: 2cm, left: 3cm, right: 2cm))
  set text(lang: "es", font: "B612 Mono")

  place(left + top,
    dx: 0.6cm,
    dy: 21cm,
    rotate(-90deg, origin: left + top,
      text(size: 11pt, weight: "bold", fill: colors.lines,
        "· · · ✦ . ݁₊ ⊹ . ݁₊ ⊹ . ⊹ ₊ ݁.. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁.. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁.. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁.. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁.. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁. ✦ · · ·"
      )
    )
  )
  place(left + top,
    dx: 1.1cm,
    dy: 5cm,
    stack(
      dir: ltr,
      spacing: 4pt,
      rect(width: 2.5pt,   height: 62%, fill: colors.lines, stroke: none),
      // rect(width: 2.5pt, height: 62%, fill: colors.lines, stroke: none),
      rect(width: 1pt,   height: 62%, fill: colors.lines, stroke: none),
    )
  )

  grid(
    columns: (2cm, 1fr),
    column-gutter: 1cm,
    // logos
    align(center)[
      #image(logo-uni, width: 3.5cm)
      #v(1fr)
      #image(logo-fac, width: 3.5cm)
    ],
    // contenido
    align(center)[
      #v(0.5cm)
      #text(size: 13pt, tracking: 0.02em, weight: "bold", upper(universidad))
      #v(0.3cm)
      #line(length: 90%, stroke: 2.5pt + colors.lines)
      #text(size: 12pt, fill: colors.lines, ". ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁.. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁.. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁.. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁. ݁₊ ⊹ . ݁ ⟡ ݁ . ⊹ ₊ ݁.."
      )
      // #line(length: 90%, stroke: 1pt + colors.lines)
      #v(0.4cm)
      #text(size: 12pt, upper(facultad))
      #v(1fr)
      #text(size: 16pt, fill: colors.title, weight: "extrabold", tracking: 0.1em, upper(titulo))
      #v(1fr)
      #text(size: 26pt, tracking: 0.5em, weight: "extrabold", "T E S I S", font: "3270 Nerd Font Mono")
      #v(0.1cm)
      #text(size: 12pt, tracking: 0.1em, "Que para obtener el título de:")
      #v(0.1cm)
      #text(size: 14pt, tracking: 0.1em, upper(grado))
      #v(0.5cm)
      #text(size: 12pt, tracking: 0.05em, "Presenta:")
      #v(0.1cm)
      #text(size: 15pt, weight: "bold", tracking: 0.1em, autor)
      #v(1cm)
      #text(size: 12pt, tracking: 0.05em, "Tutor:")
      #v(0.1cm)
      #text(size: 12pt, tracking: 0.05em, tutor)
      #v(1fr)
      #text(size: 12pt, lugar + ", " + anio)
      #v(0.5cm)
    ],
  )
}


#portada()