+++
title = "Ŝanĝi al Zola 0.23.4"
description = "Kiel migri Linkita-retejon al Zola v0.23.4"
date = 2026-08-16
updated = 2026-08-16
[taxonomies]
authors = ["salif"]
[extra]
inline_code_fix = true
+++

Zola v0.23 anstataŭigis sian ŝablonilon, Tera, per nova ĉefa versio (Tera v2). La projekto Zola mem nomas ĝin
> verŝajne la plej rompa versio de Zola kiu iam okazos

kaj la ŝablonoj de Linkita devis esti rescritaj por sekvi ĝin. Ĉi tiu paĝo gvidas vin tra la translokiĝo de Linkita-retejo de Zola v0.22.1 al Zola v0.23.4.

## Deponeja translokiĝo

Linkita estis samtempe translokita de Codeberg al GitHub. Se vi ankoraŭ uzas la deponejon de Codeberg, vi unue devas ŝanĝi al la deponejo de GitHub. Por uzantoj de git-submoduloj, jen la instrukcioj:

```sh
git submodule init
git config -f .gitmodules submodule."themes/linkita".url https://github.com/salif/linkita.git
git config -f .gitmodules submodule."themes/linkita".branch tera1
git submodule sync
git submodule update
git add .gitmodules
```

## Kiu bezonas ĉi tiun gvidilon

Ĉi tiu gvidilo estas por vi se via retejo nuntempe uzas Linkita en la branĉo `tera1` (aŭ en `linkita` / `v4`) kun Zola v0.22.1 aŭ pli malnova.

Se vi ankoraŭ ne volas ĝisdatigi Zola, vi ne devas fari ion ajn – la branĉo `tera1` daŭre funkcios kun malnovaj versioj de Zola kaj ne foriros.

## Paŝo 1: Ĝisdatigi Zola al v0.23.4

Instalu Zola v0.23.4 aŭ pli novan. Kontrolu vian instalitan version per:

```sh
zola --version
```

