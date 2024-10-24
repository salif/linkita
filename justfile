#!/usr/bin/env -S just --justfile

just := just_executable() + " --justfile '" + justfile() + "'"
zola := "zola"
git := "git"
npm := "npm"
version_major := "0"
version_minor := `date +%Y_%m_%d`
version_patch := "0"
version := version_major + "." + version_minor + "." + version_patch

_:
    @{{ just }} --list --unsorted

[group('user')]
switch-to-latest:
    {{ git }} switch $({{ git }} describe --tags $({{ git }} \
        rev-list --tags --max-count=1))

[group('dev')]
push-linkita:
    {{ git }} push codeberg linkita
    {{ git }} push github linkita

[group('dev')]
release: (release-json version) && (release-git version)
    {{ npm }} run build
    @{{ git }} add ./static/main.css
    {{ zola }} check
    {{ git }} diff --cached --quiet
    @! {{ git }} show-ref --tags 'v{{ version }}' --quiet
    @printf '%s\n' 'Releasing v{{ version }}'

[confirm("Are you sure?")]
[group('dev')]
[private]
release-git version:
    {{ git }} tag -s -a 'v{{ version }}' -m 'Release v{{ version }}'
    {{ git }} push --follow-tags

[group('dev')]
[private]
release-json version:
    #!/usr/bin/env node
    const fs = require("fs");
    const path = require("path");
    const jsonPath = path.join("package.json");
    const packageJson = JSON.parse(fs.readFileSync(jsonPath, "utf8"));
    packageJson.version = "{{ version }}";
    fs.writeFileSync(jsonPath, JSON.stringify(packageJson, null, 2) + "\n", "utf8");

[group('dev')]
format:
    {{ just }} --fmt --unstable
