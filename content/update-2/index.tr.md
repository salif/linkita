+++
title = "Zola 0.23.4'e Geçiş"
description = "Bir Linkita sitesini Zola v0.23.4'e taşıma rehberi"
date = 2026-08-16
updated = 2026-08-16
[taxonomies]
authors = ["salif"]
[extra]
inline_code_fix = true
+++

Zola v0.23, şablon motoru Tera'yı yeni bir ana sürümle (Tera v2) değiştirdi. Zola projesinin kendisi bunu
> muhtemelen Zola'nın yaşayacağı en çok uyumluluk bozan sürüm

olarak nitelendiriyor ve Linkita'nın şablonlarının buna uyum sağlamak için yeniden yazılması gerekti. Bu sayfa, bir Linkita sitesini Zola v0.22.1'den Zola v0.23.4'e taşımanızda size rehberlik eder.

## Depo taşıma

Linkita aynı zamanda Codeberg'den GitHub'a taşındı. Hâlâ Codeberg deposunu kullanıyorsanız, öncelikle GitHub deposuna geçmeniz gerekir. Git alt modülü (submodule) kullananlar için talimatlar şunlardır:

```sh
git submodule init
git config -f .gitmodules submodule."themes/linkita".url https://github.com/salif/linkita.git
git config -f .gitmodules submodule."themes/linkita".branch tera1
git submodule sync
git submodule update
git add .gitmodules
```

## Bu rehbere kimlerin ihtiyacı var

Siteniz şu anda Zola v0.22.1 veya daha eski bir sürümle `tera1` dalında (veya `linkita` / `v4` dalında) Linkita kullanıyorsa bu rehber sizin içindir.

Zola'yı henüz yükseltmek istemiyorsanız hiçbir şey yapmanıza gerek yoktur; `tera1` dalı eski Zola sürümleriyle çalışmaya devam edecek ve kaldırılmayacaktır.

## 1. Adım: Zola'yı v0.23.4 sürümüne yükseltin

Zola v0.23.4 veya daha yenisini yükleyin. Yüklü sürümünüzü şu komutla kontrol edin:

```sh
zola --version
```

Zola v0.23 büyük bir adımdır. Sitenizde Linkita'nın kendi şablonlarının ötesinde özel şablonlar varsa [Zola v0.23.0 değişiklik günlüğünü](https://github.com/getzola/zola/blob/master/CHANGELOG.md#0230-2026-08-05) inceleyin; bu rehberin geri kalanı yalnızca Linkita tarafında nelerin değiştiğini kapsar.

## 2. Adım: `main` dalına geçin

Linkita'nın `main` dalı artık Zola v0.23.0+ sürümünü hedefler. `tera1` dalı, Zola v0.22.1 ve öncesi için eski şablon motorunda kalmaya devam eder.

Linkita'yı bir git alt modülü olarak yüklediyseniz:

```sh
git submodule set-branch --branch main themes/linkita
git submodule update --remote themes/linkita
```

## 3. Adım: `zola.toml` / `config.toml` dosyanızı güncelleyin

Aşağıdakilerin her birini gözden geçirin. Bunların hiçbiri Zola tarafından zorunlu kılınmaz; kalan eski anahtarlar derlemenizi bozmaz, ancak sessizce çalışmayı durdururlar, bu nedenle temizlemeye değer.

### Menü ve sosyal bağlantılar: `$BASE_URL` → `@base`

`extra.menus` içindeki `$BASE_URL`, profil `social` URL'leri ve `extra.footer.license_url` artık `@base` olarak yazılmaktadır:

```toml ,name=zola.toml
# Önce
[extra.menus]
menu_name = [
  { url = "$BASE_URL/blog/", name = "Arşiv" },
]

# Sonra
[extra.menus]
menu_name = [
  { url = "@base/blog/", name = "Arşiv" },
]
```

