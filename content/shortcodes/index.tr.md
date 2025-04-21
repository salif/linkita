+++
title = "Kısa Kodlar"
description = "Linkita temasının kısa kodları."
date = 2022-10-20
updated = 2025-04-20
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["kita", "salif"]
[extra]
mermaid = true
+++

Linkita teması çeşitli kısa kodlar sunar.

Kısa kodları hiç duymadınız mı? Daha fazla bilgi için [Zola dokümantasyonuna](https://www.getzola.org/documentation/content/shortcodes/) bakın.

## Mermaid {#mermaid-header}

Sayfanızda Mermaid kullanmak için, sayfanın ön yüzünde `extra.mermaid = true` olarak ayarlamanız gerekir.

```toml
+++
title = "Sayfa başlığınız"

[extra]
mermaid = true
+++
```

Ardından `mermaid()` kısa kodlarını şu şekilde kullanabilirsiniz:

```markdown
{%/* mermaid() */%}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{%/* end */%}
```

Bu şu şekilde görüntülenecektir:

{% mermaid() %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% end %}

Ek olarak, `mermaid()` kısa kodlarının içinde kod bloğu kullanabilirsiniz ve kod bloğu göz ardı edilecektir.

Kod bloğu, biçimlendiricinin mermaid'in biçimlendirmesini bozmasını engeller.

````markdown
{%/* mermaid() */%}

```mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Merhaba John, nasılsın?
    loop Sağlık Kontrolü
        John->>John: Hipokondriye karşı savaş
    end
    Note right of John: Mantıklı düşünceler <br/>galip geldi!
    John-->>Alice: Harika!
    John->>Bob: Sen nasılsın?
    Bob-->>John: Çok iyi!
```

{%/* end */%}
````

Bu şu şekilde görüntülenecektir:

{% mermaid() %}

```mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Merhaba John, nasılsın?
    loop Sağlık Kontrolü
        John->>John: Hipokondriye karşı savaş
    end
    Note right of John: Mantıklı düşünceler <br/>galip geldi!
    John-->>Alice: Harika!
    John->>Bob: Sen nasılsın?
    Bob-->>John: Çok iyi!
```

{% end %}

## Uyarı Kutuları

`admonition()` kısa kodu, sayfanıza dikkat çekici notlar yerleştirmenize yardımcı olacak bir başlık görüntüler.

`admonition()` kısa kodunu şu şekilde kullanabilirsiniz:

```markdown
{%/* admonition(type="tip", title="ipucu") */%}
`ipucu` uyarı kutusu.
{%/* end */%}
```

Uyarı kutusu kısa kodunun 12 farklı türü vardır:

{% admonition(type="note", title="not") %}
`not` uyarı kutusu.
{% end %}

{% admonition(type="abstract", title="özet") %}
`özet` uyarı kutusu.
{% end %}

{% admonition(type="info", title="bilgi") %}
`bilgi` uyarı kutusu.
{% end %}

{% admonition(type="tip", title="ipucu") %}
`ipucu` uyarı kutusu.
{% end %}

{% admonition(type="success", title="başarılı") %}
`başarılı` uyarı kutusu.
{% end %}

{% admonition(type="question", title="soru") %}
`soru` uyarı kutusu.
{% end %}

{% admonition(type="warning", title="uyarı") %}
`uyarı` uyarı kutusu.
{% end %}

{% admonition(type="failure", title="başarısızlık") %}
`başarısızlık` uyarı kutusu.
{% end %}

{% admonition(type="abstract", title="tehlike") %}
`tehlike` uyarı kutusu.
{% end %}

{% admonition(type="bug", title="hata") %}
`hata` uyarı kutusu.
{% end %}

{% admonition(type="example", title="örnek") %}
`örnek` uyarı kutusu.
{% end %}

{% admonition(type="quote", title="alıntı") %}
`alıntı` uyarı kutusu.
{% end %}

## Galeri

`gallery()` kısa kodu, sayfa varlıklarındaki tüm resimleri görüntüleyen çok basit, yalnızca HTML tabanlı tıklanabilir bir resim galerisidir.

[Zola dokümantasyonundan](https://www.getzola.org/documentation/content/image-processing/) alınmıştır.

```markdown
{{/* gallery() */}}
```

{{ gallery(alt="Galeri için demo resim") }}

## Projeler

`projects()` kısa kodu, projeleriniz için bir sayfa oluşturmanıza olanak tanır.

Bir `content/pages/projects/index.md` dosyası oluşturun:

```markdown
+++
title = "Projelerim"
description = ""
path = "projects"
+++

{{/* projects(path="data.toml", format="toml") */}}
```

Bir `content/pages/projects/data.toml` dosyası oluşturun:

```toml
[[project]]
name = "lorem"
desc = "Lorem ipsum dolor sit."
tags = ["lorem", "ipsum"]
links = [
    { name = "homepage", url = "https://example.com" },
    { name = "source", url = "https://example.com" },
]
```

Bu şu şekilde görüntülenecektir:

{{ projects(path="projects.toml", format="toml") }}
