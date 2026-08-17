#!/usr/bin/env -S just --justfile

this := just_executable() + " -f " + quote(source_file())
zola := if `git branch --show-current` == "tera1" { "zola-v0.22.1" } else { "zola" }

_:
    @{{ this }} --list --unsorted

[group('dev')]
watch_css:
    pnpm run dev:css

[group('dev')]
build_css:
    pnpm run build:css
    pnpm run build:nomincss

[group('dev')]
build_js:
    pnpm run build:js

[group('dev')]
watch_js_theme:
    inotifywait -m static/js/theme/ -e modify -q | while read; do pnpm run build:js; done

[group('dev')]
sync_i18n:
    node static/i18n/sync.js

[group('dev')]
update_favicon:
    magick -background transparent -define "icon:auto-resize=16,24,32,48,64" \
        static/apple-touch-icon.png static/favicon.ico

[group('update_assets')]
update_pnpm:
    pnpm update

[extension('.mjs')]
[group('update_assets')]
[script("node")]
sync_simple_icons:
    import fs from "fs"
    const icons = [
        "bluesky", "instagram", "mastodon", "matrix", "youtube",
        "codeberg", "forgejo", "git", "github", "npm", "tangled",
        "buymeacoffee", "kofi", "liberapay", "opencollective",
    ]
    for (const icon of icons) {
        fs.copyFileSync(`node_modules/simple-icons/icons/${icon}.svg`, `static/icons/${icon}.svg`)
    }

[group('update_assets')]
sync_gc:
    curl -L "https://gc.zgo.at/count.js" > static/js/gc.js
    pnpm run build:gcJS

[group('update_assets')]
[script]
sync_instantpage:
    cd node_modules/instant.page/
    pnpm run minify
    cd -
    cp node_modules/instant.page/instantpage.min.js static/js/instantpage.min.js

[group('update_assets')]
[script]
sync_katex:
    rm -rf static/katex
    mkdir static/katex static/katex/fonts static/katex/contrib
    cp node_modules/katex/dist/README.md static/katex/
    cp node_modules/katex/dist/*.min.* static/katex/
    cp node_modules/katex/dist/contrib/*.min.* static/katex/contrib/
    cp node_modules/katex/dist/fonts/*.woff2 static/katex/fonts/
    mv static/katex/README.md static/katex/KaTeX.md

[group('git')]
[private]
branch_is branch:
    @[ "$(git branch --show-current)" == "{{ branch }}" ]

[group('git')]
[private]
[script]
commit_diff:
    set -eux
    if ! git diff --quiet --cached -- templates; then
        {{ this }} build_css;
        git diff --quiet -- static/main.min.css;
        git diff --quiet -- static/main.css;
    fi
    if ! git diff --quiet --cached -- static/js/theme; then
        {{ this }} build_js;
        git diff --quiet -- static/js/zola-theme.min.js;
    fi

[confirm]
[group('git')]
[private]
commit_on_theme: commit_diff
    {{ zola }} check --skip-external-links
    git commit

[group('git')]
commit_main: (branch_is "main") && commit_on_theme

[group('git')]
commit_tera1: (branch_is "tera1") && commit_on_theme

[group('git')]
push_main remote='github':
    git push {{ remote }} main:main

[group('git')]
push_tera1 remote='github':
    git push {{ remote }} tera1:tera1
