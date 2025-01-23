+++
title = "Markdown 语法指南"
description = "示例文章，展示了 HTML 元素的基本 Markdown 语法和格式。"
date = 2022-10-20
updated = 2025-01-23
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["kita", "salif"]
[extra]
[extra.cover]
image = "images/markdown-syntax.png"
alt = "Markdown 标志"
width = 1600
height = 800
+++

本文提供了一个基本的 Markdown 语法示例，这些语法可以在 Zola 内容文件中使用。同时，本文也展示了基本的 HTML 元素在 林基塔 主题中是否会使用 CSS 进行装饰。

<!--more-->

## 标题

以下 HTML `<h1>`—`<h6>` 元素代表了六个级别的章节标题。`<h1>` 是最高的章节级别，而 `<h6>` 是最低的级别。

# H1

## H2

### H3

#### H4

##### H5

###### H6

## 段落

Xerum, quo qui aut unt expliquam qui dolut labo. Aque venitatiusda cum, voluptionse latur sitiae dolessi aut parist aut dollo enim qui voluptate ma dolestendit peritin re plis aut quas inctum laceat est volestemque commosa as cus endigna tectur, offic to cor sequas etum rerum idem sintibus eiur? Quianimin porecus evelectur, cum que nis nust voloribus ratem aut omnimi, sitatur? Quiatem. Nam, omnis sum am facea corem alique molestrunt et eos evelece arcillit ut aut eos eos nus, sin conecerem erum fuga. Ri oditatquam, ad quibus unda veliamenimin cusam et facea ipsamus es exerum sitate dolores editium rerore eost, temped molorro ratiae volorro te reribus dolorer sperchicium faceata tiustia prat.

Itatur? Quiatae cullecum rem ent aut odis in re eossequodi nonsequ idebis ne sapicia is sinveli squiatum, core et que aut hariosam ex eat.

## 引用块

引用块元素表示从另一个来源引用的内容，可以选择包含引文，引文必须位于 `footer` 或 `cite` 元素内，并且可以选择包含内联更改，例如注释和缩写。

#### 没有署名的引用块

> Tiam, ad mint andaepu dandae nostion secatur sequo quae.
> **注意** 你可以在引用块中使用 _Markdown 语法_。

#### 带有署名的引用块

> 不要通过共享内存来沟通，通过沟通来共享内存。<br>
> — <cite>Rob Pike[^1]</cite>

[^1]: 上述引言摘自 Rob Pike 在 2015 年 11 月 18 日 Gopherfest 大会上的 [演讲](https://www.youtube.com/watch?v=PAAkCSZUG1c)。

## 链接

要创建链接，请将链接文本放在方括号中，然后在紧随其后用圆括号括起 URL。

[GitHub](https://github.com)

要快速将 URL 或电子邮件地址转换为链接，请将其括在尖括号中。

<https://github.com>

## 图片

![Markdown 指南](../../images/markdown-syntax.png)

## 表格

表格不是核心 Markdown 规范的一部分，但 Zola 开箱即用地支持它们。

| 名称  | 年龄 |
| ----- | --- |
| Bob   | 27  |
| Alice | 23  |

#### 表格内的内联 Markdown

| 斜体   | 粗体     | 代码   |
| --------- | -------- | ------ |
| _斜体_ | **粗体** | `代码` |

## 代码块

#### 使用反引号的代码块

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Example HTML5 Document</title>
  </head>
  <body>
    <p>Test</p>
  </body>
</html>
```

#### 使用四个空格缩进的代码块

    <!doctype html>
    <html lang="en">
    <head>
      <meta charset="utf-8">
      <title>Example HTML5 Document</title>
    </head>
    <body>
      <p>Test</p>
    </body>
    </html>

## 列表类型

#### 有序列表

1. 第一项
2. 第二项
3. 第三项

#### 无序列表

- 列表项
- 另一项
- 还有一项

#### 嵌套列表

- 水果
  - 苹果
  - 橙子
  - 香蕉
- 奶制品
  - 牛奶
  - 奶酪

## 其他元素 — abbr, sub, sup, kbd, mark

<abbr title="图形交换格式">GIF</abbr> 是一种位图图像格式。

H<sub>2</sub>O

X<sup>n</sup> + Y<sup>n</sup> = Z<sup>n</sup>

按下 <kbd><kbd>CTRL</kbd>+<kbd>ALT</kbd>+<kbd>Delete</kbd></kbd> 以结束会话。

大多数 <mark>蝾螈</mark> 是夜行动物，捕食昆虫、蠕虫和其他小型生物。
