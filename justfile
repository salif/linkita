#!/usr/bin/env -S just --justfile

mod? theme "themes/linkita/theme.just"

this := just_executable() + " -f " + quote(source_file())
screenshot_url := "http://127.0.0.1:1111"
browser := "brave-origin"
zola := if `git branch --show-current` == "demo" { "zola-v0.22.1" } else { "zola" }

_:
    @{{ this }} --list --list-heading 'Available recipes for demo:{{ "\n" }}'

[group('dev')]
[private]
serve_and args='':
    {{ zola }} serve {{ args }} --interface 0.0.0.0 --base-url \
        "$(ip route get 1 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')"

[group('dev')]
serve: serve_and

[group('dev')]
zola_check:
    {{ zola }} check --skip-external-links

[group('git')]
[private]
branch_is branch:
    @[ "$(git branch --show-current)" == "{{ branch }}" ]

[group('git')]
[private]
commit_on_demo: zola_check
    ! git diff themes/linkita | grep -q -- -dirty
    git commit

[group('git')]
commit_demo: (branch_is "demo") && commit_on_demo

[group('git')]
commit_demo2: (branch_is "demo2") && commit_on_demo

[group('git')]
push_demo remote='origin':
    git push {{ remote }} demo:demo

[group('git')]
push_demo2 remote='origin':
    git push {{ remote }} demo2:demo2

[linux]
[private]
screenshot_do_all: (screenshot_set_mode 'light') screenshot_do_light (screenshot_set_mode 'dark') screenshot_do_dark screenshot_update

[group('dev')]
[linux]
[script("bash")]
screenshot_set_mode mode schema='org.x.apps.portal':
    if [[ "{{ mode }}" == "light" ]]; then
        if [[ "$(gsettings get {{ schema }} color-scheme)" != "'prefer-light'" ]]; then
            gsettings set {{ schema }} color-scheme 'prefer-light'; fi
    elif [[ "{{ mode }}" == "dark" ]]; then
        if [[ "$(gsettings get {{ schema }} color-scheme)" != "'prefer-dark'" ]]; then
            gsettings set {{ schema }} color-scheme 'prefer-dark'; fi
    fi
    sleep 2

[private]
screenshot_do mode screenshot_url=screenshot_url browser=browser:
    command {{ browser }} --headless --disable-gpu \
        --system-font-family="Lato" --screenshot=/tmp/screenshot-{{ mode }}.png \
        --window-size=1400,936 --hide-scrollbars --force-device-scale-factor=1.25 "{{ screenshot_url }}/"
    magick /tmp/screenshot-{{ mode }}.png -gravity north -crop '1360x765+0+0' /tmp/screenshot-{{ mode }}.png

[group('dev')]
screenshot_do_light: (screenshot_do 'light')

[group('dev')]
screenshot_do_dark: (screenshot_do 'dark')

[group('dev')]
screenshot_update:
    magick -size 1360x765 xc:black -fill white -draw "polygon 0,0 1360,0 0,765" /tmp/linkita-mask.png
    magick /tmp/screenshot-dark.png /tmp/screenshot-light.png /tmp/linkita-mask.png -composite static/images/screenshot.png
    -mat2 --inplace static/images/screenshot.png
    cp static/images/screenshot.png themes/linkita/screenshot.png
    rm -f /tmp/screenshot-dark.png /tmp/screenshot-light.png /tmp/linkita-mask.png
