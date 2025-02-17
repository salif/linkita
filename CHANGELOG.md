# Changelog

All notable changes to this theme will be documented in this file.

## [Unreleased](https://codeberg.org/salif/linkita/compare/v1.2025_01_04.0..linkita)

- Add support for `extra.profile` frontmatter variable in the `pages.html` and `archive.html` templates.
- Remove `extra.open_graph.cover_type` frontmatter variable.
- Add localization for Simplified Chinese, Turkish, Arabic, Korean, Japanese, French, and Spanish.
- Add localization for Czech.
- Add `extra.post_navigation` config variable. Post navigation can be disabled by setting `extra.post_navigation = "disabled"`.
- Add post navigation to the `pages.html` template if `extra.post_navigation` config variable is set to any value, except `"disabled"`.
- Reverse post navigation direction. It can be reverted by setting `extra.post_navigation = "reversed"` config variable.
- Deprecate `extra.goatcounter.src` config variable.
- Add social icons for `linkedin`, `mastodon`, `matrix`, `youtube`.
- Self-host KaTeX, instantpage, and gc. It can be reverted by setting `extra.use_cdn = true` config variable.
- Rename `extra.open_graph.cover_width` frontmatter variable to `extra.cover.width`, and `extra.open_graph.cover_height` to `extra.cover.height`.
- Rename `extra.languages[lang].art_x_lang` config variable to `extra.languages[lang].language_code`.
- Convert the project template to shortcode. Use the `pages.html` template instead and use `projects(path="data.toml", format="toml")` shortcode.
- Add `extra.toc` config and frontmatter variable. Table of contents can be disabled by setting to `false`. It can be expanded by default by setting `toc = { open = true }`.

### Internal changes

- Refactor css vars for body and header.
- Use objects for JS function arguments.
- Rename the local storage key for the color scheme.
- Always show translation button on bilingual pages.
- Refactor cover image metadata code.

## [v1.2025_01_04.0](https://codeberg.org/salif/linkita/compare/v0.2024_11_01.0..v1.2025_01_04.0)

See git commits.

## [v0.2024_11_01.0](https://codeberg.org/salif/linkita/compare/e8746d1a74..v0.2024_11_01.0)

See git commits.
