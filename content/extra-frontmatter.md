+++
title="Extra frontmatter"
description = "Optional variables used by the Linkita theme."
date = 2025-04-11
updated = 2025-04-21
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

# Default value: config.extra.page_summary_on_paginator
page_summary_on_paginator = true

# Default value:
#  config.extra.page_info or config.extra.page_info_on_paginator
page_info = []

# Default value: config.extra.toc
toc = true

# For the archive.html template.
section = "_index.md"

[extra.cover]

# Path to the cover image.
image = ""
# A description of the cover image.
alt = ""

# Width of the cover image in pixels.
# Default value: get_image_metadata()
width =
# Height of the cover image in pixels.
# Default value: get_image_metadata()
height =
```

## Open Graph variables

```toml ,name=frontmatter
[extra.open_graph]

# When the article is out of date after.
# e.g. 2024-02-29
# No default value.
expiration_time =

# Describes the tier status for an article.
# e.g. "free", "locked", or "metered".
# No default value.
content_tier = ""

# Defines the location to target for the article.
# e.g. ["county:COUNTY"] or ["city:CITY,COUNTY"]
# No default value.
locations = []

# A high-level section name. e.g. "Technology".
# No default value.
section = ""

# Indicates whether the article is an opinion piece or not.
# Type: boolean. No default value.
opinion =

# Set only if different from canonical page URL.
# Default value: current_url
url = ""
```

## Sitemap variables

```toml ,name=frontmatter
[extra.sitemap]

# Set only if different from "page.updated".
# Default value: page.updated
updated = ""

# Valid values: "always", "hourly", "daily",
# "weekly", "monthly", "yearly", "never".
# No default value.
changefreq = ""

# Valid values range from 0.0 to 1.0.
# The default priority of a page is 0.5.
# No default value.
priority = ""
```
