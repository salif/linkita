+++
title = "数学排版"
description = "KaTeX 设置简要指南。"
date = 2022-10-20
updated = 2025-01-23
[taxonomies]
authors = ["kita", "salif"]
[extra]
math = true
+++

Linkita 主题支持使用 [KaTeX](https://katex.org/) 排版 $\LaTeX$ 数学公式。

<!--more-->

- 要全局启用 KaTeX，请在项目配置文件中将参数 `extra.math` 设置为 `true`。
- 要针对单个页面启用 KaTeX，请在内容文件的前言（frontmatter）中包含参数 `extra.math = true`。

**注意：** 请参考 [支持的 TeX 函数](https://katex.org/docs/supported.html) 在线文档。

## 示例

### 行内公式

```markdown
当 $x = \pi$ 时，欧拉公式可以重写为 $e^{i \pi} + 1 = 0$。
```

当 $x = \pi$ 时，欧拉公式可以重写为 $e^{i \pi} + 1 = 0$。

### 块级公式

```markdown
$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
```

$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
