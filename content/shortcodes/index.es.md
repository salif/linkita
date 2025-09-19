+++
title = "Shortcodes"
description = "Los shortcodes del tema Linkita."
date = 2022-10-20
updated = 2025-04-20
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["kita", "salif"]
[extra]
mermaid = true
+++

El tema Linkita proporciona múltiples shortcodes.

¿Nunca has oído hablar de los shortcodes? Consulta la [documentación de Zola](https://www.getzola.org/documentation/content/shortcodes/) para más información.

## Mermaid {#mermaid-header}

Para usar Mermaid en tu página, tienes que establecer `extra.mermaid = true` en el frontmatter de la página.

```toml
+++
title = "El título de tu página"

[extra]
mermaid = true
+++
```

Luego puedes usar los shortcodes `mermaid()` así:

```markdown
{%/* mermaid() */%}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{%/* end */%}
```

Esto se renderizará como:

{% mermaid() %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% end %}

Además, puedes usar un bloque de código dentro de los shortcodes `mermaid()` y el bloque de código será ignorado.

El bloque de código evita que el formateador rompa el formato de Mermaid.

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

Esto se renderizará como:

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

## Admonition

El shortcode `admonition()` muestra un banner para ayudarte a poner avisos en tu página.

Puedes usar el shortcode `admonition()` así:

```markdown
{%/* admonition(type="tip", title="consejo") */%}
La admonition de tipo `tip`.
{%/* end */%}
```

El shortcode de admonition tiene 12 tipos diferentes:

{% admonition(type="note", title="nota") %}
La admonition de tipo `note`.
{% end %}

{% admonition(type="abstract", title="resumen") %}
La admonition de tipo `abstract`.
{% end %}

{% admonition(type="info", title="información") %}
La admonition de tipo `info`.
{% end %}

{% admonition(type="tip", title="consejo") %}
La admonition de tipo `tip`.
{% end %}

{% admonition(type="success", title="éxito") %}
La admonition de tipo `success`.
{% end %}

{% admonition(type="question", title="pregunta") %}
La admonition de tipo `question`.
{% end %}

{% admonition(type="warning", title="advertencia") %}
La admonition de tipo `warning`.
{% end %}

{% admonition(type="failure", title="fallo") %}
La admonition de tipo `failure`.
{% end %}

{% admonition(type="danger", title="peligro") %}
La admonition de tipo `danger`.
{% end %}

{% admonition(type="bug", title="error") %}
La admonition de tipo `bug`.
{% end %}

{% admonition(type="example", title="ejemplo") %}
La admonition de tipo `example`.
{% end %}

{% admonition(type="quote", title="cita") %}
La admonition de tipo `quote`.
{% end %}

## Galería

El shortcode `gallery()` es una galería de imágenes clicable muy simple, solo con HTML, que muestra todas las imágenes de los assets de la página.

Proviene de la [documentación de Zola](https://www.getzola.org/documentation/content/image-processing/)

```markdown
{{/* gallery() */}}
```

{{ gallery(alt="Imagen de demostración para la galería") }}

## Proyectos

El shortcode `projects()` te permite crear una página para tu proyecto.

Crea un archivo `content/pages/projects/index.md`:

```markdown
+++
title = "Mis Proyectos"
description = ""
path = "projects"
+++

{{/* projects(path="data.toml", format="toml") */}}
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

{{ projects(path="projects.toml", format="toml") }}
