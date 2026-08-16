# Changelog

## tera1

Linkita was previously hosted on Codeberg and was migrated to GitHub.
If you are using the Codeberg repository and are a submodule user,
follow these instructions to switch to the new repository:

```sh
git submodule update --init
# Remove the old submodule
git submodule deinit -f themes/linkita
rm -rf .git/modules/themes/linkita
git rm -f themes/linkita

# Choose a branch:
# Choose the main branch for Zola versions newer than 0.23.0,
# or the tera1 branch for older versions. 

# Add new submodule using the main branch
git submodule add -b main https://github.com/salif/linkita.git themes/linkita

# Add new submodule using the tera1 branch
git submodule add -b tera1 https://github.com/salif/linkita.git themes/linkita
```

## v4

- Add `extra.taxonomy_sorting` config variable and sort terms in taxonomy pages by the number of posts by default.
- Add `newtab` bool to `project.links` in the projects shortcode.
- Add localization for Ukrainian, Kazakh, and Russian.
- Add localization for Persian.
- Change the `extra.page_info` variable to use css class instead of middot and include authors by default.
- Add localization for Finnish.
- Add page number to paginated page titles.
- Remove the `i18n.json` file and add `i18n` folder and files for each language.
- Add `i18n/menu.json` file and `extra.menu_i18n` config variable. Remove the `names_i18n` menu variable.
- Upgrade Tailwind CSS to v4.
- Add `inline-code-fix.css` file that can be used to remove inline code backticks.
- Rename `extra.languages[lang].language_code` config variable to `extra.languages[lang].hreflang`.
- Remove `extra.languages[lang].i18n_code` and add `extra.languages[lang].num_format` config variable.
- Add `theme_select` and `translations_select` options for header buttons.
- Rename macros: `m_i18n` to `_str`, `m_url` to `_link`, `m_profiles` to `_profile`.
- Rename `extra.urls_to_index_html` config variable to `extra.ugly_urls`.

## v3

- Add frontmatter variables to override the `extra.style` config variable:
  `extra.style.bg_color`, `extra.style.bg_dark_color`, `extra.style.header_color`, `extra.style.header_dark_color`.
- Allow `pages.html` and `archive.html` to be used in a section.
- Add `extra.relative_urls` config variable to use relative urls that do not contain the base url.
- Add `extra.urls_to_index_html` config variable to browse the site without a webserver.
- Remove the `date_format_archive` config variable and add `extra.date_format`
  frontmatter variable for the `archive.html` template.
- Change the `extra.page_info` variable to an array of objects.
- Add `extra.page_info_on_paginator` config variable. The frontmatter variable is `extra.page_info`,
  but its default value is not the `extra.page_info` config variable.
- Remove `extra.open_graph.video` and `extra.open_graph.audio` frontmatter variables.
- Use page slug in `archive.html` and `taxonomy_list.html` when page title is empty.

## v2

- Rename the local storage key for the color scheme.
- Always show translation button on bilingual pages.
- Add support for `extra.profile` frontmatter variable in the `pages.html` and `archive.html` templates.
- Remove `extra.open_graph.cover_type` frontmatter variable.
- Add localization for Simplified Chinese, Turkish, Arabic, Korean, Japanese, French, and Spanish.
- Add localization for Czech.
- Add `extra.post_navigation` config variable and reverse post navigation direction.
  It can be reverted by setting `extra.post_navigation = "reversed"` config variable.
- Deprecate `extra.goatcounter.src` config variable.
- Add social icons for `linkedin`, `mastodon`, `matrix`, `youtube`.
- Self-host KaTeX, instantpage, and gc. It can be reverted by setting `extra.use_cdn = true` config variable.
- Rename `extra.open_graph.cover_width` frontmatter variable to `extra.cover.width` and
  `extra.open_graph.cover_height` to `extra.cover.height`.
- Rename `extra.languages[lang].art_x_lang` config variable to `extra.languages[lang].language_code`.
- Convert the project template to shortcode. Use the `pages.html` template instead and
  use `projects(path="data.toml", format="toml")` shortcode.
- Add `extra.toc` config and frontmatter variable. Table of contents can be disabled by setting to `false`.
  It can be expanded by default by setting `toc = { open = true }`.
- Add `head_end` inject point and put `injects/head` before js and css files.
  You may need to rename your `injects/head.html` file to `injects/head_end.html`.
- Remove the `extra.post_navigation` config variable and add `extra.invert_page_navigation` config variable.
- Remove the `email` and `url` config variables of `extra.profiles.your_username` as they are not used anywhere.
- Replace `taxonomy_list_description` with `taxonomy_descriptions[taxonomy.name]` and
  `taxonomy_single_description` with `term_descriptions[taxonomy.name]`.
- Rename the `width-scroll` class to `horizontal-scroll`.
- Apply linebreaksbr and truncate to title and description in head.
- Add `extra.page_summary_on_paginator` config and frontmatter variable to prioritize summary over description.
