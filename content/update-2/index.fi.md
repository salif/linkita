+++
title = "Siirtyminen Zola 0.23.3:een"
description = "Kuinka Linkita-sivusto siirretään Zola v0.23.3 -versioon"
date = 2026-08-16
updated = 2026-08-16
[taxonomies]
authors = ["salif"]
[extra]
inline_code_fix = true
+++

Zola v0.23 korvasi mallipohjamoottorinsa Teran uudella pääversiolla (Tera v2). Zola-projekti itse kuvailee sitä näin:
> luultavasti eniten yhteensopivuutta rikkova versio Zolasta koskaan

ja Linkitan mallipohjat oli kirjoitettava uudelleen sen mukaisiksi. Tämä sivu opastaa Linkita-sivuston päivittämisessä Zola v0.22.1:stä Zola v0.23.3:een.

## Lähdekoodivaraston siirto

Linkita siirrettiin samalla Codebergistä GitHubiin. Jos käytät edelleen Codeberg-repositoriota, sinun on ensin vaihdettava GitHub-repositorioon. Git-alimodulien (submodule) käyttäjille ohjeet ovat seuraavat:

```sh
git submodule init
git config -f .gitmodules submodule."themes/linkita".url https://github.com/salif/linkita.git
git config -f .gitmodules submodule."themes/linkita".branch tera1
git submodule sync
git submodule update
git add .gitmodules
```

## Kenelle tämä opas on tarkoitettu

Tämä opas on sinulle, jos sivustosi käyttää tällä hetkellä Linkitaa `tera1`-haarasta (tai `linkita` / `v4`-haarasta) Zolan version v0.22.1 tai vanhemman kanssa.

Jos et vielä halua päivittää Zolaa, sinun ei tarvitse tehdä mitään – `tera1`-haara toimii edelleen vanhojen Zola-versioiden kanssa eikä se ole poistumassa.

## Vaihe 1: Päivitä Zola versioon v0.23.3

Asenna Zola v0.23.3 tai uudempi. Tarkista asennettu versio komennolla:

```sh
zola --version
```

