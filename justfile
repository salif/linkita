#!/usr/bin/env -S just -f

set unstable := true

mod? theme "themes/linkita/theme.just"

this := just_executable() + " -f " + quote(justfile())
screenshot_url := "http://127.0.0.1:1111"

_:
    @{{ this }} --list --list-heading 'Available recipes for demo:{{ "\n" }}'
    @{{ this }} _check_commands

[unix]
_check_commands:
    @COMMANDS=(git zola magick node pnpm); \
    for COMMAND in "${COMMANDS[@]}"; do \
        if ! command -v "$COMMAND" 2>&1 >/dev/null; then \
            printf "%sWarning: '%s' is not installed or not in PATH%s\n" \
                "{{ style("warning") }}" "${COMMAND}" "{{ NORMAL }}" >&2; \
        fi; \
    done;

[windows]
_check_commands:

[group('dev')]
[private]
serve_and args='':
    zola serve {{ args }} --interface 0.0.0.0 --base-url \
        "$(ip -o route get to 8.8.8.8 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')"

[doc('Serve the demo site')]
[group('dev')]
serve: serve_and

[group('dev')]
zola_check:
    zola check --skip-external-links

[doc('git commit')]
[group('git')]
commit: zola_check format
    ! git diff themes/linkita | grep -q -- -dirty
    git commit

[doc('git push')]
[group('git')]
push:
    git push codeberg-demo demo:demo
    git push github demo:demo

[doc('Format source code')]
[group('dev')]
format:
    {{ this }} --fmt --unstable

[group('dev')]
[linux]
set_screenshot_mode mode='light' schema='org.x.apps.portal':
    #!/usr/bin/env bash
    if [[ "{{ mode }}" == "light" ]]; then
        if [[ "$(gsettings get {{ schema }} color-scheme)" != "'prefer-light'" ]]; then
            gsettings set {{ schema }} color-scheme 'prefer-light'; fi
    elif [[ "{{ mode }}" == "dark" ]]; then
        if [[ "$(gsettings get {{ schema }} color-scheme)" != "'prefer-dark'" ]]; then
            gsettings set {{ schema }} color-scheme 'prefer-dark'; fi
    fi

[group('dev')]
update_screenshot screenshot_url=screenshot_url browser='chromium':
    command {{ browser }} --headless --disable-gpu --screenshot=static/images/screenshot.png \
        --window-size=1400,936 --hide-scrollbars --force-device-scale-factor=1.2 "{{ screenshot_url }}/en/"
    magick static/images/screenshot.png -gravity north -crop '1360x765+0+0' static/images/screenshot.png
    -mat2 --inplace static/images/screenshot.png
    cp static/images/screenshot.png ./themes/linkita/screenshot.png
