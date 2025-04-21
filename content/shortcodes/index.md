+++
title = "Шорткодове"
description = "Шорткодовете на темата Линкита."
date = 2022-10-20
updated = 2025-04-20
[taxonomies]
tags = ["маркдаун", "css", "html"]
authors = ["salif"]
[extra]
mermaid = true
+++

Темата Линкита предоставя множество шорткодове.

Ако не сте чували за шорткодове, вижте [документацията на Зола](https://www.getzola.org/documentation/content/shortcodes/) за повече информация.

## Mermaid {#mermaid-header}

За да използвате Mermaid във вашата страница, трябва да зададете `extra.mermaid = true` в предните данни (frontmatter) на страницата.

```toml
+++
title = "Заглавие"

[extra]
mermaid = true
+++
```

След това можете да използвате шорткодовете `mermaid()` ето така:

```markdown
{%/* mermaid() */%}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{%/* end */%}
```

Това ще бъде изобразено така:

{% mermaid() %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% end %}

Освен това, можете да използвате блок с код вътре в шорткодовете `mermaid()` и блокът с код ще бъде игнориран.

Блокът с код предотвратява форматирането на Mermaid от форматиращия инструмент.

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

Това ще бъде изобразено така:

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

## Предупреждение

Шорткодът `admonition()` показва банер, който ви помага да поставите известие на вашата страница.

Можете да използвате шорткодът `admonition()` по този начин:

```markdown
{%/* admonition(type="tip", title="съвет") */%}
Предупреждението `tip`.
{%/* end */%}
```

Шорткодът `admonition` има 12 различни типа:

{% admonition(type="note", title="бележка") %}
Предупреждението `note`.
{% end %}

{% admonition(type="abstract", title="резюме") %}
Предупреждението `abstract`.
{% end %}

{% admonition(type="info", title="информация") %}
Предупреждението `info`.
{% end %}

{% admonition(type="tip", title="съвет") %}
Предупреждението `tip`.
{% end %}

{% admonition(type="success", title="успех") %}
Предупреждението `success`.
{% end %}

{% admonition(type="question", title="въпрос") %}
Предупреждението `question`.
{% end %}

{% admonition(type="warning", title="предупреждение") %}
Предупреждението `warning`.
{% end %}

{% admonition(type="failure", title="грешка") %}
Предупреждението `failure`.
{% end %}

{% admonition(type="abstract", title="опасност") %}
Предупреждението `danger`.
{% end %}

{% admonition(type="bug", title="бъг") %}
Предупреждението `bug`.
{% end %}

{% admonition(type="example", title="пример") %}
Предупреждението `example`.
{% end %}

{% admonition(type="quote", title="цитат") %}
Предупреждението `quote`.
{% end %}

## Галерия

Шорткодът `gallery()` е много проста, само с HTML, галерия с изображения, която показва всички изображения от „assets“ на страницата.

Взето е от [документацията на Зола](https://www.getzola.org/documentation/content/image-processing/)

```markdown
{{/* gallery() */}}
```

{{ gallery(alt="Демо изображение за галерията") }}


## Проекти

Шорткодът `projects()` ви позволява да създадете страница за вашите проекти.

Създайте файл `content/pages/projects/index.md`:

```markdown
+++
title = "Моите проекти"
description = ""
path = "projects"
+++

{{/* projects(path="data.toml", format="toml") */}}
```

Създайте файл `content/pages/projects/data.toml`:

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

Това ще бъде показано така:

{{ projects(path="projects.toml", format="toml") }}