Aynı yeniden adlandırma bir profilin `social` girişleri ve `extra.footer.license_url` için de geçerlidir. Dilerseniz `@base` yerine [Zola'nın dahili bağlantılarını](https://www.getzola.org/documentation/content/linking/#internal-links) (`@/...`) da kullanabilirsiniz.

Gerekirse belirli bir dildeki yolu çözen menü/sosyal URL'leri için yeni bir `@lang` öneki de mevcuttur.

Bunun `extra.footer.copyright` için geçerli **olmadığını** unutmayın; bu dize daha önce olduğu gibi hâlâ `$BASE_URL`, `$YEAR` ve `$LICENSE_URL` kullanır:

```toml ,name=zola.toml
[extra.footer]
copyright = "&copy; $YEAR Adınız &vert; [CC BY-SA 4.0]($LICENSE_URL)"
```

### Profiller: Open Graph ayarları basitleştirildi

`[extra.profiles.<user>.open_graph]` alt tablosu kaldırıldı. `image` ve `image_alt` bir seviye yukarı taşındı ve yeniden adlandırıldı, `fediverse_creator` da bir seviye yukarı taşındı ve Facebook'a özel alanlar (`first_name`, `last_name`, `username`, `gender`, `fb_app_id`, `fb_admins`) ile dile özel Open Graph çeviri bölümü tamamen kaldırıldı:

```toml ,name=zola.toml
# Önce
[extra.profiles.your_username.open_graph]
image = "cover.png"
image_alt = "Bir açıklama"
fediverse_creator = { handle = "me", domain = "mastodon.social" }

# Sonra
[extra.profiles.your_username]
# ...avatar_url, name, bio, social vb. eskisi gibi, artı:
og_image = "cover.png"
og_image_alt = "Bir açıklama"
fediverse_creator = { handle = "me", domain = "mastodon.social" }
```

`first_name` / `last_name` / `gender` / `fb_app_id` / `fb_admins` veya dile özel bir `open_graph.languages.<lang>.image_alt` geçersiz kılma özelliğine güveniyorsanız, doğrudan bir karşılığı yoktur; bu Open Graph alanları artık tema tarafından üretilmemektedir.

### Dil seçenekleri: `locale` kaldırıldı, tarih biçimlendirmesi değişti

Zola'nın `date` filtresi artık bir `locale` bağımsız değişkeni almamaktadır, bu nedenle `extra.languages.<lang>.locale` değişkeni (örneğin `locale = "fr_FR"`) kaldırılmıştır. Tarih biçimlendirmesi `chrono` paketinden `jiff` paketine taşındı, böylece `date_format` dizeleri artık chrono yerine [jiff'in strftime referansı](https://docs.rs/jiff/latest/jiff/fmt/strtime/index.html#conversion-specifications) kullanılarak yorumlanır.

```toml ,name=zola.toml
# Önce
[extra.languages.fr]
locale = "fr_FR"
date_format = "%x"

# Sonra
[extra.languages.fr]
date_format = "%F"
num_format = "fr"
```

Pratik etki: Çevrilmiş ay/gün adlarını yazdırmak için `locale`e güveniyorsanız (`%B` veya `%A` gibi belirteçler aracılığıyla), bu artık otomatik olarak gerçekleşmez. `date_format` belirteçlerinizi jiff belgelerine göre kontrol edin; yalnızca sayısal bir biçime geçmek isteyebilir veya ay/gün adlarının jiff'in o belirteç için varsayılan olarak ürettiği şekilde oluşturulmasını kabul edebilirsiniz. `num_format` (tarihlerle ilgisi olmayan sayı biçimlendirmesi için) değişmemiştir ve hâlâ dil başınadır.

### `disable_javascript` kaldırıldı

Temanın JS'sini devre dışı bırakıp injects aracılığıyla kendinizin yeniden uygulamasına olanak tanıyan `extra.disable_javascript` yapılandırma değişkeni kaldırılmıştır.

### Belge bağlantıları

Linkita'nın kendi belgelerine bağlantı veriyorsanız, shortcode demosunun `/shortcodes/` yerine `/components/` altına taşındığını unutmayın (örneğin projeler özelliği artık `https://salif.github.io/linkita/components/#projects` adresinde belgelenmiştir).

Kapak resmi belgeleri, `extra.cover.image` alanının sayfa varlığı dosya adını veya `get_url` uyumlu bir yolu kabul ettiğini belirtmek üzere netleştirildi; bu daha önce de çalışıyordu ancak açıkça belirtilmemişti.

## 4. Adım: İçeriğinizi güncelleyin – shortcode'lar artık bileşendir

Bu, mevcut gönderilerinizi etkileme olasılığı en yüksek olan değişikliktir.

Zola v0.23 shortcode'ları tamamen kaldırdı. Artık `templates/shortcodes/` dizini yoktur ve Markdown içeriğinde bir shortcode'u işlev çağrısı biçiminde (gövdeli veya gövdesiz) çağırma yöntemi kalktı; her iki biçim de artık derlemede "unknown function" / "unknown tag" hatası verir. Bunun yerine `.md` dosyalarınız `.html` şablonlarında olduğu gibi doğrudan Tera ile şablonlanır ve Linkita'nın yerleşik **bileşenlerini** Tera v2'nin yeni çağrı sözdizimini kullanarak çağırırsınız.

Gövdesi olan bir bileşen şu şekilde çağrılır (yüzde-küme parantezlerinin çift küme parantezleri yerine açılı ayraç etiketlerini sardığına dikkat edin):

```markdown
{% <component_name arg="value"> %}
gövde içeriği
{% </component_name> %}
```

Gövdesi olmayan (kendi kendini kapatan) bir bileşen bunun yerine çift küme parantezi kullanır:

```markdown
{{<component_name arg="value" />}}
```

### Uyarı kutuları (Admonition)

```markdown
# Önce
{% admonition(type="note", title="Bir not") %}
Bu bir **not** gövdesidir.
{% end %}

# Sonra
{% <admonition type="note" title="Bir not"> %}
Bu bir **not** gövdesidir.
{% </admonition> %}
```

### Galeri (Gallery)

Galeriye artık `page` ve `config` açıkça aktarılmalıdır (Tera v2 bileşenleri, eski shortcode'lar gibi sayfa/yapılandırmaya örtük erişim sağlamaz; bunları adıyla aktarırsınız ve değişken adları parametre adlarıyla zaten eşleştiğinden yalnızca `page config` yazabilirsiniz):

```markdown
# Önce
{{ gallery() }}

# Sonra
{{<gallery page config alt="" />}}
```

### Mermaid

````markdown
# Önce
{% mermaid() %}
```mermaid
graph TD;
A-->B;
```
{% end %}

# Sonra
{% <mermaid> -%}
```mermaid
graph TD;
A-->B;
```
{%- </mermaid> %}
````

Yukarıda gösterilen boşluk kırpma tirelerini kullanın (açılış yüzde parantezinden hemen sonra ve kapanıştan hemen önce); bunlar olmadan kod bloğundan önceki baştaki boş satır temizlenmez ve diyagram bileşen tarafından temizlenmek yerine ` ```mermaid ` işaretleri görünür şekilde işlenir.

### Projeler (Projects)

Projeler için de artık `page` ve `config` açıkça aktarılmalıdır:

```markdown
# Önce
{{ projects(path="data.toml", format="toml") }}

# Sonra
{{<projects path="data.toml" format="toml" page config />}}
```

### Gönderilerinizde Tera sözdizimi hakkında yazıyorsanız

`.md` dosyaları artık Markdown ayrıştırılmadan önce Tera tarafından şablonlandığından, kod bloğunun içindeki gerçek Tera etiketleri (yukarıdaki örnekler gibi), üçlü ters tırnakların içinde bile metin olarak görüntülenmek yerine gerçekten yürütülür. Bu tür örnekleri kelimesi kelimesine göstermek için bir `raw` bloğuna sarın.

```markdown
{% raw %}
...
{% endraw %}
```

## 5. Adım: Özel dil dosyaları

Özel bir `static/i18n/<lang>.json` dosyası eklediyseniz, değişikliklerinizi temanın varsayılan dil dosyasıyla senkronize edin.

## 6. Adım (ileri düzey): Özel şablon geçersiz kılmaları veya eklemeler (injects)

Linkita'nın kendi şablonlarından birini geçersiz kılmadığınız veya dahili makrolarını doğrudan kendi şablonlarınızdan veya eklemelerinizden çağırmadığınız sürece bu bölümü atlayın.

Tera v1 makroları Tera v2'de kaldırıldı ve yerini ada göre genel olarak çağrılan **bileşenler** aldı; artık `{% import %}` veya `self::` ad alanı yok.

Kendi geçersiz kılmalarınızın kullanması durumunda şablonlarda görülen diğer Tera v2 sözdizimi değişiklikleri:

- `trim_start_matches(pat=...)` / `trim_end_matches(pat=...)` artık `trim_start(pat=...)` / `trim_end(pat=...)` oldu.
- `linebreaksbr` artık `newlines_to_br` oldu.
- Boş dizeleri/`false` değerlerini "varsayılanı kullan" olarak ele almak için `default(value=x)` içine `boolean=true` eklenmelidir (`default(value=x, boolean=true)`); bu olmadan yalnızca gerçekten tanımsız/null bir değer varsayılanı tetikler.
- İsteğe bağlı zincirleme (`?.` / `?[...]`) mevcuttur ve ayarlanmamış olabilecek yapılandırma değerlerini güvenli bir şekilde okumak için her yerde kullanılır.
- Global bağlam (`page`, `config`, `lang` vb.) artık bir makro içinde olduğu gibi bir bileşen içinde örtük olarak kullanılamaz; bileşenler bunu açıkça bildirir ve alır, bu nedenle yeni şablonlarda `page: map`, `config: map` parametrelerini görürsünüz.
- Özel `templates/sitemap.xml` ve `templates/split_sitemap_index.xml` şablonları temadan kaldırıldı. Bunlardan birini kendiniz geçersiz kıldıysanız, hâlâ ihtiyacınız olup olmadığını kontrol edin.

Tera'da nelerin değiştiğinin tam tablosu için [Tera v1 → v2 geçiş kılavuzuna](https://github.com/Keats/tera/blob/master/MIGRATION.md) bakın.

## 7. Adım: Yeniden derleyin ve kontrol edin

```sh
zola build
```

Ardından özellikle şunları gözden geçirin:

- Menü öğeleri ve sosyal simgeler doğru URL'lere yönleniyor mu (`@base` değişikliği).
- Profilinizin Open Graph resmi/açıklaması ve Fediverse doğrulama bağlantı etiketi sayfanın `<head>` kısmında mevcut mu.
- İngilizce dışındaki tarih biçimlendirmesi hâlâ doğru görünüyor mu (yerel ayarlarla çevrilen ay/gün adlarının kaldırılmasıyla sessizce değişmesi en muhtemel olan durum budur).
- Tüm uyarı kutuları, galeriler, Mermaid diyagramları veya projeler sayfası doğru şekilde işleniyor mu.

## Yardım alma

Bir şeyler burada açıklananlarla eşleşmiyorsa `main` dalındaki [README](https://github.com/salif/linkita/blob/main/README.md) ve [CHANGELOG](https://github.com/salif/linkita/blob/main/CHANGELOG.md) dosyalarını kontrol edin veya [bir tartışma başlatın](https://github.com/salif/linkita/discussions).
