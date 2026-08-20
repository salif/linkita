+++
title = "Switch to Zola 0.23.4"
description = "How to migrate a Linkita site to Zola v0.23.4"
date = 2026-08-16
updated = 2026-08-16
[taxonomies]
authors = ["salif"]
[extra]
inline_code_fix = true
+++

Zola v0.23 replaced its template engine, Tera, with a new major version
(Tera v2). The Zola project itself calls it
> probably the most breaking version of Zola that will happen

and Linkita's templates had to be rewritten to follow it. This page walks
you through moving a Linkita site from Zola v0.22.1 to
Zola v0.23.4.

## Repository move

Linkita was simultaneously moved from Codeberg to GitHub.
If you are still using the Codeberg repository, you need to switch to
the GitHub repository first. For submodule users, here are the
instructions:

```sh
git submodule init
git config -f .gitmodules submodule."themes/linkita".url https://github.com/salif/linkita.git
git config -f .gitmodules submodule."themes/linkita".branch tera1
git submodule sync
git submodule update
git add .gitmodules
```

## Who needs this guide

This guide is for you if your site currently uses Linkita on the `tera1`
branch (or on `linkita` / `v4`) with Zola v0.22.1 or older.

If you don't want to upgrade Zola yet, you don't have to do anything –
the `tera1` branch will keep working with old Zola versions and isn't
going away.

## Step 1: Upgrade Zola to v0.23.4

Install Zola v0.23.4 or newer. Check your installed version with:

```sh
zola --version
```

