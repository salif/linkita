+++
title = "Zola 0.23.4 への移行"
description = "Linkita サイトを Zola v0.23.4 に移行する方法"
date = 2026-08-16
updated = 2026-08-16
[taxonomies]
authors = ["salif"]
[extra]
inline_code_fix = true
+++

Zola v0.23 では、テンプレートエンジンである Tera が新しいメジャーバージョン (Tera v2) に置き換えられました。Zola プロジェクト自体もこれを
> おそらく Zola 史上最も破壊的なバージョン変更

と表現しており、Linkita のテンプレートもそれに合わせて全面的に書き直す必要がありました。このページでは、Linkita サイトを Zola v0.22.1 から Zola v0.23.4 に移行する手順を説明します。

## リポジトリの移転

Linkita は同時に Codeberg から GitHub へ移行しました。現在も Codeberg リポジトリを使用している場合は、まず GitHub リポジトリに切り替える必要があります。git サブモジュールを使用している場合の手順は以下のとおりです。

```sh
git submodule init
git config -f .gitmodules submodule."themes/linkita".url https://github.com/salif/linkita.git
git config -f .gitmodules submodule."themes/linkita".branch tera1
git submodule sync
git submodule update
git add .gitmodules
```

## 対象となる読者

このガイドは、Zola v0.22.1 以前で `tera1` ブランチ（または `linkita` / `v4`）の Linkita を使用しているサイトを対象としています。

まだ Zola をアップグレードしたくない場合は、何もする必要はありません。`tera1` ブランチは従来の Zola バージョンで引き続き動作し、削除されることはありません。

## ステップ 1: Zola を v0.23.4 にアップグレード

Zola v0.23.4 以降をインストールします。インストールされているバージョンを確認してください。

```sh
zola --version
```

