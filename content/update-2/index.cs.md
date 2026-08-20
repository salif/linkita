+++
title = "Přechod na Zola 0.23.3"
description = "Jak migrovat web Linkita na Zola v0.23.3"
date = 2026-08-16
updated = 2026-08-16
[taxonomies]
authors = ["salif"]
[extra]
inline_code_fix = true
+++

Zola v0.23 nahradila svůj šablonovací engine Tera novou hlavní verzí (Tera v2). Samotný projekt Zola ji označuje jako
> pravděpodobně nejvíce nekompatibilní verzi Zoly, jaká kdy nastane

a šablony Linkita musely být přepsány, aby jí odpovídaly. Tato stránka vás provede přechodem webu Linkita ze Zola v0.22.1 na Zola v0.23.3.

## Přesun repozitáře

Linkita byla zároveň přesunuta z Codebergu na GitHub. Pokud stále používáte repozitář na Codebergu, musíte nejprve přejít na repozitář na GitHubu. Pro uživatele git submodulů jsou zde instrukce:

```sh
git submodule init
git config -f .gitmodules submodule."themes/linkita".url https://github.com/salif/linkita.git
git config -f .gitmodules submodule."themes/linkita".branch tera1
git submodule sync
git submodule update
git add .gitmodules
```

## Pro koho je tento průvodce určen

Tento průvodce je určen pro vás, pokud váš web aktuálně používá Linkitu ve větvi `tera1` (nebo `linkita` / `v4`) se Zolou v0.22.1 nebo starší.

Pokud zatím nechcete Zolu upgradovat, nemusíte dělat nic – větev `tera1` bude se starými verzemi Zoly nadále fungovat a nikam nemizí.

## Krok 1: Upgrade Zoly na v0.23.3

Nainstalujte Zolu v0.23.3 nebo novější. Nainstalovanou verzi zkontrolujete pomocí:

```sh
zola --version
```

