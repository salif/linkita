+++
title = "Guide de la syntaxe Markdown"
description = "Article d'exemple présentant la syntaxe Markdown de base et la mise en forme des éléments HTML."
date = 2022-10-20
#updated =
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["kita", "salif"]
[extra]
[extra.cover]
image = "images/markdown-syntax.png"
alt = "Un logo Markdown"
width = 1600
height = 800
+++

Cet article présente un échantillon de la syntaxe Markdown de base utilisable dans les fichiers de contenu Zola, et montre également comment les éléments HTML de base sont mis en forme par le CSS du thème Linkita.

<!--more-->

## Titres

Les éléments HTML `<h1>`—`<h6>` suivants représentent six niveaux de titres de section. `<h1>` est le niveau le plus élevé, tandis que `<h6>` est le plus bas.

# H1

## H2

### H3

#### H4

##### H5

###### H6

## Paragraphe

Xerum, quo qui aut unt expliquam qui dolut labo. Aque venitatiusda cum, voluptionse latur sitiae dolessi aut parist aut dollo enim qui voluptate ma dolestendit peritin re plis aut quas inctum laceat est volestemque commosa as cus endigna tectur, offic to cor sequas etum rerum idem sintibus eiur? Quianimin porecus evelectur, cum que nis nust voloribus ratem aut omnimi, sitatur? Quiatem. Nam, omnis sum am facea corem alique molestrunt et eos evelece arcillit ut aut eos eos nus, sin conecerem erum fuga. Ri oditatquam, ad quibus unda veliamenimin cusam et facea ipsamus es exerum sitate dolores editium rerore eost, temped molorro ratiae volorro te reribus dolorer sperchicium faceata tiustia prat.

Itatur? Quiatae cullecum rem ent aut odis in re eossequodi nonsequ idebis ne sapicia is sinveli squiatum, core et que aut hariosam ex eat.

## Citations

L'élément blockquote (citation) représente un contenu cité d'une autre source, éventuellement avec une citation qui doit se trouver dans un élément `footer` ou `cite`, et éventuellement avec des modifications en ligne telles que des annotations et des abréviations.

#### Citation sans attribution

> Tiam, ad mint andaepu dandae nostion secatur sequo quae.
> **Notez** que vous pouvez utiliser la _syntaxe Markdown_ à l'intérieur d'une citation.

#### Citation avec attribution

> Ne communiquez pas en partageant la mémoire, partagez la mémoire en communiquant.<br>
> — <cite>Rob Pike[^1]</cite>

[^1]: La citation ci-dessus est extraite de la [présentation](https://www.youtube.com/watch?v=PAAkCSZUG1c) de Rob Pike lors du Gopherfest, le 18 novembre 2015.

## Liens

Pour créer un lien, entourez le texte du lien par des crochets, puis faites-le suivre immédiatement de l'URL entre parenthèses.

[YouTube](https://www.youtube.com)

Pour transformer rapidement une URL ou une adresse e-mail en lien, entourez-la de chevrons.

<https://www.youtube.com>

## Images

![Guide Markdown](../../images/markdown-syntax.png)

## Tableaux

Les tableaux ne font pas partie de la spécification de base de Markdown, mais Zola les prend en charge nativement.

| Nom   | Âge |
| ----- | --- |
| Bob   | 27  |
| Alice | 23  |

#### Markdown en ligne dans les tableaux

| Italique  | Gras       | Code   |
| --------- | ---------- | ------ |
| _italics_ | **bold**   | `code` |

## Blocs de code

#### Bloc de code avec des backticks

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

#### Bloc de code indenté avec quatre espaces

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

## Types de listes

#### Liste ordonnée

1. Premier élément
2. Deuxième élément
3. Troisième élément

#### Liste non ordonnée

- Élément de liste
- Autre élément
- Et un autre élément

#### Liste imbriquée

- Fruit
  - Pomme
  - Orange
  - Banane
- Produits laitiers
  - Lait
  - Fromage

## Autres éléments — abbr, sub, sup, kbd, mark

<abbr title="Graphics Interchange Format">GIF</abbr> est un format d'image bitmap.

H<sub>2</sub>O

X<sup>n</sup> + Y<sup>n</sup> = Z<sup>n</sup>

Appuyez sur <kbd><kbd>CTRL</kbd>+<kbd>ALT</kbd>+<kbd>Suppr</kbd></kbd> pour terminer la session.

La plupart des <mark>salamandres</mark> sont nocturnes et chassent des insectes, des vers et d'autres petites créatures.
