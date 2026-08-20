+++
title = "切换至 Zola 0.23.4"
description = "如何将 Linkita 站点迁移至 Zola v0.23.4"
date = 2026-08-16
updated = 2026-08-16
[taxonomies]
authors = ["salif"]
[extra]
inline_code_fix = true
+++

Zola v0.23 将其模板引擎 Tera 替换为新的主要版本（Tera v2）。Zola 项目自身将其称为
> 大概是 Zola 有史以来最具破坏性的版本更新

Linkita 的模板也不得不重新编写以跟进这一变更。本页面将引导你把 Linkita 站点从 Zola v0.22.1 迁移到 Zola v0.23.4。

## 代码仓库迁移

Linkita 同时从 Codeberg 迁移到了 GitHub。如果你仍在使用 Codeberg 仓库，需要先切换到 GitHub 仓库。对于使用 git submodule 的用户，操作说明如下：

```sh
git submodule init
git config -f .gitmodules submodule."themes/linkita".url https://github.com/salif/linkita.git
git config -f .gitmodules submodule."themes/linkita".branch tera1
git submodule sync
git submodule update
git add .gitmodules
```

## 适用对象

如果你的站点当前在 Zola v0.22.1 或更早版本上使用 `tera1` 分支（或 `linkita` / `v4`）的 Linkita，本指南正适合你。

如果你暂时不想升级 Zola，则无需进行任何操作 —— `tera1` 分支将继续兼容旧版 Zola，且不会被移除。

## 第 1 步：将 Zola 升级到 v0.23.4

安装 Zola v0.23.4 或更高版本。通过以下命令检查安装的版本：

```sh
zola --version
```

