#show: somosaguas.with(
$if(title)$
  titulo: [$title$],
$endif$
$if(subtitle)$
  subtitulo: [$subtitle$],
$endif$
$if(by-author)$
  autores: ($for(by-author)$"$it.name.literal$",$endfor$),
$endif$
$if(date)$
  fecha: [$date$],
$endif$
$if(abstract)$
  resumen: [$abstract$],
$endif$
$if(columnas)$
  columnas: $columnas$,
$endif$
$if(fondo)$
  fondo: $fondo$,
$endif$
)
