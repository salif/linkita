+++
title = "Shortcodes"
description = "Les shortcodes du thème Linkita."
date = 2022-10-20
updated = 2025-04-20
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["kita", "salif"]
[extra]
mermaid = true
+++

Le thème Linkita fournit plusieurs shortcodes.

Jamais entendu parler des shortcodes ? Consultez la [documentation de Zola](https://www.getzola.org/documentation/content/shortcodes/) pour plus d'informations.

## Mermaid {#mermaid-header}

Pour utiliser Mermaid dans votre page, vous devez définir `extra.mermaid = true` dans le frontmatter de la page.

```toml
+++
title = "Le titre de votre page"

[extra]
mermaid = true
+++
```

Ensuite, vous pouvez utiliser les shortcodes `mermaid()` comme ceci :

```markdown
{%/* mermaid() */%}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{%/* end */%}
```

Ceci sera rendu comme :

{% mermaid() %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% end %}

De plus, vous pouvez utiliser un bloc de code à l'intérieur des shortcodes `mermaid()` et le bloc de code sera ignoré.

Le bloc de code empêche le formateur de casser la mise en forme de Mermaid.

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

Ceci sera rendu comme :

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

Le shortcode `admonition()` affiche une bannière pour vous aider à mettre en évidence une notice sur votre page.

Vous pouvez utiliser le shortcode `admonition()` comme ceci :

```markdown
{%/* admonition(type="tip", title="conseil") */%}
L'admonition `tip`.
{%/* end */%}
```

Le shortcode admonition a 12 types différents :

{% admonition(type="note", title="note") %}
L'admonition `note`.
{% end %}

{% admonition(type="abstract", title="abstract") %}
L'admonition `abstract`.
{% end %}

{% admonition(type="info", title="info") %}
L'admonition `info`.
{% end %}

{% admonition(type="tip", title="conseil") %}
L'admonition `tip`.
{% end %}

{% admonition(type="success", title="succès") %}
L'admonition `success`.
{% end %}

{% admonition(type="question", title="question") %}
L'admonition `question`.
{% end %}

{% admonition(type="warning", title="attention") %}
L'admonition `warning`.
{% end %}

{% admonition(type="failure", title="échec") %}
L'admonition `failure`.
{% end %}

{% admonition(type="danger", title="danger") %}
L'admonition `danger`.
{% end %}

{% admonition(type="bug", title="bug") %}
L'admonition `bug`.
{% end %}

{% admonition(type="example", title="exemple") %}
L'admonition `example`.
{% end %}

{% admonition(type="quote", title="citation") %}
L'admonition `quote`.
{% end %}

## Galerie

Le shortcode `gallery()` est une galerie d'images cliquables très simple, en HTML uniquement, qui affiche toutes les images des ressources de la page.

Il provient de la [documentation de Zola](https://www.getzola.org/documentation/content/image-processing/)

```markdown
{{/* gallery() */}}
```

{{ gallery(alt="Image de démo pour la galerie") }}

## Projets

Le shortcode `projects()` vous permet de créer une page pour vos projets.

Créez un fichier `content/pages/projects/index.md` :

```markdown
+++
title = "Mes Projets"
description = ""
path = "projets"
+++

{{/* projects(path="data.toml", format="toml") */}}
```

Créez un fichier `content/pages/projects/data.toml` :

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

Ceci sera affiché comme :

{{ projects(path="projects.toml", format="toml") }}