Zola v0.23 is a big jump. Skim the
[Zola v0.23.0 changelog entry](https://github.com/getzola/zola/blob/master/CHANGELOG.md#0230-2026-08-05)
if your site has custom templates beyond Linkita's own – the rest of
this guide only covers what changed on Linkita's side.

## Step 2: Switch to the `main` branch

Linkita's `main` branch now targets Zola v0.23.0+. The `tera1` branch
stays on the old template engine for Zola v0.22.1 and older.

If you installed Linkita as a git submodule:

```sh
git submodule set-branch --branch main themes/linkita
git submodule update --remote themes/linkita
```

## Step 3: Update your `zola.toml` / `config.toml`

Go through each of the following. None of these are enforced by Zola –
leftover old keys won't break your build, but they'll silently stop
doing anything, so it's worth cleaning them up.

### Menu and social links: `$BASE_URL` → `@base`

`$BASE_URL` in `extra.menus`, profile `social` URLs, and
`extra.footer.license_url` is now written `@base`:

```toml ,name=zola.toml
# Before
[extra.menus]
menu_name = [
  { url = "$BASE_URL/blog/", name = "Archive" },
]

# After
[extra.menus]
menu_name = [
  { url = "@base/blog/", name = "Archive" },
]
```

The same rename applies to a profile's `social` entries and to
`extra.footer.license_url`. You can also use
[Zola's internal links](https://www.getzola.org/documentation/content/linking/#internal-links)
(`@/...`) instead of `@base` if you prefer.

There's also a new `@lang` prefix for menu/social URLs that resolves a
path within a specific language, if you need that.

Note this does **not** apply to `extra.footer.copyright` – that string
still uses `$BASE_URL`, `$YEAR`, and `$LICENSE_URL` as before:

```toml ,name=zola.toml
[extra.footer]
copyright = "&copy; $YEAR Your Name &vert; [CC BY-SA 4.0]($LICENSE_URL)"
```

### Profiles: Open Graph settings simplified

The `[extra.profiles.<user>.open_graph]` sub-table is gone. `image` and
`image_alt` moved up a level and were renamed, `fediverse_creator` moved
up a level too, and the Facebook-specific fields
(`first_name`, `last_name`, `username`, `gender`, `fb_app_id`,
`fb_admins`) and the per-language Open Graph translation section were
removed entirely:

```toml ,name=zola.toml
# Before
[extra.profiles.your_username.open_graph]
image = "cover.png"
image_alt = "A description"
fediverse_creator = { handle = "me", domain = "mastodon.social" }

# After
[extra.profiles.your_username]
# ...avatar_url, name, bio, social, etc. as before, plus:
og_image = "cover.png"
og_image_alt = "A description"
fediverse_creator = { handle = "me", domain = "mastodon.social" }
```

If you relied on `first_name` / `last_name` / `gender` / `fb_app_id` /
`fb_admins`, or on a per-language `open_graph.languages.<lang>.image_alt`
override, there's no direct replacement – those Open Graph fields are no
longer emitted by the theme.

### Language options: `locale` removed, date formatting changed

Zola's `date` filter no longer takes a `locale` argument, so the
`extra.languages.<lang>.locale` variable (e.g. `locale = "fr_FR"`) has
been removed. Date formatting moved from the `chrono` crate to `jiff`,
so `date_format` strings are now interpreted using
[jiff's strftime reference](https://docs.rs/jiff/latest/jiff/fmt/strtime/index.html#conversion-specifications)
rather than chrono's.

```toml ,name=zola.toml
# Before
[extra.languages.fr]
locale = "fr_FR"
date_format = "%x"

# After
[extra.languages.fr]
date_format = "%F"
num_format = "fr"
```

The practical effect: if you were relying on `locale` to print
translated month/weekday names (via tokens like `%B` or `%A`), that no
longer happens automatically. Check your
`date_format` tokens against the jiff docs – you may want to switch to
a numeric-only format, or accept that month/day names will render in
whatever jiff produces by default for that token. `num_format` (for
number formatting, unrelated to dates) is unchanged and still per
language.

### `disable_javascript` removed

The `extra.disable_javascript` config variable, which let you suppress
the theme's JS and re-implement it yourself via injects, has been
removed.

### Documentation links

If you link to Linkita's own documentation anywhere, note the shortcode
demo moved from `/shortcodes/` to `/components/` (e.g. the projects
feature is now documented at
`https://salif.github.io/linkita/components/#projects`).

The cover image docs were clarified
to note `extra.cover.image` accepts either a page asset filename or a
`get_url`-compatible path – this already worked before, just wasn't
spelled out.

## Step 4: Update your content – shortcodes are now components

This is the change most likely to affect your existing posts.

Zola v0.23 removed shortcodes completely. There is no more
`templates/shortcodes/` directory, and the old function-call style of
invoking a shortcode in Markdown content (with or without a body) is
gone – both forms now fail the build with an "unknown function" /
"unknown tag" error. Instead, your `.md` files are templated with Tera
directly, the same as `.html` templates, and you call Linkita's
built-in **components** using Tera v2's new call syntax.

A component with a body is called like this – note the closing
percent-brace and opening percent-brace wrap the angle-bracket tags,
not double curly braces:

```markdown
{% <component_name arg="value"> %}
body content
{% </component_name> %}
```

A component with no body (self-closing) uses double curly braces
instead:

```markdown
{{<component_name arg="value" />}}
```

### Admonition

```markdown
# Before
{% admonition(type="note", title="A note") %}
This is a **note** body.
{% end %}

# After
{% <admonition type="note" title="A note"> %}
This is a **note** body.
{% </admonition> %}
```

### Gallery

Gallery now needs `page` and `config` passed in explicitly (Tera v2
components don't get implicit access to the page/config like old
shortcodes did – you pass them by name, and since the variable names
already match the parameter names, you can just write `page config`):

```markdown
# Before
{{ gallery() }}

# After
{{<gallery page config alt="" />}}
```

### Mermaid

````markdown
# Before
{% mermaid() %}
```mermaid
graph TD;
A-->B;
```
{% end %}

# After
{% <mermaid> -%}
```mermaid
graph TD;
A-->B;
```
{%- </mermaid> %}
````

Use the whitespace-trim dashes shown above (right after the opening
percent-brace and right before the closing one) – without them, the
leading blank line before the fenced block isn't
stripped and the diagram renders with the ` ```mermaid ` fence markers
still visible instead of being cleaned up by the component.

### Projects

Projects also now needs `page` and `config` passed explicitly:

```markdown
# Before
{{ projects(path="data.toml", format="toml") }}

# After
{{<projects path="data.toml" format="toml" page config />}}
```

### If you write about Tera syntax in your own posts

Since `.md` files are now templated by Tera before Markdown is parsed,
literal Tera tags inside a fenced code block – like the examples
above – will actually get executed rather than displayed, even inside
triple-backtick fences. Wrap any such example in a raw block,
to show it literally instead.

```markdown
{% raw %}
...
{% endraw %}
```

## Step 5: Custom language files

If you added a custom `static/i18n/<lang>.json` file,
synchronize your changes with the theme's default language file.

## Step 6 (advanced): Custom template overrides or injects

Skip this section unless you've overridden one of Linkita's own
templates, or you call its internal macros directly from your own
templates or injects.

Tera v1 macros are gone in Tera v2, replaced by **components**, which
are called globally by name – no more `{% import %}`
or `self::` namespacing.

Other Tera v2 syntax changes visible throughout the templates, in case
your own overrides use them:

- `trim_start_matches(pat=...)` / `trim_end_matches(pat=...)` are now
  `trim_start(pat=...)` / `trim_end(pat=...)`.
- `linebreaksbr` is now `newlines_to_br`.
- `default(value=x)` needs `boolean=true` added
  (`default(value=x, boolean=true)`) to treat empty strings/`false` as
  "use the default" – without it, only a truly undefined/null value
  triggers the default.
- Optional chaining (`?.` / `?[...]`) is available and used throughout
  for safely reading config values that might not be set.
- Global context (`page`, `config`, `lang`, etc.) is no longer
  implicitly available inside a component the way it was inside a
  macro – components declare and receive it explicitly, which is why
  you'll see `page: map`, `config: map` parameters
  throughout the new templates.
- The custom `templates/sitemap.xml` and
  `templates/split_sitemap_index.xml` templates were removed from the
  theme. If you had overridden either of these yourself, check whether
  you still need to.

For the full picture of what changed in Tera itself, see the
[Tera v1 → v2 migration guide](https://github.com/Keats/tera/blob/master/MIGRATION.md).

## Step 7: Rebuild and check

```sh
zola build
```

Then review, especially:

- Menu items and social icons resolve to the right URLs (the
  `@base` change).
- Your profile's Open Graph image/description and Fediverse
  verification link tag are present in the page `<head>`.
- Non-English date formatting still looks right – this is the one
  most likely to have silently changed (no more locale-translated
  month/day names).
- Any admonitions, galleries, Mermaid diagrams, or a projects page
  render correctly.

## Getting help

If something doesn't match what's described here, check the
[README](https://github.com/salif/linkita/blob/main/README.md) and
[CHANGELOG](https://github.com/salif/linkita/blob/main/CHANGELOG.md) on
the `main` branch, or [start a discussion](https://github.com/salif/linkita/discussions).
