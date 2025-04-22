#!/usr/bin/env -S just -f

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
build_css:
    pnpm tailwindcss -i ./src/app.css -o ./static/main.min.css --minify
    pnpm tailwindcss -i ./src/app.css -o ./src/main.css

[group('dev')]
watch_css:
    pnpm tailwindcss -i ./src/app.css -o ./static/main.min.css --minify --watch

[group('dev')]
build_js:
    terser ./src/linkita.js -o ./static/js/linkita.min.js
    terser ./src/linkita-search.js -o ./static/js/linkita-search.min.js
    terser ./src/gc.js -o ./static/js/gc.min.js

[group('dev')]
build_js_file filename:
    terser "./src/{{ filename }}.js" -o "./static/js/{{ filename }}.min.js"

[extension('.mjs')]
[group('update_assets')]
update_simple_icons:
    #!/usr/bin/env node
    import fs from "fs"
    const icons = ["bluesky", "codeberg", "git", "github", "mastodon", "matrix", "youtube"]
    for (const icon of icons) {
        fs.copyFileSync(`./node_modules/simple-icons/icons/${icon}.svg`, `./static/icons/${icon}.svg`)
    }

[group('update_assets')]
[script]
update_instantpage:
    cd node_modules/instant.page/
    pnpm run minify
    cd -
    cp node_modules/instant.page/instantpage.min.js static/js/instantpage.min.js

[group('update_assets')]
[script]
update_katex:
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
        if ! git diff --quiet -- static/main.min.css; then
            git add static/main.min.css;
        fi
        if ! git diff --quiet -- src/main.css; then
            git add src/main.css;
        fi
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