Zola v0.23 estas granda salto. Trarigardu la [ŝanĝoprotokolon de Zola v0.23.0](https://github.com/getzola/zola/blob/master/CHANGELOG.md#0230-2026-08-05) se via retejo havas proprajn ŝablonojn preter tiuj de Linkita – la resto de ĉi tiu gvidilo nur kovras tion, kio ŝanĝiĝis ĉe Linkita.

## Paŝo 2: Ŝanĝi al la branĉo `main`

La branĉo `main` de Linkita nun celas Zola v0.23.0+. La branĉo `tera1` restas sur la malnova ŝablonilo por Zola v0.22.1 kaj pli malnovaj versioj.

Se vi instalis Linkita kiel git-submodulon:

```sh
git submodule set-branch --branch main themes/linkita
git submodule update --remote themes/linkita
```

## Paŝo 3: Ĝisdatigi vian `zola.toml` / `config.toml`

Trarigardu ĉiun el la sekvaj punktoj. Neniu el ĉi tiuj estas devigata de Zola – malnovaj postrestantaj ŝlosiloj ne rompos vian konstruon, sed ili silente ĉesos fari ion ajn, do indas purigi ilin.

### Menuaj kaj sociaj ligiloj: `$BASE_URL` → `@base`

`$BASE_URL` en `extra.menus`, profilaj `social` URL-oj, kaj `extra.footer.license_url` nun estas skribitaj kiel `@base`:

```toml ,name=zola.toml
# Antaŭe
[extra.menus]
menu_name = [
  { url = "$BASE_URL/blog/", name = "Arkivo" },
]

# Poste
[extra.menus]
menu_name = [
  { url = "@base/blog/", name = "Arkivo" },
]
```

La sama renomado validas por la eroj `social` de profilo kaj por `extra.footer.license_url`. Vi ankaŭ povas uzi [internajn ligilojn de Zola](https://www.getzola.org/documentation/content/linking/#internal-links) (`@/...`) anstataŭ `@base` se vi preferas.

Estas ankaŭ nova prefikso `@lang` por menuaj/sociaj URL-oj, kiu solvas vojon ene de specifa lingvo, se vi bezonas tion.

Rimarku, ke tio **ne** validas por `extra.footer.copyright` – tiu ĉeno ankoraŭ uzas `$BASE_URL`, `$YEAR`, kaj `$LICENSE_URL` kiel antaŭe:

```toml ,name=zola.toml
[extra.footer]
copyright = "&copy; $YEAR Via Nomo &vert; [CC BY-SA 4.0]($LICENSE_URL)"
```

### Profiloj: Agordoj de Open Graph simpligitaj

La subtabulo `[extra.profiles.<user>.open_graph]` foriĝis. `image` kaj `image_alt` moviĝis unu nivelon supren kaj estis renomitaj, `fediverse_creator` ankaŭ moviĝis unu nivelon supren, kaj la Facebook-specifaj kampoj (`first_name`, `last_name`, `username`, `gender`, `fb_app_id`, `fb_admins`) kune kun la laŭlingva Open Graph-traduksekcio estis tute forigitaj:

```toml ,name=zola.toml
# Antaŭe
[extra.profiles.your_username.open_graph]
image = "cover.png"
image_alt = "Priskribo"
fediverse_creator = { handle = "me", domain = "mastodon.social" }

# Poste
[extra.profiles.your_username]
# ...avatar_url, name, bio, social, ktp. kiel antaŭe, plus:
og_image = "cover.png"
og_image_alt = "Priskribo"
fediverse_creator = { handle = "me", domain = "mastodon.social" }
```

Se vi fidis je `first_name` / `last_name` / `gender` / `fb_app_id` / `fb_admins`, aŭ je laŭlingva `open_graph.languages.<lang>.image_alt` anstataŭigo, ne ekzistas rekta anstataŭaĵo – tiuj Open Graph-kampoj ne plu estas eligitaj de la temo.

### Lingvaj opcioj: `locale` forigita, data formatado ŝanĝita

La filtrilo `date` de Zola ne plu akceptas argumenton `locale`, do la variablo `extra.languages.<lang>.locale` (ekz. `locale = "fr_FR"`) estis forigita. Data formatado moviĝis de la biblioteko `chrono` al `jiff`, do ĉenoj de `date_format` nun estas interpretataj laŭ la [referenco de strftime ĉe jiff](https://docs.rs/jiff/latest/jiff/fmt/strtime/index.html#conversion-specifications) anstataŭ tiu de chrono.

```toml ,name=zola.toml
# Antaŭe
[extra.languages.fr]
locale = "fr_FR"
date_format = "%x"

# Poste
[extra.languages.fr]
date_format = "%F"
num_format = "fr"
```

La praktika efiko: se vi fidis je `locale` por montri tradukitajn nomojn de monatoj/tagoj (per signoj kiel `%B` aŭ `%A`), tio ne plu okazas aŭtomate. Kontrolu viajn signojn de `date_format` laŭ la dokumentaro de jiff – vi eble volas ŝanĝi al nur-nombra formato, aŭ akcepti ke monataj/tagaj nomoj estos montrataj kiel jiff defaŭlte eligas por tiu signo. `num_format` (por nombra formatado, ne rilata al datoj) restas senŝanĝa kaj daŭre estas laŭlingva.

### `disable_javascript` forigita

La agorda variablo `extra.disable_javascript`, kiu ebligis subpremi la JS-on de la temo kaj reimplementi ĝin mem per injektoj, estis forigita.

### Dokumentaraj ligiloj

Se vi ligas al la dokumentaro de Linkita ie ajn, rimarku ke la prezento de mallongigoj (shortcodes) moviĝis de `/shortcodes/` al `/components/` (ekz. la projekta funkcio nun estas dokumentita ĉe `https://salif.github.io/linkita/components/#projects`).

La dokumentaro pri la kovrilbildo estis klarigita por noti ke `extra.cover.image` akceptas aŭ dosiernomon de paĝa elemento aŭ `get_url`-kongruan vojon – tio jam funkciis antaŭe, nur ne estis eksplicite menciita.

## Paŝo 4: Ĝisdatigi vian enhavon – mallongigoj nun estas komponantoj

Ĉi tiu estas la ŝanĝo plej verŝajna influi viajn ekzistantajn afiŝojn.

Zola v0.23 tute forigis mallongigojn (shortcodes). Ne plu ekzistas dosierujo `templates/shortcodes/`, kaj la malnova funkcio-stila alvoko de mallongigo en Markdown-enhavo (kun aŭ sen korpo) foriĝis – ambaŭ formoj nun malsukcesas la konstruon kun eraro "unknown function" / "unknown tag". Anstataŭe viaj `.md`-dosieroj estas rekte ŝablonigitaj per Tera, same kiel `.html`-ŝablonoj, kaj vi vokas la enkonstruitajn **komponantojn** de Linkita per la nova alvoksintakso de Tera v2.

Komponanto kun korpo estas vokata jene – rimarku ke la elcento-kaj-krampo ĉirkaŭas la angulkrampojn, ne duoblajn kurbajn krampojn:

```markdown
{% <component_name arg="value"> %}
korpa enhavo
{% </component_name> %}
```

Komponanto sen korpo (memferma) uzas duoblajn kurbajn krampojn anstataŭe:

```markdown
{{<component_name arg="value" />}}
```

### Avertoj (Admonition)

```markdown
# Antaŭe
{% admonition(type="note", title="Noto") %}
Ĉi tio estas **nota** korpo.
{% end %}

# Poste
{% <admonition type="note" title="Noto"> %}
Ĉi tio estas **nota** korpo.
{% </admonition> %}
```

### Galerio (Gallery)

Galerio nun bezonas `page` kaj `config` eksplicite pasigitaj (Tera v2-komponantoj ne ricevas implican aliron al la paĝo/agordo kiel malnovaj mallongigoj – vi pasigas ilin laŭnome, kaj ĉar la variablonomoj jam kongruas kun la parametronomoj, vi povas simple skribi `page config`):

```markdown
# Antaŭe
{{ gallery() }}

# Poste
{{<gallery page config alt="" />}}
```

### Mermaid

````markdown
# Antaŭe
{% mermaid() %}
```mermaid
graph TD;
A-->B;
```
{% end %}

# Poste
{% <mermaid> -%}
```mermaid
graph TD;
A-->B;
```
{%- </mermaid> %}
````

Uzu la spacoforigajn streketojn montritajn supre (tuj post la malferma elcent-krampo kaj tuj antaŭ la ferma) – sen ili, la komenca malplena linio antaŭ la kodbloko ne estas forigata kaj la diagramo bildiĝas kun la ` ```mermaid ` markiloj ankoraŭ videblaj anstataŭ esti purigitaj de la komponanto.

### Projektoj (Projects)

Projektoj ankaŭ nun bezonas `page` kaj `config` eksplicite pasigitaj:

```markdown
# Antaŭe
{{ projects(path="data.toml", format="toml") }}

# Poste
{{<projects path="data.toml" format="toml" page config />}}
```

### Se vi skribas pri Tera-sintakso en viaj propraj afiŝoj

Ĉar `.md`-dosieroj nun estas ŝablonigitaj de Tera antaŭ ol Markdown estas analizita, laŭvortaj Tera-etikedoj ene de kodbloko – kiel la supraj ekzemploj – efektive estos plenumitaj anstataŭ montritaj, eĉ ene de trioblaj malantaŭaj krampoj. Envolvu ajnan tian ekzemplon en `raw`-bloko por montri ĝin laŭvorte.

```markdown
{% raw %}
...
{% endraw %}
```

## Paŝo 5: Propraj lingvaj dosieroj

Se vi aldonis propran dosieron `static/i18n/<lang>.json`, sinkronigu viajn ŝanĝojn kun la defaŭlta lingva dosiero de la temo.

## Paŝo 6 (progresinta): Propraj ŝablonaj anstataŭigoj aŭ injektoj

Preterpasu ĉi tiun sekcion krom se vi anstataŭigis unu el la propraj ŝablonoj de Linkita, aŭ vi vokas ĝiajn internajn makroojn rekte el viaj propraj ŝablonoj aŭ injektoj.

Tera v1-makrooj foriĝis en Tera v2, anstataŭigitaj per **komponantoj**, kiuj estas vokataj tutmonde laŭnome – ne plu `{% import %}` aŭ `self::`-nomspaco.

Aliaj sintaksaj ŝanĝoj de Tera v2 videblaj tra la ŝablonoj, se viaj propraj anstataŭigoj uzas ilin:

- `trim_start_matches(pat=...)` / `trim_end_matches(pat=...)` nun estas `trim_start(pat=...)` / `trim_end(pat=...)`.
- `linebreaksbr` nun estas `newlines_to_br`.
- `default(value=x)` bezonas `boolean=true` aldonitan (`default(value=x, boolean=true)`) por trakti malplenajn ĉenojn/`false` kiel "uzi la defaŭlton" – sen ĝi, nur vere nedifinita/nula valoro ekigas la defaŭlton.
- Opcionala ĉenado (`?.` / `?[...]`) estas disponebla kaj uzata ĉie por sekure legi agordajn valorojn, kiuj eble ne estas difinitaj.
- Tutmonda kunteksto (`page`, `config`, `lang`, ktp.) ne plu estas implicite disponebla ene de komponanto kiel ĝi estis ene de makroo – komponantoj deklaras kaj ricevas ĝin eksplicite, tial vi vidos parametrojn `page: map`, `config: map` tra la novaj ŝablonoj.
- La propraj ŝablonoj `templates/sitemap.xml` kaj `templates/split_sitemap_index.xml` estis forigitaj de la temo. Se vi mem anstataŭigis iun el ĉi tiuj, kontrolu ĉu vi ankoraŭ bezonas tion.

Por la plena bildo de tio, kio ŝanĝiĝis en Tera mem, vidu la [gvidilon pri migrado de Tera v1 al v2](https://github.com/Keats/tera/blob/master/MIGRATION.md).

## Paŝo 7: Rekonstrui kaj kontroli

```sh
zola build
```

Poste reviziu, precipe:

- Menueroj kaj sociaj ikonoj solvantaj al la ĝustaj URL-oj (la ŝanĝo `@base`).
- La Open Graph-bildo/priskribo de via profilo kaj la kontrola ligilo de Fediverse troviĝas en la paĝa `<head>`.
- Ne-anglalingva data formatado ankoraŭ aspektas ĝusta – ĉi tiu estas la plej verŝajna silente ŝanĝiĝinta (ne plu laŭlocale tradukitaj monataj/tagaj nomoj).
- Ĉiuj avertoj, galerioj, Mermaid-diagramoj, aŭ projekta paĝo bildiĝas ĝuste.

## Ricevi helpon

Se io ne kongruas kun tio, kio estas priskribita ĉi tie, kontrolu la [README](https://github.com/salif/linkita/blob/main/README.md) kaj [CHANGELOG](https://github.com/salif/linkita/blob/main/CHANGELOG.md) en la branĉo `main`, aŭ [komencu diskuton](https://github.com/salif/linkita/discussions).
