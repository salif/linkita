+++
title = "Компоненти"
description = "Как се използват компонентите"
date = 2022-10-20
updated = 2026-08-16
[taxonomies]
tags = ["маркдаун", "css", "html"]
authors = ["salif"]
[extra]
mermaid = true
+++

Темата Линкита предоставя множество компоненти.

Ако не сте чували за компоненти, вижте [документацията на Зола](https://keats.github.io/tera/#components) за повече информация.

## Mermaid диаграми

За да използвате Mermaid във вашата страница, трябва да зададете `extra.mermaid = true` в предните данни (frontmatter) на страницата.

```toml
+++
title = "Заглавие"

[extra]
mermaid = true
+++
```

След това можете да използвате компонента `<mermaid>` ето така:

```markdown
{% raw %}{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}{% endraw %}
```

Това ще бъде изобразено така:

{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}

Освен това, можете да използвате блок с код вътре в компонентите и блокът с код ще бъде игнориран.

Блокът с код предотвратява форматирането на Mermaid от форматиращия инструмент.

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

Това ще бъде изобразено така:

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

## Предупреждения

Компонентът `<admonition>` показва банер, който ви помага да поставите известие на вашата страница.

Можете да използвате компонента по този начин:

```markdown
{% raw %}{% <admonition type="tip" title="съвет"> %}
Предупреждението `tip`.
{% </admonition> %}{% endraw %}
```

Компонентът има 12 различни типа:

{% <admonition type="note" title="бележка"> %}
Предупреждението `note`.
{% </admonition> %}

{% <admonition type="abstract" title="резюме"> %}
Предупреждението `abstract`.
{% </admonition> %}

{% <admonition type="info" title="информация"> %}
Предупреждението `info`.
{% </admonition> %}

{% <admonition type="tip" title="съвет"> %}
Предупреждението `tip`.
{% </admonition> %}

{% <admonition type="success" title="успех"> %}
Предупреждението `success`.
{% </admonition> %}

{% <admonition type="question" title="въпрос"> %}
Предупреждението `question`.
{% </admonition> %}

{% <admonition type="warning" title="предупреждение"> %}
Предупреждението `warning`.
{% </admonition> %}

{% <admonition type="failure" title="грешка"> %}
Предупреждението `failure`.
{% </admonition> %}

{% <admonition type="danger" title="опасност"> %}
Предупреждението `danger`.
{% </admonition> %}

{% <admonition type="bug" title="бъг"> %}
Предупреждението `bug`.
{% </admonition> %}

{% <admonition type="example" title="пример"> %}
Предупреждението `example`.
{% </admonition> %}

{% <admonition type="quote" title="цитат"> %}
Предупреждението `quote`.
{% </admonition> %}

## Галерия

Компонентът `<gallery />` е много проста галерия с изображения, която показва всички изображения от „assets“ на страницата.

Взето е от [документацията на Зола](https://www.getzola.org/documentation/content/image-processing/)
```markdown
{% raw %}{{ <gallery /> }}{% endraw %}
```

{{ <gallery page config alt="Демо изображение за галерията" /> }}

## Проекти

Компонентът `<projects />` ви позволява да създадете страница за вашите проекти.

Създайте файл `content/pages/projects/index.md`:

```markdown
+++
title = "Моите проекти"
description = ""
path = "projects"
+++

{% raw %}{{ <projects path="data.toml" format="toml" page config /> }}{% endraw %}
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

{{ <projects path="projects.toml" format="toml" page config /> }}
