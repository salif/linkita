+++
title = "Mallongigoj"
date = 2022-10-20
updated = 2024-10-24
description = "La mallongigoj de la temo Linkita."
[taxonomies]
tags = ["markdown", "css", "html"]
[extra]
mermaid = true
+++

La temo Linkita provizas plurajn mallongigojn.

Ĉu vi neniam aŭdis pri mallongigoj? Vidu la [dokumentaron de Zola](https://www.getzola.org/documentation/content/shortcodes/) por pli da informoj.

## Mermaid

Por uzi Mermaid en via paĝo, vi devas agordi `extra.mermaid = true` en la antaŭaĵo (frontmatter) de la paĝo.

```markdown
+++
title = "La titolo de via paĝo"

[extra]
mermaid = true
+++
```

Tiam vi povas uzi la mallongigon `mermaid()` jene:

```markdown
{%/* mermaid() */%}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{%/* end */%}
```

Ĉi tio estos montrata tiel:

{% mermaid() %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% end %}

Krome, vi povas uzi kodblokon ene de la mallongigo `mermaid()` kaj la kodbloko estos ignorata.

La kodbloko malhelpas ke la formatilo rompu la formatadon de Mermaid.

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

Ĉi tio estos montrata tiel:

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

## Admono

La mallongigo `admonition()` montras rubandon por helpi vin meti atentigon en vian paĝon.

Vi povas uzi la mallongigon `admonition()` jene:

```markdown
{%/* admonition(type="tip", title="konsileto") */%}
La admono `konsileto`.
{%/* end */%}
```

La mallongigo `admonition` havas 12 diversajn tipojn:

{% admonition(type="note", title="noto") %}
La admono `noto`.
{% end %}

{% admonition(type="abstract", title="resumo") %}
La admono `resumo`.
{% end %}

{% admonition(type="info", title="informo") %}
La admono `informo`.
{% end %}

{% admonition(type="tip", title="konsileto") %}
La admono `konsileto`.
{% end %}

{% admonition(type="success", title="sukceso") %}
La admono `sukceso`.
{% end %}

{% admonition(type="question", title="demando") %}
La admono `demando`.
{% end %}

{% admonition(type="warning", title="averto") %}
La admono `averto`.
{% end %}

{% admonition(type="failure", title="malsukceso") %}
La admono `malsukceso`.
{% end %}

{% admonition(type="abstract", title="danĝero") %}
La admono `danĝero`.
{% end %}

{% admonition(type="bug", title="cimo") %}
La admono `cimo`.
{% end %}

{% admonition(type="example", title="ekzemplo") %}
La admono `ekzemplo`.
{% end %}

{% admonition(type="quote", title="citaĵo") %}
La admono `citaĵo`.
{% end %}

## Galerio

La mallongigo `gallery()` estas tre simpla nur-HTML-a klakebla bildgalerio, kiu montras ĉiujn bildojn el la paĝaj aktivaĵoj (assets).

Ĝi estas el la [dokumentaro de Zola](https://www.getzola.org/documentation/content/image-processing/)

```markdown
{{/* gallery() */}}
```

{{ gallery() }}
