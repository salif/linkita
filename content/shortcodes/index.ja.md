+++
title = "ショートコード"
description = "Linkitaテーマのショートコード一覧です。"
date = 2022-10-20
updated = 2025-04-20
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["kita", "salif"]
[extra]
mermaid = true
+++

Linkitaテーマは複数のショートコードを提供します。

ショートコードについてご存知ありませんか？ 詳細は [Zolaのドキュメント](https://www.getzola.org/documentation/content/shortcodes/) をご覧ください。

## Mermaid {#mermaid-header}

ページでMermaidを使用するには、ページのフロントマターで `extra.mermaid = true` を設定する必要があります。

```toml
+++
title = "ページのタイトル"

[extra]
mermaid = true
+++
```

そうすれば、`mermaid()` ショートコードを次のように使用できます：

```markdown
{%/* mermaid() */%}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{%/* end */%}
```

これは次のようにレンダリングされます：

{% mermaid() %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% end %}

さらに、`mermaid()` ショートコード内にコードブロックを使用することができ、そのコードブロックは無視されます。

コードブロックを使用することで、フォーマッタがMermaidのフォーマットを崩すのを防ぎます。

````markdown
{%/* mermaid() */%}

```mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hello John, how are you?
    loop Healthcheck
        John->>John: Fight against hypochondria
    end
    Note right of John: Rational thoughts <br/>prevail!
    John-->>Alice: Great!
    John->>Bob: How about you?
    Bob-->>John: Jolly good!
```

{%/* end */%}
````

これは次のようにレンダリングされます：

{% mermaid() %}

```mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hello John, how are you?
    loop Healthcheck
        John->>John: Fight against hypochondria
    end
    Note right of John: Rational thoughts <br/>prevail!
    John-->>Alice: Great!
    John->>Bob: How about you?
    Bob-->>John: Jolly good!
```

{% end %}

## 注意喚起

`admonition()` ショートコードは、ページ内に注意喚起のバナーを表示します。

`admonition()` ショートコードは次のように使用できます：

```markdown
{%/* admonition(type="tip", title="ヒント") */%}
これは `tip` のadmonitionです。
{%/* end */%}
```

admonitionショートコードには12の異なるタイプがあります：

{% admonition(type="note", title="注記") %}
これは `note` のadmonitionです。
{% end %}

{% admonition(type="abstract", title="概要") %}
これは `abstract` のadmonitionです。
{% end %}

{% admonition(type="info", title="情報") %}
これは `info` のadmonitionです。
{% end %}

{% admonition(type="tip", title="ヒント") %}
これは `tip` のadmonitionです。
{% end %}

{% admonition(type="success", title="成功") %}
これは `success` のadmonitionです。
{% end %}

{% admonition(type="question", title="質問") %}
これは `question` のadmonitionです。
{% end %}

{% admonition(type="warning", title="警告") %}
これは `warning` のadmonitionです。
{% end %}

{% admonition(type="failure", title="失敗") %}
これは `failure` のadmonitionです。
{% end %}

{% admonition(type="danger", title="危険") %}
これは `danger` のadmonitionです。
{% end %}

{% admonition(type="bug", title="バグ") %}
これは `bug` のadmonitionです。
{% end %}

{% admonition(type="example", title="例") %}
これは `example` のadmonitionです。
{% end %}

{% admonition(type="quote", title="引用") %}
これは `quote` のadmonitionです。
{% end %}

## ギャラリー

`gallery()` ショートコードは、ページのassetsからすべての画像を表示する、クリック可能な非常にシンプルなHTMLのみの画像ギャラリーです。

これは[Zolaのドキュメント](https://www.getzola.org/documentation/content/image-processing/)からの引用です。

```markdown
{{/* gallery() */}}
```

{{ gallery(alt="ギャラリーのデモ画像") }}

## プロジェクト

`projects()` ショートコードを使用すると、あなたのプロジェクトを紹介するページを作成できます。

`content/pages/projects/index.md` ファイルを作成します：

```markdown
+++
title = "私のプロジェクト"
description = ""
path = "projects"
+++

{{/* projects(path="data.toml", format="toml") */}}
```

`content/pages/projects/data.toml` ファイルを作成します：

```toml
[[project]]
name = "lorem"
desc = "Lorem ipsum dolor sit."
tags = ["lorem", "ipsum"]
links = [
    { name = "homepage", url = "https://example.com" },
    { name = "source", url = "https://example.com" },
]
```

これは次のように表示されます：

{{ projects(path="projects.toml", format="toml") }}
