+++
title = "Markdown構文ガイド"
description = "基本的なMarkdown構文とHTML要素のフォーマットを紹介するサンプル記事です。"
date = 2022-10-20
#updated =
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["kita", "salif"]
[extra]
[extra.cover]
image = "images/markdown-syntax.png"
alt = "Markdownのロゴ"
width = 1600
height = 800
+++

この記事では、Zolaのコンテンツファイルで使用できる基本的なMarkdown構文のサンプルを紹介します。また、Linkitaテーマで基本的なHTML要素がCSSでどのように装飾されるかも示します。

<!--more-->

## 見出し

以下のHTMLの `<h1>`～`<h6>` 要素は、6段階のセクション見出しを表します。 `<h1>` が最上位で、`<h6>` が最下位です。

# H1

## H2

### H3

#### H4

##### H5

###### H6

## 段落

これはダミーテキストです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。意義を問わないでください。意味がないと思ったら、好きなテキストに置き換えてください。これはダミーテキストです。文字の大きさ、量、字間、行間等を確認するために入れています。

これはダミーテキストです。この文章はダミーで、意味をなさないものです。デザインの観点からテキストがどのようになるかを示すためにここに置かれています。

## 引用

引用要素は、他の情報源から引用されたコンテンツを表します。任意で `footer` または `cite` 要素内に引用元を記載したり、注釈や省略などのインラインでの変更を加えたりすることができます。

#### 引用元のない引用

> これは引用文の例です。
> **注：** 引用ブロック内では _Markdown構文_ を使用できます。

#### 引用元のある引用

> メモリを共有して通信するのではなく、通信してメモリを共有せよ。<br>
> — <cite>Rob Pike[^1]</cite>

[^1]: 上記の引用は、2015年11月18日に行われたGopherfestでのRob Pikeの[講演](https://www.youtube.com/watch?v=PAAkCSZUG1c)から抜粋したものです。

## リンク

リンクを作成するには、リンクテキストを角括弧で囲み、その直後にURLを丸括弧で囲みます。

[GitHub](https://github.com)

URLやメールアドレスを素早くリンクに変換するには、山括弧で囲みます。

<https://github.com>

## 画像

![Markdown ガイド](../../images/markdown-syntax.png)

## テーブル

テーブルはMarkdownのコア仕様の一部ではありませんが、Zolaでは標準でサポートされています。

| 名前  | 年齢 |
| ----- | --- |
| ボブ   | 27  |
| アリス | 23  |

#### テーブル内のインラインMarkdown

| イタリック   | ボールド     | コード   |
| --------- | -------- | ------ |
| _italics_ | **bold** | `code` |

## コードブロック

#### バッククォートによるコードブロック

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

#### 4つのスペースでインデントされたコードブロック

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

## リスト

#### 番号付きリスト

1. 最初の項目
2. 2番目の項目
3. 3番目の項目

#### 箇条書きリスト

- リスト項目
- 別の項目
- さらに別の項目

#### 入れ子のリスト

- 果物
  - リンゴ
  - オレンジ
  - バナナ
- 乳製品
  - 牛乳
  - チーズ

## その他の要素 — abbr, sub, sup, kbd, mark

<abbr title="Graphics Interchange Format">GIF</abbr>はビットマップ画像フォーマットです。

H<sub>2</sub>O

X<sup>n</sup> + Y<sup>n</sup> = Z<sup>n</sup>

セッションを終了するには <kbd><kbd>CTRL</kbd>+<kbd>ALT</kbd>+<kbd>Delete</kbd></kbd> を押してください。

ほとんどの<mark>サンショウウオ</mark>は夜行性で、昆虫やミミズなどの小動物を捕食します。