Zola v0.23 は大規模なアップデートです。Linkita の標準テンプレート以外に独自のカスタムテンプレートを作成している場合は、[Zola v0.23.0 の変更履歴](https://github.com/getzola/zola/blob/master/CHANGELOG.md#0230-2026-08-05) に目を通してください。このガイドの残りの部分では、Linkita 側の変更点について説明します。

## ステップ 2: `main` ブランチに切り替える

Linkita の `main` ブランチは現在、Zola v0.23.0+ を対象としています。`tera1` ブランチは、Zola v0.22.1 以前向けの旧テンプレートエンジン用として維持されます。

Linkita を git サブモジュールとして導入している場合:

```sh
git submodule set-branch --branch main themes/linkita
git submodule update --remote themes/linkita
```

## ステップ 3: `zola.toml` / `config.toml` を更新する

以下の各項目を確認してください。これらは Zola によって強制されるものではありません。古いキーが残っていてもビルドエラーにはなりませんが、それらの設定は機能しなくなるため、整理しておくことをお勧めします。

### メニューとソーシャルリンク: `$BASE_URL` → `@base`

`extra.menus`、プロフィールの `social` URL、および `extra.footer.license_url` 内の `$BASE_URL` は `@base` と表記するようになりました。

```toml ,name=zola.toml
# 変更前
[extra.menus]
menu_name = [
  { url = "$BASE_URL/blog/", name = "アーカイブ" },
]

# 変更後
[extra.menus]
menu_name = [
  { url = "@base/blog/", name = "アーカイブ" },
]
```

同様の名前変更がプロフィールの `social` 項目および `extra.footer.license_url` にも適用されます。好みに応じて、`@base` の代わりに [Zola の内部リンク](https://www.getzola.org/documentation/content/linking/#internal-links)（`@/...`）を使用することもできます。

また、メニューやソーシャル URL 向けに、特定言語内のパスを解決する新しい `@lang` プレフィックスも用意されています。

なお、これは `extra.footer.copyright` には**適用されません**。この文字列では従来通り `$BASE_URL`、`$YEAR`、`$LICENSE_URL` を使用します。

```toml ,name=zola.toml
[extra.footer]
copyright = "&copy; $YEAR Your Name &vert; [CC BY-SA 4.0]($LICENSE_URL)"
```

### プロフィール: Open Graph 設定の簡素化

`[extra.profiles.<user>.open_graph]` サブテーブルは廃止されました。`image` と `image_alt` は階層が1つ上に移動して名前が変更され、`fediverse_creator` も1つ上に移動しました。Facebook 固有のフィールド（`first_name`、`last_name`、`username`、`gender`、`fb_app_id`、`fb_admins`）および言語ごとの Open Graph 翻訳セクションは完全に削除されました。

```toml ,name=zola.toml
# 変更前
[extra.profiles.your_username.open_graph]
image = "cover.png"
image_alt = "画像の説明"
fediverse_creator = { handle = "me", domain = "mastodon.social" }

# 変更後
[extra.profiles.your_username]
# ...avatar_url, name, bio, social などは従来通り、さらに:
og_image = "cover.png"
og_image_alt = "画像の説明"
fediverse_creator = { handle = "me", domain = "mastodon.social" }
```

`first_name` / `last_name` / `gender` / `fb_app_id` / `fb_admins` や言語ごとの `open_graph.languages.<lang>.image_alt` による上書きに依存していた場合、直接の代替手段はありません（これらの Open Graph フィールドはテーマから出力されなくなりました）。

### 言語設定: `locale` の削除と日付フォーマットの変更

Zola の `date` フィルターが `locale` 引数をサポートしなくなったため、`extra.languages.<lang>.locale` 変数（例: `locale = "fr_FR"`）は削除されました。日付のフォーマット処理は `chrono` クレートから `jiff` に移行したため、`date_format` 文字列は chrono ではなく [jiff の strftime リファレンス](https://docs.rs/jiff/latest/jiff/fmt/strtime/index.html#conversion-specifications) に基づいて解釈されます。

```toml ,name=zola.toml
# 変更前
[extra.languages.fr]
locale = "fr_FR"
date_format = "%x"

# 変更後
[extra.languages.fr]
date_format = "%F"
num_format = "fr"
```

実際の影響として、`locale` を使用して翻訳された月名や曜日名（`%B` や `%A` などのトークン経由）を表示していた場合、自動翻訳は行われなくなります。jiff のドキュメントで `date_format` トークンを確認し、数値のみの形式に切り替えるか、jiff がそのトークンに対してデフォルトで出力する表記を受け入れる必要があります。`num_format`（数値の書式設定用で、日付とは無関係）は変更されておらず、言語ごとに設定可能です。

### `disable_javascript` の削除

テーマの JavaScript を無効化して独自に再実装するための設定変数 `extra.disable_javascript` は削除されました。

### ドキュメントリンクの変更

Linkita の公式ドキュメントにリンクしている場合、ショートコードのデモが `/shortcodes/` から `/components/` に移動したことに注意してください（例: プロジェクト機能の説明は現在 `https://salif.github.io/linkita/components/#projects` にあります）。

また、カバー画像のドキュメントが明確化され、`extra.cover.image` がページアセットのファイル名または `get_url` 互換のパスを受け付けることが明記されました（以前から動作していましたが、ドキュメントに明示されていませんでした）。

## ステップ 4: コンテンツの更新 – ショートコードからコンポーネントへ

これは既存の投稿に最も影響を与える可能性が高い変更です。

Zola v0.23 ではショートコードが完全に廃止されました。`templates/shortcodes/` ディレクトリは存在しなくなり、Markdown コンテンツ内でショートコードを関数のように呼び出す従来の構文（ボディの有無に関わらず）はすべて削除されました。これらを使用すると「unknown function」または「unknown tag」エラーでビルドが失敗します。代わりに、`.html` テンプレートと同様に `.md` ファイルも Tera で直接処理されるようになり、Tera v2 の新しい呼び出し構文を使用して Linkita の組み込み**コンポーネント**を呼び出します。

ボディを持つコンポーネントは以下のように呼び出します（二重波括弧ではなく、パーセント記号と波括弧がアングルブラケットタグを囲むことに注意してください）。

```markdown
{% <component_name arg="value"> %}
ボディのコンテンツ
{% </component_name> %}
```

ボディを持たない（自己終了型の）コンポーネントは、代わりに二重波括弧を使用します。

```markdown
{{<component_name arg="value" />}}
```

### 警告・注記ボックス (Admonition)

```markdown
# 変更前
{% admonition(type="note", title="ノート") %}
これは**ノート**の本文です。
{% end %}

# 変更後
{% <admonition type="note" title="ノート"> %}
これは**ノート**の本文です。
{% </admonition> %}
```

### ギャラリー (Gallery)

Gallery では `page` と `config` を明示的に渡す必要があります（Tera v2 のコンポーネントは、従来のショートコードのように暗黙的に page/config にアクセスできません。名前で渡し、変数名がパラメータ名と一致しているため、単に `page config` と記述できます）。

```markdown
# 変更前
{{ gallery() }}

# 変更後
{{<gallery page config alt="" />}}
```

### Mermaid

````markdown
# 変更前
{% mermaid() %}
```mermaid
graph TD;
A-->B;
```
{% end %}

# 変更後
{% <mermaid> -%}
```mermaid
graph TD;
A-->B;
```
{%- </mermaid> %}
````

上記のように空白削除用のダッシュ（開始パーセント括弧の直後と終了パーセント括弧の直前）を使用してください。これがないとコードブロック直前の先頭の空行が除去されず、ダイアグラムがコンポーネントによって整形されずに ` ```mermaid ` のフェンスマーカーが表示されたままレンダリングされてしまいます。

### プロジェクト (Projects)

Projects でも `page` と `config` を明示的に渡す必要があります。

```markdown
# 変更前
{{ projects(path="data.toml", format="toml") }}

# 変更後
{{<projects path="data.toml" format="toml" page config />}}
```

### 投稿内で Tera 構文について記述する場合

Markdown が解析される前に `.md` ファイルが Tera によってテンプレート処理されるため、コードブロック内のリテラルな Tera タグ（上記の例など）は、トリプルバッククォート内であってもテキストとして表示されず実際に実行されてしまいます。このような例は `raw` ブロックで囲んで、リテラルとして表示させてください。

```markdown
{% raw %}
...
{% endraw %}
```

## ステップ 5: カスタム言語ファイル

カスタムの `static/i18n/<lang>.json` ファイルを追加している場合は、テーマのデフォルト言語ファイルと変更内容を同期してください。

## ステップ 6 (上級者向け): テンプレートの上書きやインジェクトのカスタマイズ

Linkita 独自のテンプレートを上書きしている場合や、独自のテンプレート・インジェクトから Linkita の内部マクロを直接呼び出している場合以外は、このセクションを読み飛ばしてください。

Tera v1 のマクロは Tera v2 で廃止され、名前でグローバルに呼び出される**コンポーネント**に置き換えられました（`{% import %}` や `self::` 名前空間は不要になりました）。

テンプレート全体で見られるその他の Tera v2 構文の変更点（独自の上書きテンプレートで使用している場合）:

- `trim_start_matches(pat=...)` / `trim_end_matches(pat=...)` は `trim_start(pat=...)` / `trim_end(pat=...)` になりました。
- `linebreaksbr` は `newlines_to_br` になりました。
- `default(value=x)` で空文字列や `false` を「デフォルトを使用」として扱うには `boolean=true` を追加する必要があります（`default(value=x, boolean=true)`）。これがないと、完全に未定義/null の値のみがデフォルトをトリガーします。
- オプショナルチェーン（`?.` / `?[...]`）が利用可能になり、設定されていない可能性のある設定値を安全に読み取るために全体で使用されています。
- マクロ内とは異なり、コンポーネント内ではグローバルコンテキスト（`page`、`config`、`lang` など）が暗黙的に利用できなくなりました。コンポーネントはこれらを明示的に宣言して受け取るため、新しいテンプレート全体で `page: map`、`config: map` などのパラメータが見られます。
- カスタムの `templates/sitemap.xml` および `templates/split_sitemap_index.xml` テンプレートはテーマから削除されました。自身で上書きしていた場合は、引き続き必要かどうか確認してください。

Tera 自体の変更点に関する完全な情報は、[Tera v1 → v2 移行ガイド](https://github.com/Keats/tera/blob/master/MIGRATION.md) を参照してください。

## ステップ 7: 再ビルドと確認

```sh
zola build
```

ビルド後、特に以下の項目を確認してください。

- メニュー項目やソーシャルアイコンが正しい URL に解決されているか（`@base` の変更）。
- プロフィールの Open Graph 画像/説明および Fediverse 検証リンクタグがページの `<head>` に存在するか。
- 英語以外の日付フォーマットが正しく表示されているか（ロケールによる月・日名の翻訳廃止に伴い、最も気づきにくい変更点です）。
- 警告ボックス、ギャラリー、Mermaid ダイアグラム、プロジェクトページなどが正しくレンダリングされているか。

## サポート

説明と異なる点がある場合は、`main` ブランチの [README](https://github.com/salif/linkita/blob/main/README.md) および [CHANGELOG](https://github.com/salif/linkita/blob/main/CHANGELOG.md) を確認するか、[ディスカッションを開始](https://github.com/salif/linkita/discussions) してください。
