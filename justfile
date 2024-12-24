#!/usr/bin/env -S just --justfile

mod? demo "../../justfile"

just := just_executable() + " --justfile '" + justfile() + "'"
zola := "zola"
git := "git"
npm := "npm"
version_major := "0"
version_minor := `date +%Y_%m_%d`
version_patch := "0"
version := version_major + "." + version_minor + "." + version_patch

_:
    @command {{ just }} --list --unsorted

[group('user')]
switch-to-latest:
    command {{ git }} checkout $(command {{ git }} describe --tags $(command {{ git }} \
        rev-list --tags --max-count=1))

[group('dev')]
format:
    command {{ just }} --fmt --unstable

[extension('.mjs')]
update-social-icons:
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
add-git-remotes:
    command {{ git }} remote add codeberg 'git@codeberg.org:salif/linkita.git'
    command {{ git }} remote add github 'git@github.com:salif/linkita.git'
    command {{ git }} remote add kita 'https://github.com/st1020/kita.git'

[doc('git commit')]
[group('git')]
commit-theme:
    command {{ just }} demo::zola-check format
    command {{ git }} commit

[doc('git push')]
[group('git')]
push-theme:
    command {{ git }} push codeberg linkita:linkita
    command {{ git }} push github linkita:linkita

[group('git')]
release: (release-json version) && (release-git version)
    command {{ npm }} run build
    @command {{ git }} add ./static/main.css
    command {{ zola }} check
    command {{ git }} diff --cached --quiet
    @! command {{ git }} show-ref --tags 'v{{ version }}' --quiet
    @printf '%s\n' 'Releasing v{{ version }}'

[confirm("Are you sure?")]
[group('git')]
[private]
release-git version:
    command {{ git }} tag -s -a 'v{{ version }}' -m 'Release v{{ version }}'
    command {{ git }} push --follow-tags

[group('git')]
[private]
release-json version:
    #!/usr/bin/env node
    const fs = require("fs");
    const path = require("path");
    const jsonPath = path.join("package.json");
    const packageJson = JSON.parse(fs.readFileSync(jsonPath, "utf8"));
    packageJson.version = "{{ version }}";
    fs.writeFileSync(jsonPath, JSON.stringify(packageJson, null, 2) + "\n", "utf8");
