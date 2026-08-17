+++
title = "Composants"
description = "Comment utiliser les composants"
date = 2022-10-20
updated = 2026-08-16
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["salif"]
[extra]
mermaid = true
+++

Le thème Linkita fournit plusieurs composants.

Jamais entendu parler des composants ? Consultez la [documentation de Zola](https://keats.github.io/tera/#components) pour plus d'informations.

## Composant Mermaid

Pour utiliser Mermaid dans votre page, vous devez définir `extra.mermaid = true` dans le frontmatter de la page.

```toml
+++
title = "Le titre de votre page"

[extra]
mermaid = true
+++
```

Ensuite, vous pouvez utiliser le composant `<mermaid>` comme ceci :

```markdown
{% raw %}{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}{% endraw %}
```

Ceci sera rendu comme :

{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}

De plus, vous pouvez utiliser un bloc de code à l'intérieur des composants `<mermaid>` et le bloc de code sera ignoré.

Le bloc de code empêche le formateur de casser la mise en forme de Mermaid.

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

Ceci sera rendu comme :

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

Le composant `<admonition>` affiche une bannière pour vous aider à mettre en évidence une notice sur votre page.

Vous pouvez utiliser le composant comme ceci :

```markdown
{% raw %}{% <admonition type="tip" title="conseil"> %}
L'admonition `tip`.
{% </admonition> %}{% endraw %}
```

Le composant admonition a 12 types différents :

{% <admonition type="note" title="note"> %}
L'admonition `note`.
{% </admonition> %}

{% <admonition type="abstract" title="abstract"> %}
L'admonition `abstract`.
{% </admonition> %}

{% <admonition type="info" title="info"> %}
L'admonition `info`.
{% </admonition> %}

{% <admonition type="tip" title="conseil"> %}
L'admonition `tip`.
{% </admonition> %}

{% <admonition type="success" title="succès"> %}
L'admonition `success`.
{% </admonition> %}

{% <admonition type="question" title="question"> %}
L'admonition `question`.
{% </admonition> %}

{% <admonition type="warning" title="attention"> %}
L'admonition `warning`.
{% </admonition> %}

{% <admonition type="failure" title="échec"> %}
L'admonition `failure`.
{% </admonition> %}

{% <admonition type="danger" title="danger"> %}
L'admonition `danger`.
{% </admonition> %}

{% <admonition type="bug" title="bug"> %}
L'admonition `bug`.
{% </admonition> %}

{% <admonition type="example" title="exemple"> %}
L'admonition `example`.
{% </admonition> %}

{% <admonition type="quote" title="citation"> %}
L'admonition `quote`.
{% </admonition> %}

## Galerie

Le composant `<gallery />` est une galerie d'images cliquables très simple, en HTML uniquement, qui affiche toutes les images des ressources de la page.

Il provient de la [documentation de Zola](https://www.getzola.org/documentation/content/image-processing/)

```markdown
{% raw %}{{ <gallery /> }}{% endraw %}
```

{{ <gallery page config alt="Image de démo pour la galerie" /> }}

## Projets

Le composant `<projects />` vous permet de créer une page pour vos projets.

Créez un fichier `content/pages/projects/index.md` :

```markdown
+++
title = "Mes Projets"
description = ""
path = "projets"
+++

{% raw %}{{ <projects path="data.toml" format="toml" page config /> }}{% endraw %}
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

{{ <projects path="projects.toml" format="toml" page config /> }}
