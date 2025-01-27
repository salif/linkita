# Changelog

All notable changes to this theme will be documented in this file.

## [Unreleased](https://codeberg.org/salif/linkita/compare/v1.2025_01_04.0..linkita)

- Add support for `extra.profile` frontmatter variable in the `pages.html` and `archive.html` templates.
- Remove `extra.open_graph.cover_type` frontmatter variable and refactor cover image metadata code.
- Add localization for Simplified Chinese, Turkish, Arabic, Korean, Japanese, French, and Spanish.
- Add localization for Czech.
- Add `extra.post_navigation` config variable. Post navigation can be disabled by setting `extra.post_navigation = "disabled"`.
- Add post navigation to the `pages.html` template if `extra.post_navigation` config variable is set to any value, except `"disabled"`.
- Reverse post navigation direction. It can be reverted by setting `extra.post_navigation = "reversed"` config variable.

### Internal changes

- Refactor css vars for body and header.
- Use objects for JS function arguments.
- Rename the local storage key for the color scheme.
- Always show translation button on bilingual pages.

## [v1.2025_01_04.0](https://codeberg.org/salif/linkita/compare/v0.2024_11_01.0..v1.2025_01_04.0)

See git commits.

## [v0.2024_11_01.0](https://codeberg.org/salif/linkita/compare/e8746d1a74..v0.2024_11_01.0)

See git commits.
