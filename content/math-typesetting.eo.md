+++
title = "Matematika Kompostado"
description = "Mallonga gvidilo por agordi KaTeX."
date = 2022-10-20
updated = 2024-10-24
[taxonomies]
authors = ["kita", "salif"]
[extra]
math = true
+++

La temo Linkita subtenas $\LaTeX$ matematikajn formulojn per [KaTeX](https://katex.org/).

<!--more-->

- Por ebligi KaTeX tutmonde, agordu la parametron `extra.math` al `true` en la agordo de projekto.
- Por ebligi KaTeX popaĝe, inkluzivu la parametron `extra.math = true` en la antaŭaferoj (frontmatter) de enhavaj dosieroj.

**Rimarko:** Uzu la retan referencon de [Subtenataj TeX Funkcioj](https://katex.org/docs/supported.html).

## Ekzemploj

### Enlinia matematiko

```markdown
Kiam $x = \pi$, la formulo de Euler povas esti reskribita kiel $e^{i \pi} + 1 = 0$.
```

Kiam $x = \pi$, la formulo de Euler povas esti reskribita kiel $e^{i \pi} + 1 = 0$.

### Bloka matematiko

```markdown
$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
```

$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
