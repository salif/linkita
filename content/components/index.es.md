+++
title = "Componentes"
description = "Cómo usar los componentes"
date = 2022-10-20
updated = 2026-08-16
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["salif"]
[extra]
mermaid = true
+++

El tema Linkita proporciona múltiples componentes.

¿Nunca has oído hablar de los componentes? Consulta la [documentación de Zola](https://keats.github.io/tera/#components) para más información.

## Componente Mermaid

Para usar Mermaid en tu página, tienes que establecer `extra.mermaid = true` en el frontmatter de la página.

```toml
+++
title = "El título de tu página"

[extra]
mermaid = true
+++
```

Luego puedes usar el componente `<mermaid>` así:

```markdown
{% raw %}{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}{% endraw %}
```

Esto se renderizará como:

{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}

Además, puedes usar un bloque de código dentro de los componentes `<mermaid>` y el bloque de código será ignorado.

El bloque de código evita que el formateador rompa el formato de Mermaid.

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

Esto se renderizará como:

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

El componente `<admonition>` muestra un banner para ayudarte a poner avisos en tu página.

Puedes usar el componente así:

```markdown
{% raw %}{% <admonition type="tip" title="consejo"> %}
La admonition de tipo `tip`.
{% </admonition> %}{% endraw %}
```

El componente de admonition tiene 12 tipos diferentes:

{% <admonition type="note" title="nota"> %}
La admonition de tipo `note`.
{% </admonition> %}

{% <admonition type="abstract" title="resumen"> %}
La admonition de tipo `abstract`.
{% </admonition> %}

{% <admonition type="info" title="información"> %}
La admonition de tipo `info`.
{% </admonition> %}

{% <admonition type="tip" title="consejo"> %}
La admonition de tipo `tip`.
{% </admonition> %}

{% <admonition type="success" title="éxito"> %}
La admonition de tipo `success`.
{% </admonition> %}

{% <admonition type="question" title="pregunta"> %}
La admonition de tipo `question`.
{% </admonition> %}

{% <admonition type="warning" title="advertencia"> %}
La admonition de tipo `warning`.
{% </admonition> %}

{% <admonition type="failure" title="fallo"> %}
La admonition de tipo `failure`.
{% </admonition> %}

{% <admonition type="danger" title="peligro"> %}
La admonition de tipo `danger`.
{% </admonition> %}

{% <admonition type="bug" title="error"> %}
La admonition de tipo `bug`.
{% </admonition> %}

{% <admonition type="example" title="ejemplo"> %}
La admonition de tipo `example`.
{% </admonition> %}

{% <admonition type="quote" title="cita"> %}
La admonition de tipo `quote`.
{% </admonition> %}

## Galería

El componente `<gallery />` es una galería de imágenes clicable muy simple, solo con HTML, que muestra todas las imágenes de los assets de la página.

Proviene de la [documentación de Zola](https://www.getzola.org/documentation/content/image-processing/)

```markdown
{% raw %}{{ <gallery /> }}{% endraw %}
```

{{ <gallery page config alt="Imagen de demostración para la galería" /> }}

## Proyectos

El componente `<projects />` te permite crear una página para tus proyectos.

Crea un archivo `content/pages/projects/index.md`:

```markdown
+++
title = "Mis Proyectos"
description = ""
path = "projects"
+++

{% raw %}{{ <projects path="data.toml" format="toml" page config /> }}{% endraw %}
```

Crea un archivo `content/pages/projects/data.toml`:

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

Esto se mostrará como:

{{ <projects path="projects.toml" format="toml" page config /> }}
