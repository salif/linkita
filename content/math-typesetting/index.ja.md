+++
title = "数式組版"
description = "KaTeXのセットアップに関する簡単なガイドです。"
date = 2022-10-20
#updated =
[taxonomies]
authors = ["kita", "salif"]
[extra]
math = true
+++

Linkitaテーマは [KaTeX](https://katex.org/) を利用して $\LaTeX$ の数式をサポートします。

<!--more-->

- KaTeXをサイト全体で有効にするには、プロジェクトの設定で `extra.math` パラメータを `true` に設定します。
- ページごとにKaTeXを有効にするには、コンテンツファイルのフロントマターに `extra.math = true` パラメータを含めます。

**注：** オンラインリファレンスの[サポートされているTeX関数](https://katex.org/docs/supported.html) を参照してください。

## 例

### インライン数式

```markdown
$x = \pi$ のとき、オイラーの公式は $e^{i \pi} + 1 = 0$ と書き換えられます。
```

$x = \pi$ のとき、オイラーの公式は $e^{i \pi} + 1 = 0$ と書き換えられます。

### ブロック数式

```markdown
$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
```

$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
