+++
title = "Komponentoj"
description = "Kiel uzi la komponentojn"
date = 2022-10-20
updated = 2026-08-16
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["salif"]
[extra]
mermaid = true
+++

La temo Linkita provizas plurajn komponentojn.

Ĉu vi neniam aŭdis pri komponentoj? Vidu la [dokumentaron de Zola](https://keats.github.io/tera/#components) por pli da informoj.

## Mermaid-komponento

Por uzi Mermaid en via paĝo, vi devas agordi `extra.mermaid = true` en la antaŭaĵo (frontmatter) de la paĝo.

```toml
+++
title = "Titolo"

[extra]
mermaid = true
+++
```

Tiam vi povas uzi la komponenton `<mermaid>` jene:

```markdown
{% raw %}{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}{% endraw %}
```

Ĉi tio estos montrata tiel:

{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}

Krome, vi povas uzi kodblokon ene de la komponentoj `<mermaid>` kaj la kodbloko estos ignorata.

La kodbloko malhelpas ke la formatilo rompu la formatadon de Mermaid.

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

Ĉi tio estos montrata tiel:

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

## Admono

La komponento `<admonition>` montras rubandon por helpi vin meti atentigon en vian paĝon.

Vi povas uzi la komponenton jene:

```markdown
{% raw %}{% <admonition type="tip" title="konsileto"> %}
La admono `konsileto`.
{% </admonition> %}{% endraw %}
```

La komponento de admono havas 12 diversajn tipojn:

{% <admonition type="note" title="noto"> %}
La admono `noto`.
{% </admonition> %}

{% <admonition type="abstract" title="resumo"> %}
La admono `resumo`.
{% </admonition> %}

{% <admonition type="info" title="informo"> %}
La admono `informo`.
{% </admonition> %}

{% <admonition type="tip" title="konsileto"> %}
La admono `konsileto`.
{% </admonition> %}

{% <admonition type="success" title="sukceso"> %}
La admono `sukceso`.
{% </admonition> %}

{% <admonition type="question" title="demando"> %}
La admono `demando`.
{% </admonition> %}

{% <admonition type="warning" title="averto"> %}
La admono `averto`.
{% </admonition> %}

{% <admonition type="failure" title="malsukceso"> %}
La admono `malsukceso`.
{% </admonition> %}

{% <admonition type="danger" title="danĝero"> %}
La admono `danĝero`.
{% </admonition> %}

{% <admonition type="bug" title="cimo"> %}
La admono `cimo`.
{% </admonition> %}

{% <admonition type="example" title="ekzemplo"> %}
La admono `ekzemplo`.
{% </admonition> %}

{% <admonition type="quote" title="citaĵo"> %}
La admono `citaĵo`.
{% </admonition> %}

## Galerio

La komponento `<gallery />` estas tre simpla nur-HTML-a klakebla bildgalerio, kiu montras ĉiujn bildojn el la paĝaj aktivaĵoj (assets).

Ĝi estas el la [dokumentaro de Zola](https://www.getzola.org/documentation/content/image-processing/)

```markdown
{% raw %}{{ <gallery /> }}{% endraw %}
```

{{ <gallery page config alt="Demobildo por la galerio" /> }}

## Projektoj

La komponento `<projects />` ebligas al vi krei paĝon por viaj projektoj.

Kreu dosieron `content/pages/projects/index.md`:

```markdown
+++
title = "Miaj Projektoj"
description = ""
path = "projects"
+++

{% raw %}{{ <projects path="data.toml" format="toml" page config /> }}{% endraw %}
```

Kreu dosieron `content/pages/projects/data.toml`:

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

Ĉi tio estos montrata jene:

{{ <projects path="projects.toml" format="toml" page config /> }}
