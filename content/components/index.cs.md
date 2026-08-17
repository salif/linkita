+++
title = "Komponenty"
description = "Jak používat komponenty"
date = 2022-10-20
updated = 2026-08-16
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["salif"]
[extra]
mermaid = true
+++

Šablona Linkita poskytuje několik komponent.

Nikdy jste o komponentách neslyšeli? Více informací naleznete v [dokumentaci Zoly](https://keats.github.io/tera/#components).

## Mermaid komponenta

Chcete-li na své stránce použít Mermaid, musíte v její frontmatter části nastavit `extra.mermaid = true`.

```toml
+++
title = "Titulek vaší stránky"

[extra]
mermaid = true
+++
```

Poté můžete komponentu `<mermaid>` použít takto:

```markdown
{% raw %}{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}{% endraw %}
```

Toto bude vykresleno jako:

{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}

Kromě toho můžete uvnitř komponenty `<mermaid>` použít blok kódu, který bude ignorován.

Blok kódu zabraňuje formátovači, aby rozbil formátování diagramu Mermaid.

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

Toto bude vykresleno jako:

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

## Poznámky

Komponenta `<admonition>` zobrazí banner, který vám pomůže umístit na stránku upozornění.

Komponentu můžete použít takto:

```markdown
{% raw %}{% <admonition type="tip" title="tip"> %}
`tip` poznámka.
{% </admonition> %}{% endraw %}
```

Komponenta pro poznámky má 12 různých typů:

{% <admonition type="note" title="poznámka"> %}
`note` poznámka.
{% </admonition> %}

{% <admonition type="abstract" title="abstrakt"> %}
`abstract` poznámka.
{% </admonition> %}

{% <admonition type="info" title="info"> %}
`info` poznámka.
{% </admonition> %}

{% <admonition type="tip" title="tip"> %}
`tip` poznámka.
{% </admonition> %}

{% <admonition type="success" title="úspěch"> %}
`success` poznámka.
{% </admonition> %}

{% <admonition type="question" title="otázka"> %}
`question` poznámka.
{% </admonition> %}

{% <admonition type="warning" title="varování"> %}
`warning` poznámka.
{% </admonition> %}

{% <admonition type="failure" title="neúspěch"> %}
`failure` poznámka.
{% </admonition> %}

{% <admonition type="danger" title="nebezpečí"> %}
`danger` poznámka.
{% </admonition> %}

{% <admonition type="bug" title="chyba"> %}
`bug` poznámka.
{% </admonition> %}

{% <admonition type="example" title="příklad"> %}
`example` poznámka.
{% </admonition> %}

{% <admonition type="quote" title="citace"> %}
`quote` poznámka.
{% </admonition> %}

## Galerie

Komponenta `<gallery />` je velmi jednoduchá, klikatelná obrázková galerie (pouze HTML), která zobrazuje všechny obrázky z prostředků stránky (page assets).

Pochází z [dokumentace Zoly](https://www.getzola.org/documentation/content/image-processing/)

```markdown
{% raw %}{{ <gallery /> }}{% endraw %}
```

{{ <gallery page config alt="Ukázkový obrázek pro galerii" /> }}

## Projekty

Komponenta `<projects />` vám umožní vytvořit stránku pro vaše projekty.

Vytvořte soubor `content/pages/projects/index.md`:

```markdown
+++
title = "Moje projekty"
description = ""
path = "projects"
+++

{% raw %}{{ <projects path="data.toml" format="toml" page config /> }}{% endraw %}
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

{{ <projects path="projects.toml" format="toml" page config /> }}
