+++
title = "Theme Config Guide"
date = "2022-10-20"
description = "The config fo Linkita theme."
[taxonomies]
tags = ["theme", "markdown"]
+++

You can customize Linkita theme by editing `config.toml`.

Here are all the Linkita theme options:

```toml
# The Linkita theme style config.
[extra]
# Enable KaTex math formula support globally.
math = false
# Enable mermaid support globally.
mermaid = false
# Enable comment support globally.
comment = false

[extra.style]
# The custom background color.
# bg_color = ""

# The custom background color in dark mode.
# bg_dark_color = ""

# Enable header blur.
# header_blur = true

# The custom header color, only available when `header_blur` is false.
# header_color = ""

# The custom header color in dark mode, only available when `header_blur` is false.
# header_dark_color = ""

# The profile on home page.
[extra.profile]
name = "Linkita - Zola Theme"
bio = "Linkita is a Zola theme based on Kita."
# The URL of avatar.
avatar_url = "icons/github.svg"
# Invert color in dark mode.
avatar_invert = true

# The social icons below the profile on the home page.
[[extra.profile.social]]
name = "github"
url = "https://github.com/salif/linkita"

[[extra.profile.social]]
name = "twitter"
url = "https://github.com/salif/linkita"

[[extra.profile.social]]
name = "rss"
url = "$BASE_URL/atom.xml"

# The top menu.
[[extra.menu]]
name = "Projects"
url = "$BASE_URL/projects"

[[extra.menu]]
name = "Archive"
url = "$BASE_URL/archive"

[[extra.menu]]
name = "Tags"
url = "$BASE_URL/tags"

[[extra.menu]]
name = "About"
url = "$BASE_URL/about"

# The page footer options.
[extra.footer]
since = 2020
license = "CC BY-SA 4.0"
license_url = "https://creativecommons.org/licenses/by-sa/4.0/deed"

# The giscus comment options, only available when comment is enabled.
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
