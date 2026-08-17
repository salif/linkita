+++
title = "コンポーネント"
description = "コンポーネントの使い方"
date = 2022-10-20
updated = 2026-08-16
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["salif"]
[extra]
mermaid = true
+++

Linkitaテーマは複数のコンポーネントを提供します。

コンポーネントについてご存知ありませんか？ 詳細は [Zolaのドキュメント](https://keats.github.io/tera/#components) をご覧ください。

## Mermaid コンポーネント

ページでMermaidを使用するには、ページのフロントマターで `extra.mermaid = true` を設定する必要があります。

```toml
+++
title = "ページのタイトル"

[extra]
mermaid = true
+++
```

そうすれば、`<mermaid>` コンポーネントを次のように使用できます：

```markdown
{% raw %}{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}{% endraw %}
```

これは次のようにレンダリングされます：

{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}

さらに、`<mermaid>` コンポーネント内にコードブロックを使用することができ、そのコードブロックは無視されます。

コードブロックを使用することで、フォーマッタがMermaidのフォーマットを崩すのを防ぎます。

````markdown
{% raw %}{% <mermaid> -%}

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

{%- </mermaid> %}{% endraw %}
````

これは次のようにレンダリングされます：

{% <mermaid> -%}

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

{%- </mermaid> %}

## 注意喚起

`<admonition>` コンポーネントは、ページ内に注意喚起のバナーを表示します。

コンポーネントは次のように使用できます：

```markdown
{% raw %}{% <admonition type="tip" title="ヒント"> %}
これは `tip` のadmonitionです。
{% </admonition> %}{% endraw %}
```

admonitionコンポーネントには12の異なるタイプがあります：

{% <admonition type="note" title="注記"> %}
これは `note` のadmonitionです。
{% </admonition> %}

{% <admonition type="abstract" title="概要"> %}
これは `abstract` のadmonitionです。
{% </admonition> %}

{% <admonition type="info" title="情報"> %}
これは `info` のadmonitionです。
{% </admonition> %}

{% <admonition type="tip" title="ヒント"> %}
これは `tip` のadmonitionです。
{% </admonition> %}

{% <admonition type="success" title="成功"> %}
これは `success` のadmonitionです。
{% </admonition> %}

{% <admonition type="question" title="質問"> %}
これは `question` のadmonitionです。
{% </admonition> %}

{% <admonition type="warning" title="警告"> %}
これは `warning` のadmonitionです。
{% </admonition> %}

{% <admonition type="failure" title="失敗"> %}
これは `failure` のadmonitionです。
{% </admonition> %}

{% <admonition type="danger" title="危険"> %}
これは `danger` のadmonitionです。
{% </admonition> %}

{% <admonition type="bug" title="バグ"> %}
これは `bug` のadmonitionです。
{% </admonition> %}

{% <admonition type="example" title="例"> %}
これは `example` のadmonitionです。
{% </admonition> %}

{% <admonition type="quote" title="引用"> %}
これは `quote` のadmonitionです。
{% </admonition> %}

## ギャラリー

`<gallery />` コンポーネントは、ページのassetsからすべての画像を表示する、クリック可能な非常にシンプルなHTMLのみの画像ギャラリーです。

これは[Zolaのドキュメント](https://www.getzola.org/documentation/content/image-processing/)からの引用です。

```markdown
{% raw %}{{ <gallery /> }}{% endraw %}
```

{{ <gallery page config alt="ギャラリーのデモ画像" /> }}

## プロジェクト

`<projects />` コンポーネントを使用すると、あなたのプロジェクトを紹介するページを作成できます。

`content/pages/projects/index.md` ファイルを作成します：

```markdown
+++
title = "私のプロジェクト"
description = ""
path = "projects"
+++

{% raw %}{{ <projects path="data.toml" format="toml" page config /> }}{% endraw %}
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

{{ <projects path="projects.toml" format="toml" page config /> }}
