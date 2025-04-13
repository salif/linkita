# Demo for the Linkita theme

## Links

- [Demo site](https://salif.github.io/linkita/en/), [source](https://codeberg.org/salif/linkita-demo), [source mirror](https://github.com/salif/linkita/tree/demo)
- [Theme source](https://codeberg.org/salif/linkita), [Theme source mirror](https://github.com/salif/linkita)
- [Matrix chat room](https://matrix.to/#/#linkita:mozilla.org)
- [Zola Themes Collection](https://salif.github.io/zola-themes-collection/), [Kita theme](https://github.com/st1020/kita), [Hugo-Paper theme](https://github.com/nanxiaobei/hugo-paper)

## Set up for contributing

Fork this demo repository and/or the theme repository.

Replace `YOUR-USERNAME`:

```sh
# Step 1:
# If you forked the demo repository:
git clone --recurse-submodules https://codeberg.org/YOUR-USERNAME/linkita-demo.git
# Otherwise:
git clone --recurse-submodules https://codeberg.org/salif/linkita-demo.git

# Step 2: Only if you forked the theme repository:
cd linkita-demo/themes/linkita
git remote add downstream https://codeberg.org/YOUR-USERNAME/linkita.git

# If you do changes in the theme repository:
git checkout -b feature
git commit
git push downstream feature
```
