+++
title = "Typographie Mathématique"
description = "Un guide rapide pour configurer KaTeX."
date = 2022-10-20
#updated =
[taxonomies]
authors = ["kita", "salif"]
[extra]
math = true
+++

Le thème Linkita prend en charge les formules mathématiques $\LaTeX$ en utilisant [KaTeX](https://katex.org/).

<!--more-->

- Pour activer KaTeX globalement, définissez le paramètre `extra.math` sur `true` dans la configuration du projet.
- Pour activer KaTeX page par page, incluez le paramètre `extra.math = true` dans le frontmatter des fichiers de contenu.

**Note :** Utilisez la référence en ligne des [Fonctions TeX Supportées](https://katex.org/docs/supported.html).

## Exemples

### Maths en ligne

```markdown
Lorsque $x = \pi$, la formule d'Euler peut être réécrite ainsi : $e^{i \pi} + 1 = 0$.
```

Lorsque $x = \pi$, la formule d'Euler peut être réécrite ainsi : $e^{i \pi} + 1 = 0$.

### Maths en bloc

```markdown
$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
```

$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
