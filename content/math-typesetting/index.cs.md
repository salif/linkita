+++
title = "Sazba matematiky"
description = "Stručný průvodce nastavením KaTeX."
date = 2022-10-20
#updated =
[taxonomies]
authors = ["kita", "salif"]
[extra]
math = true
+++

Šablona Linkita podporuje matematické vzorce $\LaTeX$ pomocí [KaTeX](https://katex.org/).

<!--more-->

- Chcete-li povolit KaTeX globálně, nastavte v konfiguraci projektu parametr `extra.math` na `true`.
- Chcete-li povolit KaTeX pro jednotlivé stránky, vložte parametr `extra.math = true` do frontmatteru souborů s obsahem.

**Poznámka:** Použijte online referenci [Podporovaných TeX funkcí](https://katex.org/docs/supported.html).

## Příklady

### Vložená matematika

```markdown
Když $x = \pi$, Eulerův vzorec lze přepsat jako $e^{i \pi} + 1 = 0$.
```

Když $x = \pi$, Eulerův vzorec lze přepsat jako $e^{i \pi} + 1 = 0$.

### Bloková matematika

```markdown
$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
```

$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
