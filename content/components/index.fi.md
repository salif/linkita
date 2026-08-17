+++
title = "Komponentit"
description = "Kuinka käyttää komponentteja"
date = 2022-10-20
updated = 2026-08-16
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["salif"]
[extra]
mermaid = true
+++

Linkita-teema tarjoaa useita komponentteja.

Etkö ole koskaan kuullut komponenteista? Katso lisätietoja [Zolan dokumentaatiosta](https://keats.github.io/tera/#components).

## Mermaid-komponentti

Käyttääksesi Mermaidia sivullasi, sinun tulee asettaa `extra.mermaid = true` sivun frontmatter-osioon.

```toml
+++
title = "Sivusi otsikko"

[extra]
mermaid = true
+++
```

Sitten voit käyttää `<mermaid>`-komponenttia näin:

```markdown
{% raw %}{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}{% endraw %}
```

Tämä renderöidään seuraavasti:

{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}

Lisäksi voit käyttää koodilohkoa `<mermaid>`-komponenttien sisällä, jolloin koodilohko jätetään huomiotta.

Koodilohko estää muotoilutyökalua rikkomasta Mermaidin muotoilua.

````markdown
{% raw %}{% <mermaid> -%}

```mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hello John, how are you?
    loop Healthcheck
        John->>John: Fight against hypochondria
    end
    Note right of John: Rational thoughts <br/>prevail!
    John-->>Alice: Great!
    John->>Bob: How about you?
    Bob-->>John: Jolly good!
```

{%- </mermaid> %}{% endraw %}
````

Tämä renderöidään seuraavasti:

{% <mermaid> -%}

```mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hello John, how are you?
    loop Healthcheck
        John->>John: Fight against hypochondria
    end
    Note right of John: Rational thoughts <br/>prevail!
    John-->>Alice: Great!
    John->>Bob: How about you?
    Bob-->>John: Jolly good!
```

{%- </mermaid> %}

## Huomautukset

`<admonition>`-komponentti näyttää bannerin, jonka avulla voit lisätä huomautuksia sivullesi.

Voit käyttää komponenttia näin:

```markdown
{% raw %}{% <admonition type="tip" title="vinkki"> %}
`tip`-huomautus.
{% </admonition> %}{% endraw %}
```

Huomautuskomponentilla on 12 eri tyyppiä:

{% <admonition type="note" title="huomautus"> %}
`note`-huomautus.
{% </admonition> %}

{% <admonition type="abstract" title="tiivistelmä"> %}
`abstract`-huomautus.
{% </admonition> %}

{% <admonition type="info" title="info"> %}
`info`-huomautus.
{% </admonition> %}

{% <admonition type="tip" title="vinkki"> %}
`tip`-huomautus.
{% </admonition> %}

{% <admonition type="success" title="onnistuminen"> %}
`success`-huomautus.
{% </admonition> %}

{% <admonition type="question" title="kysymys"> %}
`question`-huomautus.
{% </admonition> %}

{% <admonition type="warning" title="varoitus"> %}
`warning`-huomautus.
{% </admonition> %}

{% <admonition type="failure" title="virhe"> %}
`failure`-huomautus.
{% </admonition> %}

{% <admonition type="danger" title="vaara"> %}
`danger`-huomautus.
{% </admonition> %}

{% <admonition type="bug" title="bugi"> %}
`bug`-huomautus.
{% </admonition> %}

{% <admonition type="example" title="esimerkki"> %}
`example`-huomautus.
{% </admonition> %}

{% <admonition type="quote" title="lainaus"> %}
`quote`-huomautus.
{% </admonition> %}

## Galleria

`<gallery />` -komponentti on hyvin yksinkertainen, vain HTML:ää käyttävä klikattava kuvagalleria, joka näyttää kaikki kuvat sivun resursseista.

Se on [Zolan dokumentaatiosta](https://www.getzola.org/documentation/content/image-processing/).

```markdown
{% raw %}{{ <gallery /> }}{% endraw %}
```

{{ <gallery page config alt="Demonstraatiokuva gallerialle" /> }}

## Projektit

`<projects />` -komponentin avulla voit luoda sivun projekteillesi.

Luo `content/pages/projects/index.md`-tiedosto:

```markdown
+++
title = "Projektini"
description = ""
path = "projektit"
+++

{% raw %}{{ <projects path="data.toml" format="toml" page config /> }}{% endraw %}
```

Luo `content/pages/projects/data.toml`-tiedosto:

```toml
[[project]]
name = "lorem"
desc = "Lorem ipsum dolor sit."
tags = ["lorem", "ipsum"]
links = [
    { name = "homepage", url = "https://example.com" },
    { name = "source", url = "https://example.com" },
]
```

Tämä näytetään seuraavasti:

{{ <projects path="projects.toml" format="toml" page config /> }}
