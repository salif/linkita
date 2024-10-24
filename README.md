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

### i18n

- `en`: English
- `bg`: Bulgarian
- `eo`: Esperanto

## Installing

1. Add this theme as a submodule:

```sh
git submodule add https://codeberg.org/salif/linkita.git themes/linkita
```

Alternatively, clone the repository: `git clone https://codeberg.org/salif/linkita.git themes/linkita`.

2. It is recommended to switch from the `linkita` branch to the latest release:

```sh
cd themes/linkita
npm run switch-to-latest
```

Alternatively, use this command: `./justfile switch-to-latest`.

3. Set `linkita` as your theme in your `config.toml`.

```toml
theme = "linkita"
```

Also, make sure you have `title` and `default_language` set in your `config.toml`.

4. Copy translations

Open `themes/linkita/config.toml` and copy all translations to your `config.toml`.
The English translation is under `[languages.en.translations]`.

Otherwise you will get this error:

```
Error: Reason: Function call 'trans' failed
Error: Reason: Failed to retrieve term translation
```

## Updating

```sh
git submodule update --remote themes/linkita
cd themes/linkita
npm run switch-to-latest
```

## Usage

### Front matter

```toml
+++
title = ""
description = ""
# date = 
# updated = 
[taxonomies]
tags = []
[extra]
# comment = true
# math = true
# mermaid = true
[extra.cover]
# image = ""
# alt = ""
[extra.open_graph]
+++
```

| `extra.open_graph` keys | type | example | comment |
| --- | --- | --- | --- |
| `cover_type` | string | `image/jpeg`, `image/gif`, `image/png` | MIME type of the cover image |
| `cover_width` | string |  | Width of the cover image in pixels |
| `cover_height` | string |  | Height of the cover image in pixels |
| `expiration_time` | string | `"2024-02-29"` | When the article is out of date after |
| `content_tier` | string | `"free"`, `"locked"`, or `"metered"` | Describes the tier status for an article |
| `locations` | array of strings | `["county:COUNTY"]` or `["city:CITY,COUNTY"]` | Defines the location to target for the article |
| `section` | string |  | A high-level section name. E.g. Technology |
| `tags` | array of strings |  | Tag words associated with this article. |
| `opinion` | string | `"true"` or `"false"` | Indicates whether the article is an opinion piece or not |
| `audio` | string |  | The URL for the audio |
| `audio_type` | string | `audio/vnd.facebook.bridge`, `audio/mpeg` | MIME type of the audio |
| `video` | string |  | The URL for the video |
| `video_type` | string | `application/x-shockwave-flash`, `video/mp4` | MIME type of the video |
| `video_width` | string |  | Width of the video in pixels |
| `video_height` | string |  | Height of the video in pixels |
| `url` | string |  | Set only if different from canonical page URL |

### YAML front matter

```yaml
---
title: ""
description: ""
date: 
updated: 
taxonomies:
  tags:
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

### Inject support

You can easily use inject to add new features to your side without modifying the theme itself.

To use inject, you need to add some HTML files to the `templates/injects` directory.

The available inject points are: `head`, `header_nav`, `body_start`, `body_end`, `page_start`, `page_end`, `footer`, `page_info`.

For example, to load a custom script, you can add a `templates/injects/head.html` file:

```html
<script src="js-file-path-or-cdn-url.js"></script>
```

## Configuring

Configuration options used by this theme.

Most of them are optional. Copy-paste the examples into your `config.toml` file
and comment out the options you don't use instead of setting empty values.

| key | type | comment |
| --- | --- | --- |
| `default_language` | string | The default language |
| `author` | string | The default author for pages |
| `title` | string | The site title |
| `description` | string | The site description |
| `generate_feeds` | boolean | Automatically generated feed |
| `feed_filenames` | array of strings | The filenames to use for the feeds |
| `translations` | table | Copy-paste them from the theme's `config.toml` file |
| `extra` | table |  |

Taxonomies with translated names are `tags` and `categories`.

```toml
default_language = "en"
author = "your_username" # or "your@email (Name)"
title = "Site Title"
description = "Site Description"
generate_feeds = true
feed_filenames = ["atom.xml"] # or ["rss.xml"]
```

```toml
[[taxonomies]]
name = "tags"
feed = true
paginate_by = 5
```

Add more languages ​​by replacing `fr` from the example with the language code.

```toml
[languages.fr]
title = "Site Title in French"
description = "Site Description in French"
generate_feeds = true
feed_filenames = ["atom.xml"]

