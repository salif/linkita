+++
title = "Matemaattinen ladonta"
description = "Lyhyt opas KaTeXin käyttöönottoon."
date = 2022-10-20
#updated =
[taxonomies]
authors = ["kita", "salif"]
[extra]
math = true
+++

Linkita-teema tukee $\LaTeX$-matematiikkakaavoja [KaTeXin](https://katex.org/) avulla.

<!--more-->

- Ota KaTeX käyttöön globaalisti asettamalla projektin asetuksissa parametri `extra.math` arvoon `true`.
- Ota KaTeX käyttöön sivukohtaisesti lisäämällä parametri `extra.math = true` sisältötiedostojen frontmatter-osioon.

**Huomautus:** Käytä verkkolähdettä [Tuetut TeX-funktiot](https://katex.org/docs/supported.html).

## Esimerkit

### Matematiikkaa tekstin seassa

```markdown
Kun $x = \pi$, Eulerin kaava voidaan kirjoittaa muodossa $e^{i \pi} + 1 = 0$.
```

Kun $x = \pi$, Eulerin kaava voidaan kirjoittaa muodossa $e^{i \pi} + 1 = 0$.

### Matematiikkaa lohkona

```markdown
$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
```

$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
