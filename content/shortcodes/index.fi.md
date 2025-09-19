+++
title = "Pikakoodit"
description = "Linkita-teeman pikakoodit."
date = 2022-10-20
updated = 2025-04-20
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["kita", "salif"]
[extra]
mermaid = true
+++

Linkita-teema tarjoaa useita pikakoodeja.

Etkö ole koskaan kuullut pikakoodeista? Katso lisätietoja [Zolan dokumentaatiosta](https://www.getzola.org/documentation/content/shortcodes/).

## Mermaid {#mermaid-header}

Käyttääksesi Mermaidia sivullasi, sinun tulee asettaa `extra.mermaid = true` sivun frontmatter-osioon.

```toml
+++
title = "Sivusi otsikko"

[extra]
mermaid = true
+++
```

Sitten voit käyttää `mermaid()`-pikakoodeja näin:

```markdown
{%/* mermaid() */%}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{%/* end */%}
```

Tämä renderöidään seuraavasti:

{% mermaid() %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% end %}

Lisäksi voit käyttää koodilohkoa `mermaid()`-pikakoodien sisällä, jolloin koodilohko jätetään huomiotta.

Koodilohko estää muotoilutyökalua rikkomasta Mermaidin muotoilua.

````markdown
{%/* mermaid() */%}

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

{%/* end */%}
````

Tämä renderöidään seuraavasti:

{% mermaid() %}

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

{% end %}

## Huomautukset

`admonition()`-pikakoodi näyttää bannerin, jonka avulla voit lisätä huomautuksia sivullesi.

Voit käyttää `admonition()`-pikakoodia näin:

```markdown
{%/* admonition(type="tip", title="vinkki") */%}
`tip`-huomautus.
{%/* end */%}
```

Huomautus-pikakoodilla on 12 eri tyyppiä:

{% admonition(type="note", title="huomautus") %}
`note`-huomautus.
{% end %}

{% admonition(type="abstract", title="tiivistelmä") %}
`abstract`-huomautus.
{% end %}

{% admonition(type="info", title="info") %}
`info`-huomautus.
{% end %}

{% admonition(type="tip", title="vinkki") %}
`tip`-huomautus.
{% end %}

{% admonition(type="success", title="onnistuminen") %}
`success`-huomautus.
{% end %}

{% admonition(type="question", title="kysymys") %}
`question`-huomautus.
{% end %}

{% admonition(type="warning", title="varoitus") %}
`warning`-huomautus.
{% end %}

{% admonition(type="failure", title="virhe") %}
`failure`-huomautus.
{% end %}

{% admonition(type="danger", title="vaara") %}
`danger`-huomautus.
{% end %}

{% admonition(type="bug", title="bugi") %}
`bug`-huomautus.
{% end %}

{% admonition(type="example", title="esimerkki") %}
`example`-huomautus.
{% end %}

{% admonition(type="quote", title="lainaus") %}
`quote`-huomautus.
{% end %}

## Galleria

`gallery()`-pikakoodi on hyvin yksinkertainen, vain HTML:ää käyttävä klikattava kuvagalleria, joka näyttää kaikki kuvat sivun resursseista.

Se on [Zolan dokumentaatiosta](https://www.getzola.org/documentation/content/image-processing/).

```markdown
{{/* gallery() */}}
```

{{ gallery(alt="Demonstraatiokuva gallerialle") }}

## Projektit

`projects()`-pikakoodin avulla voit luoda sivun projekteillesi.

Luo `content/pages/projects/index.md`-tiedosto:

```markdown
+++
title = "Projektini"
description = ""
path = "projektit"
+++

{{/* projects(path="data.toml", format="toml") */}}
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

{{ projects(path="projects.toml", format="toml") }}
