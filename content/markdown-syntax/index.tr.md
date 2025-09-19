+++
title = "Markdown Sözdizimi Kılavuzu"
description = "HTML öğeleri için temel Markdown sözdizimini ve biçimlendirmeyi gösteren örnek makale."
date = 2022-10-20
updated = 2025-01-23
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["kita", "salif"]
[extra]
[extra.cover]
image = "images/markdown-syntax.png"
alt = "Bir Markdown logosu"
width = 1600
height = 800
+++

Bu makale, Zola içerik dosyalarında kullanılabilecek temel Markdown sözdiziminin bir örneğini sunar ve ayrıca temel HTML öğelerinin bir Linkita temasında CSS ile dekore edilip edilmediğini gösterir.

<!--more-->

## Başlıklar

Aşağıdaki HTML `<h1>`—`<h6>` öğeleri, altı bölüm başlığı düzeyini temsil eder. `<h1>` en yüksek bölüm düzeyi iken `<h6>` en düşük düzeydir.

# H1

## H2

### H3

#### H4

##### H5

###### H6

## Paragraf

Xerum, quo qui aut unt expliquam qui dolut labo. Aque venitatiusda cum, voluptionse latur sitiae dolessi aut parist aut dollo enim qui voluptate ma dolestendit peritin re plis aut quas inctum laceat est volestemque commosa as cus endigna tectur, offic to cor sequas etum rerum idem sintibus eiur? Quianimin porecus evelectur, cum que nis nust voloribus ratem aut omnimi, sitatur? Quiatem. Nam, omnis sum am facea corem alique molestrunt et eos evelece arcillit ut aut eos eos nus, sin conecerem erum fuga. Ri oditatquam, ad quibus unda veliamenimin cusam et facea ipsamus es exerum sitate dolores editium rerore eost, temped molorro ratiae volorro te reribus dolorer sperchicium faceata tiustia prat.

Itatur? Quiatae cullecum rem ent aut odis in re eossequodi nonsequ idebis ne sapicia is sinveli squiatum, core et que aut hariosam ex eat.

## Alıntılar

Blok alıntı öğesi, isteğe bağlı olarak bir `footer` veya `cite` öğesi içinde olması gereken bir atıf ve isteğe bağlı olarak ek açıklamalar ve kısaltmalar gibi satır içi değişikliklerle başka bir kaynaktan alıntılanan içeriği temsil eder.

#### Atıfsız blok alıntı

> Tiam, ad mint andaepu dandae nostion secatur sequo quae.
> **Unutmayın** ki bir blok alıntı içinde _Markdown sözdizimini_ kullanabilirsiniz.

#### Atıflı blok alıntı

> Belleği paylaşarak iletişim kurmayın, iletişim kurarak belleği paylaşın.<br>
> — <cite>Rob Pike[^1]</cite>

[^1]: Yukarıdaki alıntı, Rob Pike'ın 18 Kasım 2015'teki Gopherfest sırasında yaptığı [konuşmasından](https://www.youtube.com/watch?v=PAAkCSZUG1c) alınmıştır.

## Bağlantılar

Bir bağlantı oluşturmak için, bağlantı metnini köşeli parantezler içine alın ve ardından hemen URL'yi parantez içinde takip edin.

[GitHub](https://github.com)

Bir URL veya e-posta adresini hızlıca bağlantıya dönüştürmek için açılı parantezler içine alın.

<https://github.com>

## Resimler

![Markdown Kılavuzu](../../images/markdown-syntax.png)

## Tablolar

Tablolar, temel Markdown spesifikasyonunun bir parçası değildir, ancak Zola bunları kutudan çıkar çıkmaz destekler.

| Ad    | Yaş |
| ----- | --- |
| Bob   | 27  |
| Alice | 23  |

#### Tablolar içinde satır içi Markdown

| İtalik    | Kalın     | Kod    |
| --------- | -------- | ------ |
| _italik_  | **kalın** | `kod`  |

## Kod Blokları

#### Ters tırnak işaretli kod bloğu

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Örnek HTML5 Belgesi</title>
  </head>
  <body>
    <p>Test</p>
  </body>
</html>
```

#### Dört boşlukla girintili kod bloğu

    <!doctype html>
    <html lang="en">
    <head>
      <meta charset="utf-8">
      <title>Örnek HTML5 Belgesi</title>
    </head>
    <body>
      <p>Test</p>
    </body>
    </html>

## Liste Türleri

#### Sıralı Liste

1. İlk öğe
2. İkinci öğe
3. Üçüncü öğe

#### Sırasız Liste

- Liste öğesi
- Başka bir öğe
- Ve başka bir öğe

#### İç İçe Liste

- Meyve
  - Elma
  - Portakal
  - Muz
- Süt Ürünleri
  - Süt
  - Peynir

## Diğer Öğeler — abbr, sub, sup, kbd, mark

<abbr title="Graphics Interchange Format">GIF</abbr> bir bitmap resim formatıdır.

H<sub>2</sub>O

X<sup>n</sup> + Y<sup>n</sup> = Z<sup>n</sup>

Oturumu sonlandırmak için <kbd><kbd>CTRL</kbd>+<kbd>ALT</kbd>+<kbd>Delete</kbd></kbd> tuşlarına basın.

Çoğu <mark>semender</mark> gececil hayvanlardır ve böcekler, solucanlar ve diğer küçük yaratıklar için avlanırlar.
