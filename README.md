# somosaguas-quarto-theme

Extensión reutilizable de Quarto con el motor de diseño y maquetación de Nueva Somosaguas: tipografía Garamond, estilos CSS inspirados en Edward Tufte, notas al margen y clases de gráficos para R (`ggplot2`), Julia y Python.

```bash
quarto install extension nuevasomosaguas/somosaguas-quarto-theme
```

## Formato HTML

`somosaguas-html` es el tema de la web para un documento suelto: papel crema, tinta y granate, EB Garamond y Fira Code (las del sistema; si faltan, Georgia y la monoespaciada), tablas de Tufte y la interfaz en español.

```yaml
format: somosaguas-html
```

## En el entorno de la Nueva Somosaguas

La imagen del [entorno](https://github.com/nuevasomosaguas/entorno) trae la extensión instalada en Quarto, sin `quarto install extension`: `somosaguas-html` y `somosaguas-typst` funcionan en cualquier carpeta. Además, es el aspecto por omisión: `format: html` sin `theme` y `format: typst`, como los que escribe el diálogo de documento nuevo de RStudio, salen ya con este tema y en español. Pandoc también: `pandoc texto.md -o texto.pdf` compila con Typst y la plantilla de `pandoc/default.typst`, que usa la misma maqueta. Fuera del entorno, un documento que deba verse igual en cualquier máquina tiene que pedir el formato por su nombre.

## Formato Typst

La extensión aporta el formato `somosaguas-typst`, la misma maqueta que [somosaguas-typst-template](https://github.com/nuevasomosaguas/somosaguas-typst-template): EB Garamond y Fira Code incluidas (licencia OFL), a una o dos columnas.

```yaml
---
title: "Título"
subtitle: "Subtítulo"
author: "Autor"
date: today
abstract: "Resumen..."
format:
  somosaguas-typst:
    columnas: 1 # 2 para dos columnas
    # fondo: none  # para imprimir en blanco en lugar del crema de la web
---
```

Las notas se escriben como notas al pie (`^[...]`): a una columna aparecen al margen, al estilo Tufte; a dos columnas, al pie de página. `template.qmd` es un ejemplo completo:

```bash
quarto render template.qmd
```
