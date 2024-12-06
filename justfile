#!/usr/bin/env -S just --justfile

just := just_executable() + " --justfile '" + justfile() + "'"
zola := "zola"
git := "git"
npm := "npm"
browser := "brave"
screenshot_url := "http://127.0.0.1:1111"
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
[private]
serve-and args='':
    command {{ zola }} serve {{ args }} --interface 0.0.0.0 --base-url \
        $(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')

[group('dev')]
serve: (serve-and)

[group('dev')]
push-linkita:
    command {{ git }} push codeberg linkita
    command {{ git }} push github linkita

[group('dev')]
release: (release-json version) && (release-git version)
    command {{ npm }} run build
    @command {{ git }} add ./static/main.css
    command {{ zola }} check
    command {{ git }} diff --cached --quiet
    @! command {{ git }} show-ref --tags 'v{{ version }}' --quiet
    @printf '%s\n' 'Releasing v{{ version }}'

[confirm("Are you sure?")]
[group('dev')]
[private]
release-git version:
    command {{ git }} tag -s -a 'v{{ version }}' -m 'Release v{{ version }}'
    command {{ git }} push --follow-tags

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
    command {{ just }} --fmt --unstable

[group('dev')]
set-screenshot-mode mode='light' schema='org.x.apps.portal':
    #!/usr/bin/env bash
    if [[ "{{ mode }}" == "light" ]]; then
        if [[ "$(gsettings get {{ schema }} color-scheme)" != "'prefer-light'" ]]; then
            gsettings set {{ schema }} color-scheme 'prefer-light'; fi
    elif [[ "{{ mode }}" == "dark" ]]; then
        if [[ "$(gsettings get {{ schema }} color-scheme)" != "'prefer-dark'" ]]; then
            gsettings set {{ schema }} color-scheme 'prefer-dark'; fi
    fi

[group('dev')]
add-screenshot screenshot_url=screenshot_url browser=browser:
    command {{ browser }} --headless --disable-gpu --screenshot=screenshot.png  --window-size=1400,936 \
        --hide-scrollbars --force-device-scale-factor=1.2 "{{ screenshot_url }}/en/"
    magick screenshot.png -gravity north -crop '1360x765+0+0' screenshot.png
    -mat2 --inplace screenshot.png
    cp screenshot.png static/images/
