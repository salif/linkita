+++
title="Extra frontmatter"
description = "Optional variables used by the Linkita theme."
date = 2025-04-11
#updated =
[taxonomies]
authors = ["salif"]
+++

```toml ,name=frontmatter
[extra]

# Enable comments.
comment = true

# Enable KaTeX support.
math = true

# Enable Mermaid support.
mermaid = true

# See `config.extra.page_info`.
# (type: array of strings; default value: config.extra.page_info;)
page_info = []

# See `config.extra.page_summary_on_paginator`.
# (type: boolean; default value: config.extra.page_summary_on_paginator;)
page_summary_on_paginator = true

# See `config.extra.toc`.
# (type: boolean or object; default value: config.extra.toc;)
toc = true

[extra.cover]

# Path to the cover image.
# (type: string; no default value;)
image = ""
# A description of the cover image.
# (type: string; no default value;)
alt = ""

# Width of the cover image in pixels.
# (type: number; default value: uses `get_image_metadata()`;)
width =
# Height of the cover image in pixels.
# (type: number; default value: uses `get_image_metadata()`;)
height =
```

## Open Graph variables

```toml ,name=frontmatter
[extra.open_graph]

# When the article is out of date after. e.g. `2024-02-29`.
# (type: datetime; no default value;)
expiration_time =

# Describes the tier status for an article. e.g. `free`, `locked`, or `metered`.
# (type: string; no default value;)
content_tier = ""

# Defines the location to target for the article. e.g. `["county:COUNTY"]` or `["city:CITY,COUNTY"]`.
# (type: array of strings; no default value;)
locations = []

# A high-level section name. e.g. `Technology`.
# (type: string; no default value;)
section = ""

# Indicates whether the article is an opinion piece or not. e.g. `true` or `false`.
# (type: boolean; no default value;)
opinion =

# The URL for the audio.
# (type: string; no default value;)
audio = ""

# MIME type of the audio. e.g. `audio/vnd.facebook.bridge`, `audio/mpeg`.
# (type: string; no default value;)
audio_type = ""

# The URL for the video.
# (type: string; no default value;)
video = ""

# MIME type of the video. e.g. `application/x-shockwave-flash`, `video/mp4`.
# (type: string; no default value;)
video_type = ""

# Width of the video in pixels.
# (type: number; no default value;)
video_width =

# Height of the video in pixels.
# (type: number; no default value;)
video_height =

# Set only if different from canonical page URL.
# (type: string; default value: current_url;)
url = ""
```

## Sitemap variables

```toml ,name=frontmatter
[extra.sitemap]

# Set only if different from `page.updated`.
# (type: string; default value: page.updated;)
updated =

# Valid values are `always`, `hourly`, `daily`, `weekly`, `monthly`, `yearly`, `never`.
# (type: string; no default value;)
changefreq =

# Valid values range from 0.0 to 1.0. The default priority of a page is 0.5.
# (type: string; no default value;)
priority =
```
