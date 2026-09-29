// Plantilla de Nueva Somosaguas: los tokens de website/styles.css llevados al papel.

#let granate = rgb("#800000")
#let tinta = rgb("#111111")
#let gris = rgb("#555555")
#let superficie = rgb("#f5f5ee")
#let borde = rgb("#e0e0d8")

$if(highlighting-definitions)$
// Con el resaltado de skylighting (el de Quarto por omisión, o un tema en
// syntax-highlighting), cada token es un raw en línea: sin esto llevaría la caja del
// código en línea, y el bloque, el fondo gris de Quarto.
#let Skylighting(fill: none, number: false, start: 1, sourcelines) = {
  show raw.where(block: false): it => text(font: "Fira Code", size: 0.8em, it.text)
  let lnum = start - 1
  let lineas = for ln in sourcelines {
    if number { lnum += 1; box(width: 24pt, text(fill: gris, [#lnum])) }
    ln + EndLine()
  }
  block(width: 100%, fill: superficie, inset: 10pt, stroke: (left: 3pt + granate), radius: (right: 3pt), lineas)
}
$endif$

// Márgenes de la maqueta a una columna: el derecho aloja las notas al margen.
#let _margen-izq = 2.5cm
#let _margen-der = 6.5cm
#let _separacion-nota = 0.8cm
#let _ancho-nota = 4.5cm

#let _columnas = state("somosaguas-columnas", 1)
#let _contador-nota = counter("somosaguas-nota")

// Nota al margen al estilo Tufte. A dos columnas no hay margen libre y se
// convierte en nota al pie.
// ponytail: notas muy seguidas pueden solaparse en el margen; si ocurre,
// sepáralas en el texto o pasa a @preview/marginalia, que las reubica.
#let nota(cuerpo) = context {
  if _columnas.get() == 2 { return footnote(cuerpo) }
  _contador-nota.step()
  let n = _contador-nota.get().first() + 1
  let x = here().position().x
  super(text(fill: granate, str(n)))
  box(width: 0pt, place(
    top + left,
    dx: page.width - _margen-der + _separacion-nota - x,
    block(
      width: _ancho-nota,
      stroke: (left: 1.5pt + granate),
      inset: (left: 6pt),
      {
        set par(justify: false)
        set text(size: 8.5pt, fill: gris)
        super(text(fill: granate, str(n)))
        [ #cuerpo]
      },
    ),
  ))
}

#let somosaguas(
  titulo: none,
  subtitulo: none,
  autores: (),
  fecha: none,
  resumen: none,
  columnas: 1, // 1: notas al margen; 2: dos columnas, notas al pie
  fondo: rgb("#fffff8"), // `none` para imprimir sin el crema de la web
  cuerpo,
) = {
  assert(columnas in (1, 2), message: "columnas debe ser 1 o 2")
  _columnas.update(columnas)

  set document(title: titulo, author: autores)
  set page(
    paper: "a4",
    fill: fondo,
    columns: columnas,
    margin: if columnas == 1 {
      (left: _margen-izq, right: _margen-der, y: 2.5cm)
    } else { (x: 1.8cm, y: 2.2cm) },
    header: context if here().page() > 1 {
      set text(size: 8.5pt, fill: gris)
      smallcaps[Nueva Somosaguas]
      h(1fr)
      emph(titulo)
    },
    footer: context align(center, text(size: 9pt, fill: gris, counter(page).display())),
  )
  set columns(gutter: 0.9cm)

  set text(font: "EB Garamond", size: if columnas == 1 { 11.5pt } else { 10.5pt }, lang: "es", fill: tinta)
  set par(justify: true, leading: 0.7em, spacing: 1.2em)

  // Encabezados: granate y negrita; el segundo nivel en cursiva, como el h3 de la web.
  set heading(numbering: none)
  show heading: set text(fill: granate, weight: 700)
  show heading: set block(above: 1.8em, below: 0.9em)
  show heading.where(level: 1): set text(size: 1.45em)
  show heading.where(level: 2): set text(size: 1.2em, style: "italic")
  show heading.where(level: 3): set text(size: 1em, style: "italic", weight: 400)

  show link: set text(fill: granate)
  show link: underline.with(stroke: 0.5pt, offset: 2.5pt)

  show raw: set text(font: "Fira Code", size: 0.8em)
  show raw.where(block: false): box.with(
    fill: superficie, stroke: 0.5pt + borde, radius: 2pt,
    inset: (x: 2.5pt), outset: (y: 2.5pt),
  )
  // Un `set` y no un bloque envolvente: así sustituye el fondo gris que Quarto
  // define para los bloques de código en lugar de quedar por fuera.
  show raw.where(block: true): set block(
    width: 100%, fill: superficie, inset: 10pt,
    stroke: (left: 3pt + granate), radius: (right: 3pt),
  )

  show quote.where(block: true): it => block(
    stroke: (left: 3pt + granate), inset: (left: 12pt, y: 4pt),
    text(style: "italic", fill: gris, it),
  )

  // Tablas de Tufte: sin líneas verticales, raya gruesa bajo la cabecera y al cierre.
  set table(
    stroke: (_, y) => if y == 1 { (top: 1pt + tinta) } else if y > 1 { (top: 0.5pt + borde) },
    inset: (x: 6pt, y: 5pt),
    align: left,
  )
  show table.cell: set par(justify: false)
  show table.cell.where(y: 0): strong
  // Quarto escribe `align: auto` en cada tabla: sin esto heredan el centrado de la figura.
  show table: it => block(stroke: (bottom: 1pt + tinta), { set align(left); it })

  show figure.caption: set text(size: 0.88em, fill: gris)
  set footnote.entry(separator: if columnas == 2 { line(length: 30%, stroke: 0.5pt + borde) })
  show footnote.entry: set text(size: 0.85em)
  // En Markdown las notas se escriben `^[...]`: a una columna pasan al margen.
  show footnote: it => if columnas == 1 { nota(it.body) } else { it }
  show footnote.entry: it => if columnas == 1 { none } else { it }

  // Cabecera del documento: abarca todas las columnas.
  place(top, float: true, scope: "parent", clearance: 2em, {
    if titulo != none {
      block(
        width: 100%, stroke: (bottom: 2pt + granate), inset: (bottom: 8pt),
        text(size: 2.2em, weight: 700, fill: granate, par(justify: false, leading: 0.5em, titulo)),
      )
    }
    if subtitulo != none { text(size: 1.25em, style: "italic", fill: gris, subtitulo) }
    if autores.len() > 0 or fecha != none {
      block(above: 1.2em, text(fill: gris, {
        smallcaps(autores.join(" · "))
        if autores.len() > 0 and fecha != none [ #h(0.4em)—#h(0.4em) ]
        fecha
      }))
    }
    // El resumen reproduce la banda .hero de la portada web.
    if resumen != none {
      block(
        above: 1.5em, width: 100%, fill: superficie, inset: 14pt,
        stroke: (bottom: 2pt + borde),
        text(style: "italic", resumen),
      )
    }
  })

  cuerpo
}