Zola v0.23 是一个巨大的飞跃。如果你的站点在 Linkita 自带模板之外还有自定义模板，建议快速浏览 [Zola v0.23.0 更新日志](https://github.com/getzola/zola/blob/master/CHANGELOG.md#0230-2026-08-05) —— 本指南的其余部分仅涵盖 Linkita 方面的变更。

## 第 2 步：切换到 `main` 分支

Linkita 的 `main` 分支现在面向 Zola v0.23.0+。`tera1` 分支保留旧版模板引擎，用于 Zola v0.22.1 及更早版本。

如果你将 Linkita 安装为 git submodule：

```sh
git submodule set-branch --branch main themes/linkita
git submodule update --remote themes/linkita
```

## 第 3 步：更新你的 `zola.toml` / `config.toml`

逐项检查以下内容。Zola 不会强制要求这些更改 —— 残留的旧配置键不会导致构建失败，但它们会静默失效，因此建议清理干净。

### 菜单与社交链接：`$BASE_URL` → `@base`

`extra.menus` 中的 `$BASE_URL`、个人资料 `social` URL 以及 `extra.footer.license_url` 现在写作 `@base`：

```toml ,name=zola.toml
# 修改前
[extra.menus]
menu_name = [
  { url = "$BASE_URL/blog/", name = "归档" },
]

# 修改后
[extra.menus]
menu_name = [
  { url = "@base/blog/", name = "归档" },
]
```

同样的重命名也适用于个人资料的 `social` 条目和 `extra.footer.license_url`。如果你愿意，也可以使用 [Zola 的内部链接](https://www.getzola.org/documentation/content/linking/#internal-links)（`@/...`）替代 `@base`。

另外还新增了 `@lang` 前缀，用于在菜单/社交 URL 中解析特定语言内的路径。

注意这**不适用于** `extra.footer.copyright` —— 该字符串仍像以前一样使用 `$BASE_URL`、`$YEAR` 和 `$LICENSE_URL`：

```toml ,name=zola.toml
[extra.footer]
copyright = "&copy; $YEAR 你的姓名 &vert; [CC BY-SA 4.0]($LICENSE_URL)"
```

### 个人资料：简化 Open Graph 设置

`[extra.profiles.<user>.open_graph]` 子表已移除。`image` 和 `image_alt` 提升了一级并重命名，`fediverse_creator` 也提升了一级，针对 Facebook 的字段（`first_name`、`last_name`、`username`、`gender`、`fb_app_id`、`fb_admins`）以及按语言的 Open Graph 翻译部分已完全移除：

```toml ,name=zola.toml
# 修改前
[extra.profiles.your_username.open_graph]
image = "cover.png"
image_alt = "描述信息"
fediverse_creator = { handle = "me", domain = "mastodon.social" }

# 修改后
[extra.profiles.your_username]
# ...avatar_url, name, bio, social 等保持原样，外加：
og_image = "cover.png"
og_image_alt = "描述信息"
fediverse_creator = { handle = "me", domain = "mastodon.social" }
```

如果你依赖于 `first_name` / `last_name` / `gender` / `fb_app_id` / `fb_admins`，或按语言的 `open_graph.languages.<lang>.image_alt` 覆盖，目前没有直接的替代方案 —— 主题不再输出这些 Open Graph 字段。

### 语言选项：移除 `locale`，更改日期格式化

Zola 的 `date` 过滤器不再接收 `locale` 参数，因此 `extra.languages.<lang>.locale` 变量（例如 `locale = "fr_FR"`）已被移除。日期格式化从 `chrono` 包迁移到了 `jiff`，因此 `date_format` 字符串现在根据 [jiff 的 strftime 参考文档](https://docs.rs/jiff/latest/jiff/fmt/strtime/index.html#conversion-specifications) 进行解析，而非 chrono。

```toml ,name=zola.toml
# 修改前
[extra.languages.fr]
locale = "fr_FR"
date_format = "%x"

# 修改后
[extra.languages.fr]
date_format = "%F"
num_format = "fr"
```

实际影响：如果你之前依赖 `locale` 来输出翻译后的月份/星期名称（通过 `%B` 或 `%A` 等标记），这不再自动发生。请参考 jiff 文档检查你的 `date_format` 标记 —— 你可能需要切换为纯数字格式，或者接受 jiff 对该标记默认输出的内容。`num_format`（用于数字格式化，与日期无关）保持不变，仍然按语言配置。

### 移除 `disable_javascript`

配置变量 `extra.disable_javascript`（用于禁用主题的 JS 并通过 injects 自行重新实现）已被移除。

### 文档链接

如果你在任何地方链接了 Linkita 官方文档，请注意短代码（shortcodes）演示已从 `/shortcodes/` 移动到了 `/components/`（例如项目功能的文档现在位于 `https://salif.github.io/linkita/components/#projects`）。

封面图片文档已进一步明确，指出 `extra.cover.image` 支持页面资源文件名或与 `get_url` 兼容的路径 —— 之前即可正常工作，只是未明确说明。

## 第 4 步：更新内容 – 短代码现已变为组件

这是最可能影响你现有文章的变更。

Zola v0.23 完全移除了短代码（shortcodes）。不再有 `templates/shortcodes/` 目录，而在 Markdown 内容中以函数调用风格（有无主体）调用短代码的旧方式已不复存在 —— 两种形式都会因 "unknown function" / "unknown tag" 错误而导致构建失败。相反，你的 `.md` 文件现在与 `.html` 模板一样直接由 Tera 进行模板渲染，你可以使用 Tera v2 的新调用语法调用 Linkita 的内置**组件**。

带主体的组件调用方式如下 —— 请注意，百分号和花括号包裹的是尖括号标签，而不是双花括号：

```markdown
{% <component_name arg="value"> %}
主体内容
{% </component_name> %}
```

无主体的组件（自闭合）则使用双花括号：

```markdown
{{<component_name arg="value" />}}
```

### 提示框 (Admonition)

```markdown
# 修改前
{% admonition(type="note", title="提示") %}
这是**提示**内容。
{% end %}

# 修改后
{% <admonition type="note" title="提示"> %}
这是**提示**内容。
{% </admonition> %}
```

### 画廊 (Gallery)

Gallery 现在需要显式传递 `page` 和 `config`（Tera v2 组件无法像旧短代码那样隐式访问 page/config —— 你需要按名称传递它们，由于变量名与参数名一致，直接写 `page config` 即可）：

```markdown
# 修改前
{{ gallery() }}

# 修改后
{{<gallery page config alt="" />}}
```

### Mermaid

````markdown
# 修改前
{% mermaid() %}
```mermaid
graph TD;
A-->B;
```
{% end %}

# 修改后
{% <mermaid> -%}
```mermaid
graph TD;
A-->B;
```
{%- </mermaid> %}
````

请使用上面展示的空白去除破折号（紧接在开头的百分号花括号后以及闭合前）—— 如果没有它们，代码块前面的开头空行不会被去除，图表在渲染时仍会显示 ` ```mermaid ` 标记，而不是被组件妥善清理。

### 项目 (Projects)

Projects 现在也需要显式传递 `page` 和 `config`：

```markdown
# 修改前
{{ projects(path="data.toml", format="toml") }}

# 修改后
{{<projects path="data.toml" format="toml" page config />}}
```

### 如果你在文章中书写 Tera 语法

由于 `.md` 文件现在在 Markdown 解析之前由 Tera 处理，代码块内部的字面 Tera 标签（如上面的示例）实际上会被执行而不是直接显示，即使在三反引号代码块中也是如此。请将任何此类示例包裹在 `raw` 块中，以便字面展示。

```markdown
{% raw %}
...
{% endraw %}
```

## 第 5 步：自定义语言文件

如果你添加了自定义的 `static/i18n/<lang>.json` 文件，请将你的更改与主题的默认语言文件同步。

## 第 6 步（进阶）：自定义模板覆盖或注入 (Injects)

除非你覆盖了 Linkita 自带的模板，或者直接从自己的模板或注入中调用其内部宏，否则可以跳过此部分。

Tera v1 的宏在 Tera v2 中已被移除，取而代之的是通过名称全局调用的**组件** —— 不再需要 `{% import %}` 或 `self::` 命名空间。

如果你的自定义覆盖涉及以下内容，请注意模板中出现的其他 Tera v2 语法变更：

- `trim_start_matches(pat=...)` / `trim_end_matches(pat=...)` 现已变为 `trim_start(pat=...)` / `trim_end(pat=...)`。
- `linebreaksbr` 现已变为 `newlines_to_br`。
- `default(value=x)` 需要添加 `boolean=true`（即 `default(value=x, boolean=true)`）才能将空字符串/`false` 视为“使用默认值” —— 否则只有真正未定义/null 的值才会触发默认值。
- 可选链式调用（`?.` / `?[...]`）已可用并广泛用于安全读取可能未设置的配置值。
- 全局上下文（`page`、`config`、`lang` 等）不再像在宏内部那样在组件内隐式可用 —— 组件显式声明并接收它，这就是为什么你在新模板中会看到 `page: map`、`config: map` 参数。
- 自定义模板 `templates/sitemap.xml` 和 `templates/split_sitemap_index.xml` 已从主题中移除。如果你自己覆盖了其中任何一个，请检查是否仍需要它们。

关于 Tera 本身变化的完整说明，请参阅 [Tera v1 → v2 迁移指南](https://github.com/Keats/tera/blob/master/MIGRATION.md)。

## 第 7 步：重新构建并检查

```sh
zola build
```

然后重点检查以下几项：

- 菜单项和社交图标是否解析到正确的 URL（`@base` 变更）。
- 个人资料的 Open Graph 图片/描述以及 Fediverse 验证链接标签是否存在于页面的 `<head>` 中。
- 非英语日期格式是否显示正确 —— 这是最容易静默发生变化的地方（不再有通过 locale 翻译的月份/星期名称）。
- 任何提示框、画廊、Mermaid 图表或项目页面是否渲染正常。

## 获取帮助

如果遇到与此处描述不符的情况，请查看 `main` 分支上的 [README](https://github.com/salif/linkita/blob/main/README.md) 和 [CHANGELOG](https://github.com/salif/linkita/blob/main/CHANGELOG.md)，或者[发起讨论](https://github.com/salif/linkita/discussions)。
