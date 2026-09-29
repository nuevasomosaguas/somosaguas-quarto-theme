# somosaguas-quarto-theme

Extensión reutilizable de Quarto con el motor de diseño y maquetación de Nueva Somosaguas: tipografía Garamond, estilos CSS inspirados en Edward Tufte, notas al margen y clases de gráficos para R (`ggplot2`), Julia y Python.

```bash
quarto install extension nuevasomosaguas/somosaguas-quarto-theme
```

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
