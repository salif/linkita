#!/usr/bin/env -S just --justfile

set unstable := true

this_file := source_file()
this := just_executable() + " -f " + quote(this_file)
version_major := "3"
version_minor := `date +%Y_%m_%d`
version := version_major + "." + version_minor

_:
    @{{ this }} --list --unsorted

[group('user')]
switch_to_latest:
    git checkout $(git describe --tags $(git rev-list --tags --max-count=1))

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
    inotifywait -m ./static/js/theme/ -e modify -q | while read; do pnpm run build:js; done

[group('dev')]
sync_i18n:
    node ./static/i18n/sync.js

[group('update_assets')]
update_pnpm:
    pnpm update

[extension('.mjs')]
[group('update_assets')]
sync_simple_icons:
    #!/usr/bin/env node
    import fs from "fs"
    const icons = ["bluesky", "codeberg", "git", "github", "mastodon", "matrix", "youtube"]
    for (const icon of icons) {
        fs.copyFileSync(`./node_modules/simple-icons/icons/${icon}.svg`, `./static/icons/${icon}.svg`)
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

[doc('git commit')]
[group('git')]
commit: commit_diff
    zola check --skip-external-links
    git commit

[doc('git push')]
[group('git')]
push:
    git push codeberg linkita:linkita
    git push github linkita:linkita
    git fetch

[doc('git tag')]
[group('git')]
release: && confirm (release_json version) (release_git version)
    @! git show-ref --tags 'v{{ version }}' --quiet
    @printf '%s\n' 'Releasing v{{ version }}'

[confirm]
[private]
confirm:

[group('git')]
[private]
release_git version:
    @if ! git diff --quiet -- package.json; then \
        git add package.json; fi;
    @if ! git diff --quiet -- CHANGELOG.md; then \
        git add CHANGELOG.md; fi;
    ! git diff --cached --quiet
    git commit -m 'Release v{{ version }}'
    git tag -s -a 'v{{ version }}' -m 'Release v{{ version }}'

[group('git')]
[private]
release_json version:
    #!/usr/bin/env node
    const fs = require("fs");
    const path = require("path");
    const jsonPath = path.join("package.json");
    const packageJson = JSON.parse(fs.readFileSync(jsonPath, "utf8"));
    packageJson.version = "{{ version }}";
    fs.writeFileSync(jsonPath, JSON.stringify(packageJson, null, 2) + "\n", "utf8");
