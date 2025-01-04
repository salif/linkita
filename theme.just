#!/usr/bin/env -S just -f

set unstable := true

this_file := source_file()
this := just_executable() + " -f " + quote(this_file)
version_major := "0"
version_minor := `date +%Y_%m_%d`
version_patch := "0"
version := version_major + "." + version_minor + "." + version_patch

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
css_build:
    pnpm tailwindcss -i ./static/app.css -o ./static/main.min.css --minify
    pnpm tailwindcss -i ./static/app.css -o ./static/main.css

[group('dev')]
css_watch:
    pnpm tailwindcss -i ./static/app.css -o ./static/main.min.css --minify --watch

[extension('.mjs')]
update_social_icons:
    #!/usr/bin/env node
    import fs from "fs"
    import stream from "node:stream"
    const icons = ["bluesky", "codeberg", "git", "github"]
    for (const icon of icons) {
        const resp = await fetch(`https://cdn.jsdelivr.net/npm/simple-icons/icons/${icon}.svg`)
        if (resp.ok) {
            const iconFile = fs.createWriteStream(`static/icons/${icon}.svg`)
            stream.Readable.fromWeb(resp.body).pipe(iconFile)
            iconFile.on("finish", () => console.log(`Saved ${iconFile.path}`))
        }
    }

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
        {{ this }} css_build format;
        if ! git diff --quiet -- static/main.min.css; then
            git add static/main.min.css;
        fi
        if ! git diff --quiet -- static/main.css; then
            git add static/main.css;
        fi
        if ! git diff --quiet -- {{ quote(this_file) }}; then
            git add {{ quote(this_file) }};
        fi
    fi

[doc('git commit')]
[group('git')]
commit: commit_diff
    zola check
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
    git push --follow-tags

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
