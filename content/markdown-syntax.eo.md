+++
title = "Gvidilo pri Markdown-Sintakso"
description = "Ekzempla artikolo montrante bazan Markdown-sintakson kaj formatadon por HTML-elementoj."
date = 2022-10-20
updated = 2024-10-24
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["kita", "salif"]
[extra]
[extra.cover]
image = "images/markdown-syntax.png"
alt = "Markdown-emblemo"
width = 1600
height = 800
+++

Ĉi tiu artikolo proponas ekzemplon de baza Markdown-sintakso, kiu uzeblas en Zola-enhavo-dosieroj, kaj ankaŭ montras ĉu bazaj HTML-elementoj estas ornamitaj per CSS en Linkita temo.

<!--more-->

## Titoloj

La jenaj HTML-elementoj `<h1>`—`<h6>` reprezentas ses nivelojn de sekciaj titoloj. `<h1>` estas la plej alta sekcia nivelo, dum `<h6>` estas la plej malalta.

# Titolo 1

## Titolo 2

### Titolo 3

#### Titolo 4

##### Titolo 5

###### Titolo 6

## Paragrafo

Xerum, quo qui aut unt expliquam qui dolut labo. Aque venitatiusda cum, voluptionse latur sitiae dolessi aut parist aut dollo enim qui voluptate ma dolestendit peritin re plis aut quas inctum laceat est volestemque commosa as cus endigna tectur, offic to cor sequas etum rerum idem sintibus eiur? Quianimin porecus evelectur, cum que nis nust voloribus ratem aut omnimi, sitatur? Quiatem. Nam, omnis sum am facea corem alique molestrunt et eos evelece arcillit ut aut eos eos nus, sin conecerem erum fuga. Ri oditatquam, ad quibus unda veliamenimin cusam et facea ipsamus es exerum sitate dolores editium rerore eost, temped molorro ratiae volorro te reribus dolorer sperchicium faceata tiustia prat.

Itatur? Quiatae cullecum rem ent aut odis in re eossequodi nonsequ idebis ne sapicia is sinveli squiatum, core et que aut hariosam ex eat.

## Citaĵoj

La citaĵa elemento reprezentas enhavon cititan el alia fonto, laŭvole kun citaĵo, kiu devas esti ene de `footer` aŭ `cite` elemento, kaj laŭvole kun entekstaj ŝanĝoj kiel komentoj kaj mallongigoj.

#### Citaĵo sen atribuo

> Tiam, ad mint andaepu dandae nostion secatur sequo quae.
> **Rimarku**, ke vi povas uzi _Markdown-sintakson_ ene de citaĵo.

#### Citaĵo kun atribuo

> Ne komuniku per kunhavigo de memoro, kunhavu memoron per komunikado.<br>
> — <cite>Rob Pike[^1]</cite>

[^1]: La supra citaĵo estas eltirita el la [prelego](https://www.youtube.com/watch?v=PAAkCSZUG1c) de Rob Pike dum Gopherfest, la 18-an de novembro 2015.

## Ligiloj

Por krei ligon, enfermu la ligtekston en krampoj kaj tuj sekvu ĝin per la URL en krampoj.

[GitHub](https://github.com)

Por rapide transformi URL-on aŭ retpoŝtadreson en ligon, enfermu ĝin en angulajn krampojn.

<https://github.com>

## Bildoj

![Gvidilo pri Markdown](../../images/markdown-syntax.png)

## Tabeloj

Tabeloj ne estas parto de la kerna Markdown-specifo, sed Zola subtenas ilin defaŭlte.

| Nomo | Aĝo |
|---|---|
| Bob | 27 |
| Alice | 23 |

#### Enteksta Markdown ene de tabeloj

| Kursivo | Grase | Kodo |
|---|---|---|
| _kursivo_ | **grase** | `kodo` |

## Kodblokoj

#### Kodbloko kun kontraŭstrekoj

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Example HTML5 Document</title>
  </head>
  <body>
    <p>Test</p>
  </body>
</html>
```

#### Kodbloko enmetita per kvar spacetoj

    <!doctype html>
    <html lang="en">
    <head>
      <meta charset="utf-8">
      <title>Example HTML5 Document</title>
    </head>
    <body>
      <p>Test</p>
    </body>
    </html>

## Listo-Tipoj

#### Ordigita Listo

1. Unua elemento
2. Dua elemento
3. Tria elemento

#### Neordigita Listo

- Listo-elemento
- Alia elemento
- Kaj alia elemento

#### Nesta listo

- Frukto
  - Pomo
  - Oranĝo
  - Banano
- Laktaĵoj
  - Lakto
  - Fromaĝo

## Aliaj Elementoj — abbr, sub, sup, kbd, mark

<abbr title="Graphics Interchange Format">GIF</abbr> estas rastruma bildformato.

H<sub>2</sub>O

X<sup>n</sup> + Y<sup>n</sup> = Z<sup>n</sup>

Premu <kbd><kbd>CTRL</kbd>+<kbd>ALT</kbd>+<kbd>Delete</kbd></kbd> por fini la sesion.

Plej multaj <mark>salamandroj</mark> estas noktaj, kaj ĉasas insektojn, vermojn kaj aliajn malgrandajn estaĵojn.
