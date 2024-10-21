# Linkita

A clean and elegant blog theme for [Zola](https://www.getzola.org/). Linkita is based on [Kita](https://github.com/st1020/kita) and [Hugo-Paper](https://github.com/nanxiaobei/hugo-paper) and is multilingual and SEO friendly.

## Demo

- [English](https://salif.github.io/linkita/en/)
- [Bulgarian](https://salif.github.io/linkita/)
- [Esperanto](https://salif.github.io/linkita/eo/)

---

![Screenshot](https://codeberg.org/salif/linkita/raw/branch/linkita/screenshot.png)

![Screenshot - Dark mode](https://codeberg.org/salif/linkita/raw/branch/linkita/screenshot.dark.png)

## Kita features

- Easy to use and modify
- No preset limits (This theme does not limit your content directory structure, taxonomy names, etc. It's applicable to all zola sites.)
- Inject support
- Dark mode
- Responsive design
- Social icons
- Taxonomies support
- Projects page
- Archive page
- Table of Content
- Admonition shortcode
- SEO friendly
- Comments using [Giscus](https://giscus.app/)
- Mathematical notations using [KaTeX](https://katex.org/)
- Diagrams and charts using [Mermaid](https://mermaid.js.org/)

## Linkita features

### UI localization

- English
- Bulgarian
- Esperanto

## Installation

1. Use it as a submodule:

```sh
git submodule add https://codeberg.org/salif/linkita.git themes/linkita
```

Alternatively, clone the repository:

```sh 
# git clone https://codeberg.org/salif/linkita.git themes/linkita
```

2. It is recommended to switch from the `linkita` branch to the latest release:

```sh
cd themes/linkita
npm run switch-to-latest
# Alternatively, use this command:
# ./justfile switch-to-latest
```

3. Copy translations

Open `themes/linkita/config.toml` and copy all translations to your `config.toml`.
The English translation is under `[languages.en.translations]`.

Otherwise you will get this error:

```
Error: Reason: Function call 'trans' failed
Error: Reason: Failed to retrieve term translation
```

4. Then set `linkita` as your theme in `config.toml`.

```toml
theme = "linkita"
```

## Inject support

You can easily use inject to add new features to your side without modifying the theme itself.

To use inject, you need to add some HTML files to the `templates/injects` directory.

The available inject points are: `head`, `header_nav`, `body_start`, `body_end`, `page_start`, `page_end`, `footer`, `page_info`.

For example, to load a custom script, you can add a `templates/injects/head.html` file:

```html
<script src="js-file-path-or-cdn-url.js"></script>
```

## Configuration

| key | type | example | comment |
| --- | --- | --- | --- |
| `default_language` | string | `"en"` | The default language |
| `author` | string | `"Your Name"` | The default author for pages |
| `title` | string |  | The site title |
| `description` | string |  | The site description |
| `generate_feeds` | boolean | `true` | Automatically generated feed |
| `feed_filenames` | array of strings | `["atom.xml"]` or `["rss.xml"]` | The filenames to use for the feeds |
| `translations` | table |  | You need to copy translations from the `config.toml` file |
| `extra` | table |  |  |

Taxonomies with translated names are `tags` and `categories`.

---

| key | type | comment |
| --- | --- | --- |
| `extra.math` | boolean | Enable KaTeX globally |
| `extra.mermaid` | boolean | Enable Mermaid globally |
| `extra.comment` | boolean | Enable comments (giscus) |
| `extra.goatcounter_endpoint` | string | `"https://MYCODE.goatcounter.com/count"` |
| `extra.style` | table |  |
| `extra.profile` | table |  |
| `extra.menu` | array of tables |  |
| `extra.footer` | table |  |
| `extra.locales` | table |  |
| `extra.reading_time` | table |  |
| `extra.giscus` | table |  |

| key | type | default value |
| --- | --- | --- |
| `extra.style.bg_color` | string | `"#f4f4f5"` |
| `extra.style.bg_dark_color` | string | `"#18181b"` |
| `extra.style.header_blur` | boolean |  |
| `extra.style.header_color` | string | `"#e4e4e7"` |
| `extra.style.header_dark_color` | string | `"#27272a"` |

| key | type | default config value |
| --- | --- | --- |
| `extra.profile.avatar_url` | string | `"icons/github.svg"` |
| `extra.profile.avatar_invert` | boolean | `true` |
| `extra.profile.name` | table |  |
| `extra.profile.bio` | table |  |
| `extra.profile.social` | array of tables |  |
| `extra.profile.open_graph` | table |

| key | type | example |
| --- | --- | --- |
| `extra.profile.name[lang]` | string | `"Your Name"` |
| `extra.profile.bio[lang]` | string | `"A blog by Your Name"` |

| key | type | supports `$BASE_URL` | example |
| --- | --- | --- | --- |
| `extra.profile.social[].name` |  | string | `"github"` |
| `extra.profile.social[].url` | yes | string | `"https://github.com/salif"` |

| key | type | example |
| --- | --- | --- |
| `extra.profile.open_graph.image` | string | `"icons/github.svg"` |
| `extra.profile.open_graph.first_name` | string |  |
| `extra.profile.open_graph.last_name` | string |  |
| `extra.profile.open_graph.username` | string |  |
| `extra.profile.open_graph.gender` | string |  |
| `extra.profile.open_graph.fb_app_id` | string |  |
| `extra.profile.open_graph.fb_admins` | array of strings |  |
| `extra.profile.open_graph.fediverse_username` | string | "user" |
| `extra.profile.open_graph.fediverse_server` | string | "mastodon.social" |

| key | type |
| --- | --- |
| `extra.menu[].url` | string |
| `extra.menu[].name` | table |
| `extra.menu[].name[lang]` | string |

| key | type | supports `$BASE_URL` | example |
| --- | --- | --- | --- |
| `extra.footer.since` | number |  | 2024 |
| `extra.footer.license_name` | string |  | `"CC BY-SA 4.0"` |
| `extra.footer.license_url` | string | yes | `"https://creativecommons.org/licenses/by-sa/4.0/deed"` |
| `extra.footer.privacy_policy_url` | string | yes | `"$BASE_URL/privacy-policy/"` |
| `extra.footer.terms_of_service_url` | string | yes | `"$BASE_URL/terms-of-service/"` |
| `extra.footer.search_page_url` | string | yes | `"$BASE_URL/search/"` |

| key | type | default value | example |
| --- | --- | --- | --- |
| `extra.locales[lang].locale` | string |  | `"en_US"` |
| `extra.locales[lang].date_format` | string | `%F`  |  |
| `extra.locales[lang].date_format_archive` | string | `%m-%d` |  |

For date format, see [chrono docs](https://docs.rs/chrono/0.4/chrono/format/strftime/index.html)

| key | type | default config value | allowed strings |
| --- | --- | --- | --- |
| `extra.reading_time[lang]` | array of strings | `["reading_time"]` | `reading_time`, `word_count` |

| key | type | default config value | default value |
| --- | --- | --- | --- |
| `extra.giscus.repo` | string | `""` |  |
| `extra.giscus.repo_id` | string | `""` |  |
| `extra.giscus.category` | string | `""` |  |
| `extra.giscus.category_id` | string | `""` |  |
| `extra.giscus.mapping` | string | `"pathname"` | `pathname` |
| `extra.giscus.strict` | number | `1` | `1` |
| `extra.giscus.reactions_enabled` | number | `0` | `0` |
| `extra.giscus.emit_metadata` | number | `0` | `0` |
| `extra.giscus.input_position` | string | `"top"` | `top` |
| `extra.giscus.theme` | string | `"light"` | `light` |
| `extra.giscus.lang` | string | `"en"` | `en` |
| `extra.giscus.loading` | string | `"lazy"` | `lazy` |

## Front matter

```toml
+++
title = ""
description = ""
date = ""
[taxonomies]
tags = ["", ""]
[extra]
comment = false
math = false
mermaid = false
[extra.cover]
image = ""
alt = ""
[extra.open_graph]
+++
```

| `extra.open_graph` keys | type | example |
| --- | --- | --- |
| `content_tier` | string | `"free"`, `"locked"`, or `"metered"` |
| `locations` | array of strings | `["county:COUNTY"]` or `["city:CITY,COUNTY"]` |
| `section` | string |  |
| `tags` | array of strings |  |
| `opinion` | boolean | `"true"` or `"false"` |
| `audio` | string |  |
| `audio_mime` | string |  |
| `video` | string |  |
| `video_mime` | string |  |
| `url` | string |  |

### YAML Front Matter

```yaml
---
title: ""
description: ""
date: ""
taxonomies:
  tags: ["", ""]
extra:
  comment: false
  math: false
  mermaid: false
  cover:
    image: ""
    alt: ""
  open_graph:
---
```

## License

[MIT License](https://codeberg.org/salif/linkita/src/branch/linkita/LICENSE)

Copyright (c) 2023-present, st1020

Copyright (c) 2024-present, salif
