+++
title = "Bileşenler"
description = "Bileşenler nasıl kullanılır"
date = 2022-10-20
updated = 2026-08-16
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["salif"]
[extra]
mermaid = true
+++

Linkita teması çeşitli bileşenler sunar.

Bileşenleri hiç duymadınız mı? Daha fazla bilgi için [Zola dokümantasyonuna](https://keats.github.io/tera/#components) bakın.

## Mermaid bileşeni

Sayfanızda Mermaid kullanmak için, sayfanın ön yüzünde `extra.mermaid = true` olarak ayarlamanız gerekir.

```toml
+++
title = "Sayfa başlığınız"

[extra]
mermaid = true
+++
```

Ardından `<mermaid>` bileşenini şu şekilde kullanabilirsiniz:

```markdown
{% raw %}{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}{% endraw %}
```

Bu şu şekilde görüntülenecektir:

{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}

Ek olarak, `<mermaid>` bileşenlerinin içinde kod bloğu kullanabilirsiniz ve kod bloğu göz ardı edilecektir.

Kod bloğu, biçimlendiricinin mermaid'in biçimlendirmesini bozmasını engeller.

````markdown
{% raw %}{% <mermaid> -%}

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

{%- </mermaid> %}{% endraw %}
````

Bu şu şekilde görüntülenecektir:

{% <mermaid> -%}

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

{%- </mermaid> %}

## Uyarı Kutuları

`<admonition>` bileşeni, sayfanıza dikkat çekici notlar yerleştirmenize yardımcı olacak bir başlık görüntüler.

Bileşeni şu şekilde kullanabilirsiniz:

```markdown
{% raw %}{% <admonition type="tip" title="ipucu"> %}
`ipucu` uyarı kutusu.
{% </admonition> %}{% endraw %}
```

Uyarı kutusu bileşeninin 12 farklı türü vardır:

{% <admonition type="note" title="not"> %}
`not` uyarı kutusu.
{% </admonition> %}

{% <admonition type="abstract" title="özet"> %}
`özet` uyarı kutusu.
{% </admonition> %}

{% <admonition type="info" title="bilgi"> %}
`bilgi` uyarı kutusu.
{% </admonition> %}

{% <admonition type="tip" title="ipucu"> %}
`ipucu` uyarı kutusu.
{% </admonition> %}

{% <admonition type="success" title="başarılı"> %}
`başarılı` uyarı kutusu.
{% </admonition> %}

{% <admonition type="question" title="soru"> %}
`soru` uyarı kutusu.
{% </admonition> %}

{% <admonition type="warning" title="uyarı"> %}
`warning` uyarı kutusu.
{% </admonition> %}

{% <admonition type="failure" title="başarısızlık"> %}
`failure` uyarı kutusu.
{% </admonition> %}

{% <admonition type="danger" title="tehlike"> %}
`danger` uyarı kutusu.
{% </admonition> %}

{% <admonition type="bug" title="hata"> %}
`bug` uyarı kutusu.
{% </admonition> %}

{% <admonition type="example" title="örnek"> %}
`example` uyarı kutusu.
{% </admonition> %}

{% <admonition type="quote" title="alıntı"> %}
`quote` uyarı kutusu.
{% </admonition> %}

## Galeri

`<gallery />` bileşeni, sayfa varlıklarındaki tüm resimleri görüntüleyen çok basit, yalnızca HTML tabanlı tıklanabilir bir resim galerisidir.

[Zola dokümantasyonundan](https://www.getzola.org/documentation/content/image-processing/) alınmıştır.

```markdown
{% raw %}{{ <gallery /> }}{% endraw %}
```

{{ <gallery page config alt="Galeri için demo resim" /> }}

## Projeler

`<projects />` bileşeni, projeleriniz için bir sayfa oluşturmanıza olanak tanır.

Bir `content/pages/projects/index.md` dosyası oluşturun:

```markdown
+++
title = "Projelerim"
description = ""
path = "projects"
+++

{% raw %}{{ <projects path="data.toml" format="toml" page config /> }}{% endraw %}
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

{{ <projects path="projects.toml" format="toml" page config /> }}
