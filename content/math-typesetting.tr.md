+++
title = "Matematiksel Dizgi"
description = "KaTeX kurulumu için kısa bir rehber."
date = 2022-10-20
updated = 2025-01-23
[taxonomies]
authors = ["kita", "salif"]
[extra]
math = true
+++

Linkita teması, [KaTeX](https://katex.org/) kullanarak $\LaTeX$ matematiksel formüllerini destekler.

<!--more-->

- KaTeX'i global olarak etkinleştirmek için, proje yapılandırmanızda `extra.math` parametresini `true` olarak ayarlayın.
- KaTeX'i sayfa bazında etkinleştirmek için, içerik dosyalarının ön yüzünde `extra.math = true` parametresini ekleyin.

**Not:** [Desteklenen TeX Fonksiyonları](https://katex.org/docs/supported.html) çevrimiçi referansını kullanın.

## Örnekler

### Satır içi matematik

```markdown
Eğer $x = \pi$ ise, Euler formülü $e^{i \pi} + 1 = 0$ olarak yeniden yazılabilir.
```

Eğer $x = \pi$ ise, Euler formülü $e^{i \pi} + 1 = 0$ olarak yeniden yazılabilir.

### Blok matematik

```markdown
$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
```

$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
