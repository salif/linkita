#!/usr/bin/env -S just --justfile

mod? theme "themes/linkita/theme.just"

this := just_executable() + " -f " + quote(source_file())
screenshot_url := "http://127.0.0.1:1111"
zola := if `git branch --show-current` == "demo" { "zola-v0.22.1" } else { "zola" }

_:
    @{{ this }} --list --unsorted --list-heading 'Available recipes for demo:{{ "\n" }}'

[group('dev')]
[private]
serve_and args='':
    {{ zola }} serve {{ args }} --interface 0.0.0.0 --base-url \
        "$(ip route get 1 | sed -n 's/.*src \([0-9.]\+\).*/\1/p')"

[group('dev')]
serve: serve_and

[group('dev')]
check:
    {{ zola }} check

[group('git')]
[private]
branch_is branch:
    @[ "$(git branch --show-current)" == "{{ branch }}" ]

[group('git')]
[private]
commit_on_demo:
    {{ zola }} check --skip-external-links
    ! git diff themes/linkita | grep -q -- -dirty
    git commit

[group('git')]
commit_demo: (branch_is "demo") && commit_on_demo

[group('git')]
commit_demo1: (branch_is "demo1") && commit_on_demo

[group('git')]
push_demo remote='origin':
    git push {{ remote }} demo:demo

[group('git')]
push_demo1 remote='origin':
    git push {{ remote }} demo1:demo1

[group('dev')]
screenshot_update screenshot_url=screenshot_url: (screenshot_do screenshot_url)
    magick /tmp/screenshot-light.png -gravity north -crop '1360x765+0+0' /tmp/screenshot-light.png
    magick /tmp/screenshot-dark.png -gravity north -crop '1360x765+0+0' /tmp/screenshot-dark.png
    magick -size 1360x765 xc:black -fill white -draw "polygon 0,0 1360,0 0,765" /tmp/linkita-mask.png
    magick /tmp/screenshot-dark.png /tmp/screenshot-light.png /tmp/linkita-mask.png -composite static/images/screenshot.png
    -mat2 --inplace static/images/screenshot.png
    cp static/images/screenshot.png themes/linkita/screenshot.png
    rm -f /tmp/screenshot-dark.png /tmp/screenshot-light.png /tmp/linkita-mask.png

[env("NODE_PATH", "themes/linkita/node_modules")]
[group('dev')]
[private]
screenshot_do screenshot_url=screenshot_url:
    #!/usr/bin/env node
    const puppeteer = require('puppeteer');
    (async () => {
      const browser = await puppeteer.launch({
        headless: true, args: ['--hide-scrollbars'] });
      const page = await browser.newPage();
      const cdp = await page.target().createCDPSession();
      await cdp.send('Page.setFontFamilies', { fontFamilies: {
          standard: 'Lato', serif: 'Alegreya',
          sansSerif: 'Lato', fixed: 'Monaspace Neon' }});
      await page.setViewport({
        width: 1400, height: 936, deviceScaleFactor: 1.25 });
      await page.emulateMediaFeatures([{
        name: 'prefers-color-scheme', value: 'light' }]);
      await page.goto('{{ screenshot_url }}/', { waitUntil: 'load' });
      await page.screenshot({ path: '/tmp/screenshot-light.png' });
      await page.emulateMediaFeatures([{
        name: 'prefers-color-scheme', value: 'dark' }]);
      await new Promise((resolve) => setTimeout(resolve, 300));
      await page.screenshot({ path: '/tmp/screenshot-dark.png' });
      await browser.close();
    })();