[[languages.fr.taxonomies]]
name = "tags"
feed = true
paginate_by = 5
```

---

| key | type | comment |
| --- | --- | --- |
| `extra.math` | boolean | Enable KaTeX math formula support globally |
| `extra.mermaid` | boolean | Enable Mermaid support globally |
| `extra.comment` | boolean | Enable comment support globally |
| `extra.show_updated_date` | boolean | Show the last updated date of posts |
| `extra.style` | table | The theme style config |
| `extra.profile` | table | The profile on home page |
| `extra.menu` | array of tables | The top menu |
| `extra.footer` | table | The page footer options |
| `extra.locales` | table | Locale codes and date formats |
| `extra.reading_time` | table | Word count and reading time for posts |
| `extra.goatcounter` | table | Enable web analytics |
| `extra.giscus` | table | The giscus comment options, only available when comment is enabled |

```toml
[extra]
math = false
mermaid = false
comment = false
show_updated_date = true
```

---

| key | type | default value | comment |
| --- | --- | --- | --- |
| `extra.style.bg_color` | string | `"#f4f4f5"` | The custom background color |
| `extra.style.bg_dark_color` | string | `"#18181b"` | The custom background color in dark mode |
| `extra.style.header_blur` | boolean |  | Enable header blur |
| `extra.style.header_color` | string | `"#e4e4e7"` | The custom header color, only available when `header_blur` is false |
| `extra.style.header_dark_color` | string | `"#27272a"` | The custom header color in dark mode, only available when `header_blur` is false |

```toml
[extra.style]
bg_color = "#f4f4f5"
bg_dark_color = "#18181b"
header_blur = false
header_color = "#e4e4e7"
header_dark_color = "#27272a"
```

---

| key | type | comment |
| --- | --- | --- |
| `extra.profile.avatar_url` | string | The URL of avatar |
| `extra.profile.avatar_invert` | boolean | Invert color in dark mode |
| `extra.profile.name` | table | The profile name on the home page |
| `extra.profile.bio` | table | The profile bio on the home page |
| `extra.profile.social` | array of tables | The social icons below the profile on the home page |
| `extra.profile.open_graph` | table |  |

```toml
[extra.profile]
avatar_url = "icons/github.svg"
avatar_invert = true
```

---

| key | type |
| --- | --- |
| `extra.profile.name[lang]` | string |
| `extra.profile.bio[lang]` | string |

```toml
[extra.profile.name]
en = "Profile Name in English"
# fr = "Profile Name in French"

