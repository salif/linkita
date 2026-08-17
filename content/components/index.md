+++
title = "Components"
description = "How to use the components"
date = 2022-10-20
updated = 2026-08-16
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["salif"]
[extra]
mermaid = true
+++

The Linkita theme providers multiple components.

Never heard of components? See [Zola documentation](https://keats.github.io/tera/#components) for more information.

## Mermaid component

To use Mermaid in your page, you have to set `extra.mermaid = true` in the frontmatter of page.

```toml
+++
title = "Your page title"

[extra]
mermaid = true
+++
```

Then you can use the `<mermaid>` component like:

```markdown
{% raw %}{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}{% endraw %}
```

This will be rendered as:

{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}

In addition, you can use code block inside `<mermaid>` components and the code block will be ignored.

The code block prevents formatter from breaking mermaid's formatting.

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

This will be rendered as:

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

## Admonition

The `<admonition>` component displays a banner to help you put notice in your page.

You can use the component like:

```markdown
{% raw %}{% <admonition type="tip" title="tip"> %}
The `tip` admonition.
{% </admonition> %}{% endraw %}
```

The admonition component has 12 different types:

{% <admonition type="note" title="note"> %}
The `note` admonition.
{% </admonition> %}

{% <admonition type="abstract" title="abstract"> %}
The `abstract` admonition.
{% </admonition> %}

{% <admonition type="info" title="info"> %}
The `info` admonition.
{% </admonition> %}

{% <admonition type="tip" title="tip"> %}
The `tip` admonition.
{% </admonition> %}

{% <admonition type="success" title="success"> %}
The `success` admonition.
{% </admonition> %}

{% <admonition type="question" title="question"> %}
The `question` admonition.
{% </admonition> %}

{% <admonition type="warning" title="warning"> %}
The `warning` admonition.
{% </admonition> %}

{% <admonition type="failure" title="failure"> %}
The `failure` admonition.
{% </admonition> %}

{% <admonition type="danger" title="danger"> %}
The `danger` admonition.
{% </admonition> %}

{% <admonition type="bug" title="bug"> %}
The `bug` admonition.
{% </admonition> %}

{% <admonition type="example" title="example"> %}
The `example` admonition.
{% </admonition> %}

{% <admonition type="quote" title="quote"> %}
The `quote` admonition.
{% </admonition> %}

## Gallery

The `<gallery />` component is very simple html-only clickable picture gallery that displays all images from the page assets.

It's from [Zola documentation](https://www.getzola.org/documentation/content/image-processing/)

```markdown
{% raw %}{{ <gallery /> }}{% endraw %}
```

{{ <gallery page config alt="Demo image for the gallery" /> }}

## Projects

The `<projects />` component allows you to make a page for your projects.

Create a `content/pages/projects/index.md` file:

```markdown
+++
title = "My Projects"
description = ""
path = "projects"
+++

{% raw %}{{ <projects path="data.toml" format="toml" page config /> }}{% endraw %}
```

Create a `content/pages/projects/data.toml` file:

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

This will be displayed as:

{{ <projects path="projects.toml" format="toml" page config /> }}
