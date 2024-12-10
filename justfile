#!/usr/bin/env -S just --justfile

just := just_executable()
zola := "zola"
git := "git"
browser := "brave"
screenshot_url := "http://127.0.0.1:1111"

_:
    @command {{ just }} --list --list-heading 'Available recipes for demo:{{ "\n" }}'

[group('dev')]
[private]
serve-and args='':
    command {{ zola }} serve {{ args }} --interface 0.0.0.0 --base-url \
        "$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')"

[doc('Serve the demo site')]
[group('dev')]
serve: serve-and

[doc('git push')]
[group('dev')]
push-demo:
    command {{ git }} push codeberg-demo demo
    command {{ git }} push github demo

[doc('Format source code')]
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
update-screenshot screenshot_url=screenshot_url browser=browser:
    command {{ browser }} --headless --disable-gpu --screenshot=static/images/screenshot.png \
        --window-size=1400,936 --hide-scrollbars --force-device-scale-factor=1.2 "{{ screenshot_url }}/en/"
    magick static/images/screenshot.png -gravity north -crop '1360x765+0+0' static/images/screenshot.png
    -mat2 --inplace static/images/screenshot.png
    cp static/images/screenshot.png ./themes/linkita/screenshot.png
