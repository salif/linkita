+++
title = "Shortcody"
description = "Shortcody šablony Linkita."
date = 2022-10-20
updated = 2025-04-20
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["kita", "salif"]
[extra]
mermaid = true
+++

Šablona Linkita poskytuje několik shortcodů.

Nikdy jste o shortcodech neslyšeli? Více informací naleznete v [dokumentaci Zoly](https://www.getzola.org/documentation/content/shortcodes/).

## Mermaid {#mermaid-header}

Chcete-li na své stránce použít Mermaid, musíte v její frontmatter části nastavit `extra.mermaid = true`.

```toml
+++
title = "Titulek vaší stránky"

[extra]
mermaid = true
+++
```

Poté můžete shortcode `mermaid()` použít takto:

```markdown
{%/* mermaid() */%}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{%/* end */%}
```

Toto bude vykresleno jako:

{% mermaid() %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% end %}

Kromě toho můžete uvnitř shortcodu `mermaid()` použít blok kódu, který bude ignorován.

Blok kódu zabraňuje formátovači, aby rozbil formátování diagramu Mermaid.

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

Toto bude vykresleno jako:

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

## Poznámky

Shortcode `admonition()` zobrazí banner, který vám pomůže umístit na stránku upozornění.

Shortcode `admonition()` můžete použít takto:

```markdown
{%/* admonition(type="tip", title="tip") */%}
`tip` poznámka.
{%/* end */%}
```

Shortcode pro poznámky má 12 různých typů:

{% admonition(type="note", title="poznámka") %}
`note` poznámka.
{% end %}

{% admonition(type="abstract", title="abstrakt") %}
`abstract` poznámka.
{% end %}

{% admonition(type="info", title="info") %}
`info` poznámka.
{% end %}

{% admonition(type="tip", title="tip") %}
`tip` poznámka.
{% end %}

{% admonition(type="success", title="úspěch") %}
`success` poznámka.
{% end %}

{% admonition(type="question", title="otázka") %}
`question` poznámka.
{% end %}

{% admonition(type="warning", title="varování") %}
`warning` poznámka.
{% end %}

{% admonition(type="failure", title="neúspěch") %}
`failure` poznámka.
{% end %}

{% admonition(type="danger", title="nebezpečí") %}
`danger` poznámka.
{% end %}

{% admonition(type="bug", title="chyba") %}
`bug` poznámka.
{% end %}

{% admonition(type="example", title="příklad") %}
`example` poznámka.
{% end %}

{% admonition(type="quote", title="citace") %}
`quote` poznámka.
{% end %}

## Galerie

Shortcode `gallery()` je velmi jednoduchá, klikatelná obrázková galerie (pouze HTML), která zobrazuje všechny obrázky z prostředků stránky (page assets).

Pochází z [dokumentace Zoly](https://www.getzola.org/documentation/content/image-processing/)

```markdown
{{/* gallery(alt="Ukázkový obrázek pro galerii") */}}
```

{{ gallery(alt="Ukázkový obrázek pro galerii") }}

## Projekty

Shortcode `projects()` vám umožní vytvořit stránku pro vaše projekty.

Vytvořte soubor `content/pages/projects/index.md`:

```markdown
+++
title = "Moje projekty"
description = ""
path = "projects"
+++

{{/* projects(path="data.toml", format="toml") */}}
```

Vytvořte soubor `content/pages/projects/data.toml`:

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

Toto bude zobrazeno jako:

{{ projects(path="projects.toml", format="toml") }}
