#!/usr/bin/env -S just -f

just := "cd '" + invocation_directory() + "' && just -f '" + justfile() + "'"
zola := "zola"
git := "git"
npm := "npm"
version_major := "0"
version_minor := `date +%Y_%m_%d`
version_patch := "0"
version := version_major + "." + version_minor + "." + version_patch

_:
    @{{ just }} --list

release: && (release-do version)
    {{ npm }} run build
    @{{ git }} add ./static/main.css
    {{ zola }} check
    {{ git }} diff --cached --quiet
    @printf '%s\n' 'Releasing v{{ version }}'

[confirm("Are you sure?")]
[private]
release-do version:
    @! {{ git }} show-ref --tags 'v{{ version }}' --quiet
    {{ git }} tag -s -a 'v{{ version }}' -m 'Release v{{ version }}'
    {{ git }} push --follow-tags

format:
    {{ just }} --fmt --unstable
