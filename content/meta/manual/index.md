+++
title = "Create Content Pages"
description = "A guide to manually creating pages and sections"
date = 2026-09-11
path = "manual"
[taxonomies]
tags = ["meta"]
authors = ["salif"]
+++

If you started your site using the [linkita-start template](https://github.com/salif/linkita-start), all the essential sections and sample files are already configured for you.

If you performed a **manual installation**, this guide walks you through creating the required content directory structure, home page, blog archive, standalone pages.

## Pages and Posts

### Home page

Create a `content/_index.md` file and set `extra.profile` to your username:

```toml ,name=content/_index.md
+++
title = ""
description = ""
sort_by = "date"
paginate_by = 4
[extra]
profile = "your_username"
+++
```

Repeat this for each language supported by your site. For example, French uses `content/_index.fr.md`.

See [Profiles](https://salif.github.io/linkita/read-me/#profiles) for configuration details.

### Posts

In the `content` directory, create a subdirectory named `blog` (or another name of your choice).

Create a section file at `content/blog/_index.md`:

```toml ,name=content/blog/_index.md
+++
title = "Archive"
description = ""
template = "archive.html"
transparent = true
[extra]
# Change it to "%b %d" if `locale` is not set in config.
date_format = "MMM dd"
+++
```

Create an article such as `content/blog/hello.md`:

```md ,name=content/blog/hello.md
+++
title = "Title"
date = 2026-12-30
+++

Summary <!-- more -->

## Hello, world!
```

### Pages

The default template (`page.html`) is intended for blog posts. For standalone pages (such as an About or Contact page), use the `pages.html` template.

In the `content` directory, create a subdirectory named `pages` along with `content/pages/_index.md`:

```toml ,name=content/pages/_index.md
+++
render = false
page_template = "pages.html"
+++
```

Then create a page file, e.g. `content/pages/about.md`:

```md ,name=content/pages/about.md
+++
title = "About me"
description = ""
path = "about"
+++

## Hello, world!
```

You can also create [a page for your projects](https://salif.github.io/linkita/components/#projects).

## Setting page authors

Choose one of the following approaches depending on your site's author structure:

### Option A: Using `page.authors` and `config.author`

The default author for posts is set using the `author` field in your `zola.toml` (or `config.toml`).

If the default author is the sole author of a post, you do not need to set `authors` in the front matter. To override the default author, specify `authors` explicitly:

```toml ,name=frontmatter
+++
authors = ["author_username"]
+++
```

### Option B: Using taxonomies

Recommended if your site features multiple contributors or a collaborative team. To use this approach, configure the `authors` taxonomy in each post:

```toml ,name=frontmatter
+++
[taxonomies]
authors = ["author_username", "author2_username"]
+++
```
