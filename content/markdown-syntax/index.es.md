+++
title = "Guía de Sintaxis Markdown"
description = "Artículo de ejemplo que muestra la sintaxis básica de Markdown y el formato para elementos HTML."
date = 2022-10-20
#updated =
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["kita", "salif"]
[extra]
[extra.cover]
image = "images/markdown-syntax.png"
alt = "Un logo de Markdown"
width = 1600
height = 800
+++

Este artículo ofrece una muestra de la sintaxis básica de Markdown que se puede utilizar en los archivos de contenido de Zola. También muestra si los elementos HTML básicos están decorados con CSS en el tema Linkita.

<!--more-->

## Encabezados

Los siguientes elementos HTML `<h1>`—`<h6>` representan seis niveles de encabezados de sección. `<h1>` es el nivel de sección más alto, mientras que `<h6>` es el más bajo.

# H1

## H2

### H3

#### H4

##### H5

###### H6

## Párrafo

Xerum, quo qui aut unt expliquam qui dolut labo. Aque venitatiusda cum, voluptionse latur sitiae dolessi aut parist aut dollo enim qui voluptate ma dolestendit peritin re plis aut quas inctum laceat est volestemque commosa as cus endigna tectur, offic to cor sequas etum rerum idem sintibus eiur? Quianimin porecus evelectur, cum que nis nust voloribus ratem aut omnimi, sitatur? Quiatem. Nam, omnis sum am facea corem alique molestrunt et eos evelece arcillit ut aut eos eos nus, sin conecerem erum fuga. Ri oditatquam, ad quibus unda veliamenimin cusam et facea ipsamus es exerum sitate dolores editium rerore eost, temped molorro ratiae volorro te reribus dolorer sperchicium faceata tiustia prat.

Itatur? Quiatae cullecum rem ent aut odis in re eossequodi nonsequ idebis ne sapicia is sinveli squiatum, core et que aut hariosam ex eat.

## Citas en bloque

El elemento blockquote representa contenido citado de otra fuente, opcionalmente con una citación que debe estar dentro de un elemento `footer` o `cite`, y opcionalmente con cambios en línea como anotaciones y abreviaturas.

#### Cita en bloque sin atribución

> Tiam, ad mint andaepu dandae nostion secatur sequo quae.
> **Nota**: puedes usar _sintaxis Markdown_ dentro de una cita en bloque.

#### Cita en bloque con atribución

> No te comuniques compartiendo memoria, comparte memoria comunicándote.<br>
> — <cite>Rob Pike[^1]</cite>

[^1]: La cita anterior está extraída de la [charla](https://www.youtube.com/watch?v=PAAkCSZUG1c) de Rob Pike durante el Gopherfest, el 18 de noviembre de 2015.

## Enlaces

Para crear un enlace, encierra el texto del enlace entre corchetes y luego síguelo inmediatamente con la URL entre paréntesis.

[GitHub](https://github.com)

Para convertir rápidamente una URL o dirección de correo electrónico en un enlace, enciérrala entre corchetes angulares.

<https://github.com>

## Imágenes

![Guía de Markdown](../../images/markdown-syntax.png)

## Tablas

Las tablas no son parte de la especificación principal de Markdown, pero Zola las soporta de forma nativa.

| Nombre | Edad |
| ----- | --- |
| Bob   | 27  |
| Alice | 23  |

#### Markdown en línea dentro de las tablas

| Cursiva   | Negrita     | Código   |
| --------- | -------- | ------ |
| _cursiva_ | **negrita** | `código` |

## Bloques de código

#### Bloque de código con acentos graves

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Documento HTML5 de Ejemplo</title>
  </head>
  <body>
    <p>Prueba</p>
  </body>
</html>
```

#### Bloque de código con sangría de cuatro espacios

    <!doctype html>
    <html lang="en">
    <head>
      <meta charset="utf-8">
      <title>Documento HTML5 de Ejemplo</title>
    </head>
    <body>
      <p>Prueba</p>
    </body>
    </html>

## Tipos de listas

#### Lista ordenada

1. Primer elemento
2. Segundo elemento
3. Tercer elemento

#### Lista no ordenada

- Elemento de lista
- Otro elemento
- Y otro elemento más

#### Lista anidada

- Fruta
  - Manzana
  - Naranja
  - Plátano
- Lácteos
  - Leche
  - Queso

## Otros elementos — abbr, sub, sup, kbd, mark

<abbr title="Graphics Interchange Format">GIF</abbr> es un formato de imagen de mapa de bits.

H<sub>2</sub>O

X<sup>n</sup> + Y<sup>n</sup> = Z<sup>n</sup>

Presiona <kbd><kbd>CTRL</kbd>+<kbd>ALT</kbd>+<kbd>Supr</kbd></kbd> para finalizar la sesión.

La mayoría de las <mark>salamandras</mark> son nocturnas y cazan insectos, gusanos y otras pequeñas criaturas.