[extra.profile.bio]
en = "Profile Bio in English"
# fr = "Profile Bio in French"
```

---

| key | type |
| --- | --- |
| `extra.profile.social[].name` | string |
| `extra.profile.social[].url` | string |

The `name` should be the file name of `static/icons/*.svg` or the icon name of
[simpleicons.org](https://simpleicons.org/). The `url` supports `$BASE_URL`.

```toml
[[extra.profile.social]]
name = "github"
url = "https://github.com/username"

[[extra.profile.social]]
name = "bluesky"
url = "https://bsky.app/profile/username"

[[extra.profile.social]]
name = "rss"
url = "$BASE_URL/atom.xml"
```

---

| key | type | comment |
| --- | --- | --- |
| `extra.profile.open_graph.image` | string | The URL of social image |
| `extra.profile.open_graph.image_alt` | string | A description of what is in the social image |
| `extra.profile.open_graph.first_name` | string | A name normally given to an individual by a parent or self-chosen |
| `extra.profile.open_graph.last_name` | string | A name inherited from a family or marriage and by which the individual is commonly known |
| `extra.profile.open_graph.username` | string | A short unique string to identify them |
| `extra.profile.open_graph.gender` | string | Their gender |
| `extra.profile.open_graph.fb_app_id` | string | Set fb:app_id |
| `extra.profile.open_graph.fb_admins` | array of strings | Set fb:admins |
| `extra.profile.open_graph.fediverse_username` | string | Your username if you have a Fediverse account |
| `extra.profile.open_graph.fediverse_server` | string | Your Fediverse server |

```toml
[extra.profile.open_graph]
image = "icons/github.svg"
first_name = "Your first name"
last_name = "Your last name"
username = "Your username"
gender = "female" # or "male"

fb_app_id = "Your fb app ID"
fb_admins = ["YOUR_USER_ID"]
# Example for "@user@mastodon.social"
fediverse_username = "user"
fediverse_server = "mastodon.social"
```

---

| key | type |
| --- | --- |
| `extra.menu[].url` | string |
| `extra.menu[].name` | table |
| `extra.menu[].name[lang]` | string |

```toml
[[extra.menu]]
url = "$BASE_URL/projects/"
[extra.menu.name]
en = "Projects"
# fr = "Projects in French"

[[extra.menu]]
url = "$BASE_URL/archive/"
[extra.menu.name]
en = "Archive"
# fr = "Archive in French"

[[extra.menu]]
url = "$BASE_URL/tags/"
[extra.menu.name]
en = "Tags"
# fr = "Tags in French"

[[extra.menu]]
url = "$BASE_URL/about/"
[extra.menu.name]
en = "About"
# fr = "About in French"
```

---

| key | type |
| --- | --- |
| `extra.footer.since` | number |
| `extra.footer.license_name` | string |
| `extra.footer.license_url` | string |
| `extra.footer.privacy_policy_url` | string |
| `extra.footer.terms_of_service_url` | string |
| `extra.footer.search_page_url` | string |

`$BASE_URL` is supported in the `_url` options.

```toml
[extra.footer]
since = 2024
license_name = "CC BY-SA 4.0"
license_url = "https://creativecommons.org/licenses/by-sa/4.0/deed"
privacy_policy_url = "$BASE_URL/privacy-policy/"
terms_of_service_url = "$BASE_URL/terms-of-service/"
search_page_url = "$BASE_URL/search/"
```

---

| key | type | default value |
| --- | --- | --- |
| `extra.locales[lang].locale` | string |  |
| `extra.locales[lang].date_format` | string | `%F` |
| `extra.locales[lang].date_format_archive` | string | `%m-%d` |

For date format, see [chrono docs](https://docs.rs/chrono/0.4/chrono/format/strftime/index.html).

```toml
[extra.locales.en]
locale = "en_US"
date_format = "%x"
date_format_archive = "%m-%d"

[extra.locales.fr]
locale = "fr_FR"
date_format = "%x"
date_format_archive = "%m-%d"
```

---

| key | type | strings |
| --- | --- | --- |
| `extra.reading_time[lang]` | array of strings | `reading_time`, `word_count` |

```toml
[extra.reading_time]
en = ["reading_time"]
# fr = ["reading_time", "word_count"]
```

---

| key | type |
| --- | --- |
| `extra.goatcounter.endpoint` | string |
| `extra.goatcounter.src` | string |

```toml
[extra.goatcounter]
endpoint = "https://MYCODE.goatcounter.com/count"
src = "//gc.zgo.at/count.js"
```

---

| key | type | default value |
| --- | --- | --- |
| `extra.giscus.repo` | string |  |
| `extra.giscus.repo_id` | string |  |
| `extra.giscus.category` | string |  |
| `extra.giscus.category_id` | string |  |
| `extra.giscus.mapping` | string | `pathname` |
| `extra.giscus.strict` | number | `1` |
| `extra.giscus.reactions_enabled` | number | `0` |
| `extra.giscus.emit_metadata` | number | `0` |
| `extra.giscus.input_position` | string | `top` |
| `extra.giscus.theme` | string | `light` |
| `extra.giscus.lang` | string | `en` |
| `extra.giscus.loading` | string | `lazy` |

```toml
[extra.giscus]
repo = ""
repo_id = ""
category = ""
category_id = ""
mapping = "pathname"
strict = 1
reactions_enabled = 0
emit_metadata = 0
input_position = "top"
theme = "light"
lang = "en"
loading = "lazy"
```

## License

See the [MIT License](https://codeberg.org/salif/linkita/src/branch/linkita/LICENSE) file.

## Contributing

Pull requests are welcome on [Codeberg](https://codeberg.org/salif/linkita) and [Github](https://github.com/salif/linkita).
Open *bug reports* and *feature requests* on [Codeberg](https://codeberg.org/salif/linkita/issues).

If you want to add new translations or correct existing ones, please find another person who speaks the language to confirm your translations are good, by adding a comment or review on your pull request.

## Blogs using this theme

- [salif.eu](https://salif.eu): My personal website (soon)

If you use Linkita, feel free to create a pull request to add your site to this list.