Zola v0.23 on suuri hyppäys. Silmäile [Zola v0.23.0 -muutoslokia](https://github.com/getzola/zola/blob/master/CHANGELOG.md#0230-2026-08-05), jos sivustollasi on omia mukautettuja mallipohjia Linkitan omien lisäksi – tämän oppaan loppuosa käsittelee vain Linkitan puolella tapahtuneita muutoksia.

## Vaihe 2: Vaihda `main`-haaraan

Linkitan `main`-haara tukee nyt Zola v0.23.3+:aa. Haara `tera1` pysyy vanhassa mallipohjamoottorissa Zola v0.22.1:lle ja vanhemmille.

Jos asensit Linkitan git-alimodulina:

```sh
git submodule set-branch --branch main themes/linkita
git submodule update --remote themes/linkita
```

## Vaihe 3: Päivitä `zola.toml` / `config.toml`

Käy läpi seuraavat kohdat. Zola ei pakota mitään näistä – vanhat avaimet eivät riko sivuston rakennusta, mutta ne lakkaavat hiljaisesti toimimasta, joten ne kannattaa siivota pois.

### Valikko- ja sosiaalisen median linkit: `$BASE_URL` → `@base`

`$BASE_URL` kohdassa `extra.menus`, profiilin `social`-URL-osoitteissa sekä `extra.footer.license_url` kirjoitetaan nyt muodossa `@base`:

```toml ,name=zola.toml
# Ennen
[extra.menus]
menu_name = [
  { url = "$BASE_URL/blog/", name = "Arkisto" },
]

# Jälkeen
[extra.menus]
menu_name = [
  { url = "@base/blog/", name = "Arkisto" },
]
```

Sama uudelleennimeäminen koskee profiilin `social`-merkintöjä ja `extra.footer.license_url`-kohtaa. Voit halutessasi käyttää myös [Zolan sisäisiä linkkejä](https://www.getzola.org/documentation/content/linking/#internal-links) (`@/...`) `@base`:n sijasta.

Valikkojen ja sosiaalisen median URL-osoitteille on myös uusi `@lang`-etuliite, joka hakee polun tietyn kielen sisällä.

Huomaa, että tämä **ei** koske kohtaa `extra.footer.copyright` – kyseinen merkkijono käyttää edelleen muuttujia `$BASE_URL`, `$YEAR` ja `$LICENSE_URL` kuten ennenkin:

```toml ,name=zola.toml
[extra.footer]
copyright = "&copy; $YEAR Nimesi &vert; [CC BY-SA 4.0]($LICENSE_URL)"
```

### Profiilit: Yksinkertaistetut Open Graph -asetukset

Alitaulukko `[extra.profiles.<user>.open_graph]` on poistettu. `image` ja `image_alt` siirrettiin ylemmälle tasolle ja nimettiin uudelleen, `fediverse_creator` siirrettiin myös ylemmälle tasolle, ja Facebook-kohtaiset kentät (`first_name`, `last_name`, `username`, `gender`, `fb_app_id`, `fb_admins`) sekä kielikohtainen Open Graph -käännösosio poistettiin kokonaan:

```toml ,name=zola.toml
# Ennen
[extra.profiles.your_username.open_graph]
image = "cover.png"
image_alt = "Kuvaus"
fediverse_creator = { handle = "me", domain = "mastodon.social" }

# Jälkeen
[extra.profiles.your_username]
# ...avatar_url, name, bio, social jne. kuten ennen, sekä:
og_image = "cover.png"
og_image_alt = "Kuvaus"
fediverse_creator = { handle = "me", domain = "mastodon.social" }
```

Jos luotit kenttiin `first_name` / `last_name` / `gender` / `fb_app_id` / `fb_admins` tai kielikohtaiseen ylikirjoitukseen `open_graph.languages.<lang>.image_alt`, niille ei ole suoraa korvaajaa – teema ei enää tuota näitä Open Graph -kenttiä.

### Kielivalinnat: `locale` poistettu, päivämäärien muotoilu muuttunut

Zolan `date`-suodatin ei enää ota `locale`-argumenttia, joten muuttuja `extra.languages.<lang>.locale` (esim. `locale = "fr_FR"`) on poistettu. Päivämäärien muotoilu siirtyi `chrono`-kirjastosta `jiff`-kirjastoon, joten `date_format`-merkkijonot tulkitaan nyt [jiffin strftime-viitteen](https://docs.rs/jiff/latest/jiff/fmt/strtime/index.html#conversion-specifications) mukaisesti chronon sijaan.

```toml ,name=zola.toml
# Ennen
[extra.languages.fr]
locale = "fr_FR"
date_format = "%x"

# Jälkeen
[extra.languages.fr]
date_format = "%F"
num_format = "fr"
```

Käytännön vaikutus: jos luotit `locale`-asetukseen käännettyjen kuukausien/viikonpäivien nimien tulostamisessa (tunnisteilla kuten `%B` tai `%A`), tämä ei enää tapahdu automaattisesti. Tarkista `date_format`-tunnisteesi jiffin dokumentaatiosta – saatat haluta siirtyä pelkästään numeeriseen muotoon tai hyväksyä sen, että kuukausien/päivien nimet tulostuvat jiffin kyseiselle tunnisteelle oletuksena tuottamassa muodossa. `num_format` (numeroiden muotoiluun, ei liity päivämääriin) pysyy muuttumattomana ja on edelleen kielikohtainen.

### `disable_javascript` poistettu

Asetusmuuttuja `extra.disable_javascript`, jolla pystyi poistamaan teeman JS:n käytöstä ja toteuttamaan sen itse lisäysten (injects) kautta, on poistettu.

### Dokumentaatiolinkit

Jos linkität Linkitan omaan dokumentaatioon, huomaa, että lyhytkoodien (shortcodes) esittely siirtyi polusta `/shortcodes/` polkuun `/components/` (esim. projektitoiminto on nyt dokumentoitu osoitteessa `https://salif.github.io/linkita/components/#projects`).

Kansikuvan dokumentaatiota tarkennettiin ilmoittamaan, että `extra.cover.image` hyväksyy joko sivuresurssin tiedostonimen tai `get_url`-yhteensopivan polun – tämä toimi jo aiemminkin, mutta sitä ei oltu mainittu selkeästi.

## Vaihe 4: Päivitä sisältösi – lyhytkoodit ovat nyt komponentteja

Tämä muutos vaikuttaa todennäköisimmin olemassa oleviin julkaisuihisi.

Zola v0.23 poisti lyhytkoodit (shortcodes) kokonaan. Hakemistoa `templates/shortcodes/` ei enää ole, ja vanha funktiokutsutyylinen tapa kutsua lyhytkoodia Markdown-sisällössä (rungolla tai ilman) on poistunut – molemmat muodot epäonnistuvat nyt rakennuksessa virheellä "unknown function" / "unknown tag". Sen sijaan `.md`-tiedostot käsitellään Teralla suoraan samalla tavalla kuin `.html`-mallipohjat, ja kutsut Linkitan sisäänrakennettuja **komponentteja** Tera v2:n uuden kutsusyntaksin avulla.

Komponenttia, jolla on runko, kutsutaan näin – huomaa, että prosenttimerkki ja aaltosulje ympäröivät kulmasulkeet, eivät kaksoisaaltosulkeet:

```markdown
{% <component_name arg="value"> %}
rungon sisältö
{% </component_name> %}
```

Komponentti ilman runkoa (itsesulkeutuva) käyttää sen sijaan kaksoisaaltosulkeita:

```markdown
{{<component_name arg="value" />}}
```

### Huomautuslaatikot (Admonition)

```markdown
# Ennen
{% admonition(type="note", title="Muistiinpano") %}
Tämä on **muistiinpanon** runko.
{% end %}

# Jälkeen
{% <admonition type="note" title="Muistiinpano"> %}
Tämä on **muistiinpanon** runko.
{% </admonition> %}
```

### Galleria (Gallery)

Gallerian on nyt saatava `page` ja `config` eksplisiittisesti (Tera v2 -komponenteilla ei ole implisiittistä pääsyä sivuun/asetuksiin kuten vanhoilla lyhytkoodeilla – välität ne nimeltä, ja koska muuttujien nimet vastaavat jo parametrien nimiä, voit vain kirjoittaa `page config`):

```markdown
# Ennen
{{ gallery() }}

# Jälkeen
{{<gallery page config alt="" />}}
```

### Mermaid

````markdown
# Ennen
{% mermaid() %}
```mermaid
graph TD;
A-->B;
```
{% end %}

# Jälkeen
{% <mermaid> -%}
```mermaid
graph TD;
A-->B;
```
{%- </mermaid> %}
````

Käytä yllä näkyviä tyhjän tilan poistoviivoja (heti avaavan prosenttisulkeen jälkeen ja juuri ennen sulkevaa) – ilman niitä koodilohkoa edeltävää tyhjää riviä ei poisteta ja kaavio renderöityy niin, että ` ```mermaid ` -merkinnät jäävät näkyviin sen sijaan, että komponentti puhdistaisi ne.

### Projektit (Projects)

Myös projektikomponentille on nyt välitettävä `page` ja `config` eksplisiittisesti:

```markdown
# Ennen
{{ projects(path="data.toml", format="toml") }}

# Jälkeen
{{<projects path="data.toml" format="toml" page config />}}
```

### Jos kirjoitat Tera-syntaksista omissa julkaisuissasi

Koska Tera käsittelee `.md`-tiedostot ennen Markdownin jäsentämistä, koodilohkon sisällä olevat kirjaimelliset Tera-tunnisteet – kuten yllä olevat esimerkit – suoritetaan sen sijaan, että ne vain näytettäisiin, jopa kolmoishippujen sisällä. Kääri tällaiset esimerkit `raw`-lohkoon näyttääksesi ne sellaisenaan.

```markdown
{% raw %}
...
{% endraw %}
```

## Vaihe 5: Mukautetut kielitiedostot

Jos lisäsit mukautetun `static/i18n/<lang>.json` -tiedoston, synkronoi muutoksesi teeman oletuskielitiedoston kanssa.

## Vaihe 6 (edistynyt): Mukautetut mallipohjien ylikirjoitukset tai injektiot

Ohita tämä osio, ellet ole ylikirjoittanut jotakin Linkitan omista mallipohjista tai kutsu sen sisäisiä makroja suoraan omista mallipohjistasi tai lisäyksistäsi.

Tera v1 -makrot on poistettu Tera v2:ssa ja korvattu **komponenteilla**, joita kutsutaan globaalisti nimellä – ei enää `{% import %}` -kutsuja tai `self::`-nimiavaruutta.

Muita Tera v2 -syntaksimuutoksia, jotka näkyvät mallipohjissa, mikäli omat ylikirjoituksesi käyttävät niitä:

- `trim_start_matches(pat=...)` / `trim_end_matches(pat=...)` ovat nyt `trim_start(pat=...)` / `trim_end(pat=...)`.
- `linebreaksbr` on nyt `newlines_to_br`.
- `default(value=x)` tarvitsee lisäyksen `boolean=true` (`default(value=x, boolean=true)`), jotta tyhjät merkkijonot/`false` tulkitaan oletusarvon käyttämiseksi – ilman sitä vain todella määrittämätön/null-arvo laukaisee oletuksen.
- Valinnainen ketjutus (`?.` / `?[...]`) on käytettävissä ja käytössä kaikkialla sellaisten konfiguraatioarvojen turvalliseen lukemiseen, joita ei välttämättä ole asetettu.
- Globaali konteksti (`page`, `config`, `lang` jne.) ei ole enää implisiittisesti saatavilla komponentin sisällä kuten makrossa – komponentit ilmoittavat ja vastaanottavat sen eksplisiittisesti, minkä vuoksi näet parametrit `page: map`, `config: map` uusissa mallipohjissa.
- Mukautetut mallipohjat `templates/sitemap.xml` ja `templates/split_sitemap_index.xml` poistettiin teemasta. Jos olit ylikirjoittanut jommankumman itse, tarkista tarvitsetko sitä vielä.

Tarkemman kuvan siitä, mikä Terassa itsessään muuttui, löydät [Tera v1 → v2 -migraatio-oppaasta](https://github.com/Keats/tera/blob/master/MIGRATION.md).

## Vaihe 7: Rakenna uudelleen ja tarkista

```sh
zola build
```

Tarkista sitten erityisesti:

- Valikkokohteet ja sosiaalisen median kuvakkeet ohjaavat oikeisiin URL-osoitteisiin (`@base`-muutos).
- Profiilisi Open Graph -kuva/kuvaus ja Fediverse-vahvistuslinkkitagi ovat läsnä sivun `<head>`-osiossa.
- Muun kuin englanninkielisen päivämäärän muotoilu näyttää edelleen oikealta – tämä on todennäköisimmin hiljaisesti muuttunut asia (ei enää locale-käännettyjä kuukausien/päivien nimiä).
- Kaikki huomautuslaatikot, galleriat, Mermaid-kaaviot tai projektisivu renderöityvät oikein.

## Avun saaminen

Jos jokin ei vastaa tässä kuvattua, tarkista `main`-haaran [README](https://github.com/salif/linkita/blob/main/README.md) ja [CHANGELOG](https://github.com/salif/linkita/blob/main/CHANGELOG.md), tai [aloita keskustelu](https://github.com/salif/linkita/discussions).
