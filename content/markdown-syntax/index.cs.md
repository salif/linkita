+++
title = "Průvodce syntaxí Markdownu"
description = "Ukázkový článek představující základní syntaxi Markdownu a formátování HTML prvků."
date = 2022-10-20
#updated =
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["kita", "salif"]
[extra]
[extra.cover]
image = "images/markdown-syntax.png"
alt = "Logo Markdownu"
width = 1600
height = 800
+++

Tento článek nabízí ukázku základní syntaxe Markdownu, kterou lze použít v obsahových souborech Zoly. Také ukazuje, jak jsou základní HTML prvky stylovány pomocí CSS v šabloně Linkita.

<!--more-->

## Nadpisy

Následující HTML prvky `<h1>`–`<h6>` představují šest úrovní nadpisů oddílů. `<h1>` je nejvyšší úroveň, zatímco `<h6>` je nejnižší.

# H1

## H2

### H3

#### H4

##### H5

###### H6

## Odstavec

Příliš žluťoučký kůň úpěl ďábelské ódy. Líšeň, čaj, hleď, zpěv, tvůj plyn, síň, boď. Zdůrazňoval, že amfibolit rozpouští polohlásku. V zemi pak přehlídka okázalejších gymnázií se stala oblíbenou. I když o francouzštině, angličtině, italštině, španělštině a němčině se nedá říct, že by byly příbuzné.

Cožpak o obratnosti sněmovní s nejlepším svědomím. Ó, náhlý déšť – ó, náhlý déšť! Cožpak o obratnosti sněmovní s nejlepším svědomím.

## Blokové citace

Prvek blockquote představuje obsah, který je citován z jiného zdroje, volitelně s citací, která musí být v prvku `footer` nebo `cite`, a volitelně s vloženými změnami, jako jsou anotace a zkratky.

#### Bloková citace bez uvedení zdroje

> Tiam, ad mint andaepu dandae nostion secatur sequo quae.
> **Poznámka**: V blokové citaci můžete použít _syntaxi Markdownu_.

#### Bloková citace s uvedením zdroje

> Nekomunikujte sdílením paměti, sdílejte paměť komunikací.<br>
> — <cite>Rob Pike[^1]</cite>

[^1]: Výše uvedený citát je úryvkem z [přednášky](https://www.youtube.com/watch?v=PAAkCSZUG1c) Roba Pikea během Gopherfestu, 18. listopadu 2015.

## Odkazy

Chcete-li vytvořit odkaz, vložte text odkazu do hranatých závorek a hned za něj do kulatých závorek vložte URL adresu.

[GitHub](https://github.com)

Chcete-li rychle přeměnit URL adresu nebo e-mailovou adresu na odkaz, vložte ji do lomených závorek.

<https://github.com>

## Obrázky

![Průvodce Markdownem](../../images/markdown-syntax.png)

## Tabulky

Tabulky nejsou součástí základní specifikace Markdownu, ale Zola je podporuje v základní instalaci.

| Jméno | Věk |
| ----- | --- |
| Bob   | 27  |
| Alice | 23  |

#### Vložený Markdown v tabulkách

| Kurzíva   | Tučné     | Kód   |
| --------- | -------- | ------ |
| _kurzíva_ | **tučné** | `kód` |

## Bloky kódu

#### Blok kódu s obrácenými apostrofy

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

#### Blok kódu odsazený čtyřmi mezerami

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

## Typy seznamů

#### Číslovaný seznam

1. První položka
2. Druhá položka
3. Třetí položka

#### Nečíslovaný seznam

- Položka seznamu
- Další položka
- A ještě další položka

#### Vnořený seznam

- Ovoce
  - Jablko
  - Pomeranč
  - Banán
- Mléčné výrobky
  - Mléko
  - Sýr

## Ostatní prvky — abbr, sub, sup, kbd, mark

<abbr title="Formát pro výměnu grafiky">GIF</abbr> je bitmapový formát obrázků.

H<sub>2</sub>O

X<sup>n</sup> + Y<sup>n</sup> = Z<sup>n</sup>

Stiskněte <kbd><kbd>CTRL</kbd>+<kbd>ALT</kbd>+<kbd>Delete</kbd></kbd> pro ukončení relace.

Většina <mark>mloků</mark> je nočních a loví hmyz, červy a další malé tvory.
