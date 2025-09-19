+++
title = "Composición de Fórmulas Matemáticas"
description = "Una breve guía para configurar KaTeX."
date = 2022-10-20
#updated =
[taxonomies]
authors = ["kita", "salif"]
[extra]
math = true
+++

El tema Linkita soporta fórmulas matemáticas de $\LaTeX$ usando [KaTeX](https://katex.org/).

<!--more-->

- Para habilitar KaTeX globalmente, establece el parámetro `extra.math` a `true` en la configuración del proyecto.
- Para habilitar KaTeX por página, incluye el parámetro `extra.math = true` en el frontmatter de los archivos de contenido.

**Nota:** Utiliza la referencia en línea de [Funciones TeX Soportadas](https://katex.org/docs/supported.html).

## Ejemplos

### Fórmulas en línea

```markdown
Cuando $x = \pi$, la fórmula de Euler se puede reescribir como $e^{i \pi} + 1 = 0$.
```

Cuando $x = \pi$, la fórmula de Euler se puede reescribir como $e^{i \pi} + 1 = 0$.

### Fórmulas en bloque

```markdown
$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
```

$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