Zola v0.23 představuje velký skok. Projděte si [seznam změn Zola v0.23.0](https://github.com/getzola/zola/blob/master/CHANGELOG.md#0230-2026-08-05), pokud má váš web vlastní šablony nad rámec Linkity – zbytek tohoto průvodce pokrývá pouze změny na straně Linkity.

## Krok 2: Přepnutí na větev `main`

Větev `main` tématu Linkita nyní cílí na Zolu v0.23.3+. Větev `tera1` zůstává na starém šablonovacím enginu pro Zolu v0.22.1 a starší.

Pokud jste nainstalovali Linkitu jako git submodul:

```sh
git submodule set-branch --branch main themes/linkita
git submodule update --remote themes/linkita
```

## Krok 3: Aktualizace `zola.toml` / `config.toml`

Projděte si následující body. Žádný z nich není Zolou striktně vynucován – staré zbylé klíče sice nerozbijí sestavení, ale tiše přestanou fungovat, takže se vyplatí je vyčistit.

### Odkazy v menu a sociální sítě: `$BASE_URL` → `@base`

`$BASE_URL` v `extra.menus`, URL adresy profilu `social` a `extra.footer.license_url` se nyní zapisují jako `@base`:

```toml ,name=zola.toml
# Předtím
[extra.menus]
menu_name = [
  { url = "$BASE_URL/blog/", name = "Archiv" },
]

# Potom
[extra.menus]
menu_name = [
  { url = "@base/blog/", name = "Archiv" },
]
```

Stejné přejmenování platí pro položky `social` profilu a `extra.footer.license_url`. Místo `@base` můžete také použít [interní odkazy Zoly](https://www.getzola.org/documentation/content/linking/#internal-links) (`@/...`), pokud tomu dáváte přednost.

K dispozici je také nová předpona `@lang` pro URL adresy v menu/sociálních sítích, která vyřeší cestu v rámci konkrétního jazyka.

Všimněte si, že to **neplatí** pro `extra.footer.copyright` – tento řetězec stále používá `$BASE_URL`, `$YEAR` a `$LICENSE_URL` jako dříve:

```toml ,name=zola.toml
[extra.footer]
copyright = "&copy; $YEAR Vaše Jméno &vert; [CC BY-SA 4.0]($LICENSE_URL)"
```

### Profily: Zjednodušení nastavení Open Graph

Podtabulka `[extra.profiles.<user>.open_graph]` byla odstraněna. `image` a `image_alt` se posunuly o úroveň výše a byly přejmenovány, `fediverse_creator` se posunul také o úroveň výše a pole specifická pro Facebook (`first_name`, `last_name`, `username`, `gender`, `fb_app_id`, `fb_admins`) a sekce překladu Open Graph pro jednotlivé jazyky byly zcela odstraněny:

```toml ,name=zola.toml
# Předtím
[extra.profiles.your_username.open_graph]
image = "cover.png"
image_alt = "Popis"
fediverse_creator = { handle = "me", domain = "mastodon.social" }

# Potom
[extra.profiles.your_username]
# ...avatar_url, name, bio, social atd. jako dříve, plus:
og_image = "cover.png"
og_image_alt = "Popis"
fediverse_creator = { handle = "me", domain = "mastodon.social" }
```

Pokud jste spoléhali na `first_name` / `last_name` / `gender` / `fb_app_id` / `fb_admins` nebo na přepsání `open_graph.languages.<lang>.image_alt` pro konkrétní jazyk, přímá náhrada neexistuje – tato pole Open Graph již téma negeneruje.

### Jazykové možnosti: `locale` odstraněno, změna formátování data

Filtr `date` v Zole již nepřijímá argument `locale`, takže proměnná `extra.languages.<lang>.locale` (např. `locale = "fr_FR"`) byla odstraněna. Formátování data přešlo z balíčku `chrono` na `jiff`, takže řetězce `date_format` jsou nyní interpretovány podle [dokumentace strftime knihovny jiff](https://docs.rs/jiff/latest/jiff/fmt/strtime/index.html#conversion-specifications) místo chrono.

```toml ,name=zola.toml
# Předtím
[extra.languages.fr]
locale = "fr_FR"
date_format = "%x"

# Potom
[extra.languages.fr]
date_format = "%F"
num_format = "fr"
```

Praktický dopad: pokud jste spoléhali na `locale` při tisku přeložených názvů měsíců/dnů v týdnu (pomocí tokenů jako `%B` nebo `%A`), již k tomu automaticky nedochází. Zkontrolujte své tokeny `date_format` podle dokumentace jiff – možná budete chtít přejít na čistě číselný formát nebo akceptovat, že názvy měsíců/dnů budou vykresleny tak, jak je jiff standardně vygeneruje. `num_format` (pro formátování čísel, nesouvisí s daty) se nemění a zůstává pro každý jazyk zvlášť.

### `disable_javascript` odstraněno

Konfigurační proměnná `extra.disable_javascript`, která umožňovala potlačit JS tématu a znovu jej implementovat pomocí vkládání (injects), byla odstraněna.

### Odkazy na dokumentaci

Pokud kdekoli odkazujete na dokumentaci Linkity, všimněte si, že ukázka shortcodes byla přesunuta z `/shortcodes/` do `/components/` (např. funkce projektů je nyní zdokumentována na `https://salif.github.io/linkita/components/#projects`).

Byla upřesněna dokumentace k obrázku na obálce, aby bylo jasné, že `extra.cover.image` přijímá buď název souboru z prostředků stránky, nebo cestu kompatibilní s `get_url` – to fungovalo i dříve, jen to nebylo výslovně uvedeno.

## Krok 4: Aktualizace obsahu – shortcodes jsou nyní komponenty

Toto je změna, která s největší pravděpodobností ovlivní vaše stávající příspěvky.

Zola v0.23 zcela odstranila shortcodes. Již neexistuje adresář `templates/shortcodes/` a starý způsob volání shortcode v Markdownu (s tělem nebo bez něj) je pryč – obě formy nyní selžou při sestavení s chybou "unknown function" / "unknown tag". Místo toho jsou vaše soubory `.md` zpracovávány přímo enginem Tera stejně jako šablony `.html` a vestavěné **komponenty** Linkity voláte pomocí nové syntaxe volání v Tera v2.

Komponenta s tělem se volá takto – všimněte si, že procento a složená závorka obalují špičaté závorky, nikoli dvojité složené závorky:

```markdown
{% <component_name arg="value"> %}
obsah těla
{% </component_name> %}
```

Komponenta bez těla (samouzavírací) používá dvojité složené závorky:

```markdown
{{<component_name arg="value" />}}
```

### Upozornění (Admonition)

```markdown
# Předtím
{% admonition(type="note", title="Poznámka") %}
Toto je tělo **poznámky**.
{% end %}

# Potom
{% <admonition type="note" title="Poznámka"> %}
Toto je tělo **poznámky**.
{% </admonition> %}
```

### Galerie (Gallery)

Galerie nyní potřebuje explicitně předat `page` a `config` (komponenty Tera v2 nemají implicitní přístup k page/config jako staré shortcodes – předáváte je jménem, a protože se názvy proměnných již shodují s názvy parametrů, stačí napsat `page config`):

```markdown
# Předtím
{{ gallery() }}

# Potom
{{<gallery page config alt="" />}}
```

### Mermaid

````markdown
# Předtím
{% mermaid() %}
```mermaid
graph TD;
A-->B;
```
{% end %}

# Potom
{% <mermaid> -%}
```mermaid
graph TD;
A-->B;
```
{%- </mermaid> %}
````

Použijte pomlčky pro oříznutí mezer zobrazené výše (hned za otevírací závorkou s procentem a těsně před uzavírací) – bez nich se neodstraní úvodní prázdný řádek před blokem kódu a diagram se vykreslí s viditelnými značkami ` ```mermaid `, místo aby byly komponentou vyčištěny.

### Projekty (Projects)

Projekty nyní také vyžadují explicitní předání `page` a `config`:

```markdown
# Předtím
{{ projects(path="data.toml", format="toml") }}

# Potom
{{<projects path="data.toml" format="toml" page config />}}
```

### Pokud ve svých příspěvcích píšete o syntaxi Tera

Vzhledem k tomu, že soubory `.md` jsou nyní zpracovávány Terou před samotným parsováním Markdownu, doslovné tagy Tery uvnitř bloku kódu – jako ve výše uvedených příkladech – se skutečně spustí, místo aby se zobrazily jako text, a to i uvnitř trojitých zpětných apostrofů. Zabalte jakýkoli takový příklad do bloku `raw`, aby se zobrazil doslovně.

```markdown
{% raw %}
...
{% endraw %}
```

## Krok 5: Vlastní jazykové soubory

Pokud jste přidali vlastní soubor `static/i18n/<lang>.json`, synchronizujte své změny s výchozím jazykovým souborem tématu.

## Krok 6 (pokročilé): Vlastní přepsání šablon nebo injektáže

Tuto sekci přeskočte, pokud jste nepřepsali žádnou z vlastních šablon Linkity nebo nevoláte její interní makra přímo z vlastních šablon či injektáží.

Makra z Tera v1 jsou v Tera v2 nahrazena **komponentami**, které se volají globálně podle názvu – již žádné `{% import %}` ani jmenný prostor `self::`.

Další změny syntaxe Tera v2 viditelné napříč šablonami, pokud je vaše přepsání používají:

- `trim_start_matches(pat=...)` / `trim_end_matches(pat=...)` jsou nyní `trim_start(pat=...)` / `trim_end(pat=...)`.
- `linebreaksbr` je nyní `newlines_to_br`.
- `default(value=x)` potřebuje přidat `boolean=true` (`default(value=x, boolean=true)`), aby prázdné řetězce/`false` bral jako „použít výchozí hodnotu“ – bez toho pouze skutečně nedefinovaná/null hodnota spustí výchozí nastavení.
- Volitelné řetězení (`?.` / `?[...]`) je k dispozici a používá se pro bezpečné čtení konfiguračních hodnot, které nemusí být nastaveny.
- Globální kontext (`page`, `config`, `lang` atd.) již není uvnitř komponenty implicitně dostupný tak, jak tomu bylo uvnitř maker – komponenty jej deklarují a přijímají explicitně, a proto v nových šablonách uvidíte parametry `page: map`, `config: map`.
- Vlastní šablony `templates/sitemap.xml` a `templates/split_sitemap_index.xml` byly z tématu odstraněny. Pokud jste si některou z nich sami přepsali, zkontrolujte, zda ji ještě potřebujete.

Úplný přehled o tom, co se změnilo v samotné Teře, naleznete v [průvodci migrací z Tera v1 na v2](https://github.com/Keats/tera/blob/master/MIGRATION.md).

## Krok 7: Znovusestavení a kontrola

```sh
zola build
```

Poté zkontrolujte zejména:

- Zda položky menu a ikony sociálních sítí odkazují na správné URL adresy (změna `@base`).
- Zda jsou obrázek/popis Open Graph vašeho profilu a ověřovací odkaz na Fediverse přítomny v hlavičce `<head>` stránky.
- Zda formátování neanglických dat stále vypadá správně – toto je změna, která se s největší pravděpodobností projevila tiše (žádné překlady názvů měsíců/dnů podle locale).
- Zda se všechna upozornění, galerie, diagramy Mermaid nebo stránka projektů vykreslují správně.

## Získání pomoci

Pokud něco neodpovídá zde popsanému stavu, nahlédněte do souborů [README](https://github.com/salif/linkita/blob/main/README.md) a [CHANGELOG](https://github.com/salif/linkita/blob/main/CHANGELOG.md) ve větvi `main`, nebo [zahajte diskusi](https://github.com/salif/linkita/discussions).
