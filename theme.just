#!/usr/bin/env -S just --justfile

this_file := source_file()
this := just_executable() + " -f " + quote(this_file)

_:
    @{{ this }} --list --unsorted

[doc('Format source code')]
[group('dev')]
format:
    {{ this }} --fmt --unstable

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
sync_simple_icons:
    #!/usr/bin/env node
    import fs from "fs"
    const icons = [
        "bluesky", "instagram", "mastodon", "matrix", "youtube",
        "codeberg", "forgejo", "git", "github", "npm",
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
add_git_remotes:
    git remote add codeberg 'git@codeberg.org:salif/linkita.git'
    git remote add github 'git@github.com:salif/linkita.git'
    git remote add kita 'https://github.com/st1020/kita.git'

[group('git')]
[private]
[script]
commit_diff:
    set -eux
    if ! git diff --quiet --cached -- templates; then
        {{ this }} build_css format;
        git diff --quiet -- static/main.min.css;
        git diff --quiet -- static/main.css;
    fi
    if ! git diff --quiet --cached -- static/js/theme; then
        {{ this }} build_js;
        git diff --quiet -- static/js/zola-theme.min.js;
    fi

[doc('check and commit')]
[group('git')]
commit: commit_diff
    zola check --skip-external-links
    git commit

[doc('push linkita branch')]
[group('git')]
push_linkita:
    git push codeberg linkita:linkita
    git push github linkita:linkita

[doc('push v4 branch')]
[group('git')]
push_v4:
    git push codeberg v4:v4
    git push github v4:v4

[confirm]
[private]
confirm:
