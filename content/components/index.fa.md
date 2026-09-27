+++
title = "مولفه‌ها"
description = "نحوه استفاده از مولفه‌ها"
date = 2026-09-13
[taxonomies]
tags = ["components"]
authors = ["salif"]
[extra]
mermaid = true
+++

پوسته لینکیتا چندین مولفه در اختیارتان قرار می‌دهد.

آیا تا به حال درباره مولفه‌ها نشنیده‌اید؟ برای اطلاعات بیشتر [مستندات زولا](https://keats.github.io/tera/#components) را ببینید.

## مولفه Mermaid

برای استفاده از Mermaid در صفحه خود، باید `extra.mermaid = true` را در فرانت‌متر (frontmatter) صفحه تنظیم کنید.

```toml
+++
title = "عنوان صفحه شما"

[extra]
mermaid = true
+++
```

سپس می‌توانید از مولفه `<mermaid>` به این شکل استفاده کنید:

```markdown
{% raw %}{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}{% endraw %}
```

این به شکل زیر نمایش داده می‌شود:

{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}

علاوه بر این، می‌توانید از بلوک کد در داخل مولفه‌های `<mermaid>` استفاده کنید و این بلوک کد نادیده گرفته خواهد شد.

بلوک کد مانع از به هم ریختن قالب‌بندی Mermaid توسط فرمت‌کننده‌ها (formatter) می‌شود.

````markdown
{% raw %}{% <mermaid> -%}

```mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hello John, how are you?
    loop Healthcheck
        John->>John: Fight against hypochondria
    end
    Note right of John: Rational thoughts <br/>prevail!
    John-->>Alice: Great!
    John->>Bob: How about you?
    Bob-->>John: Jolly good!
```

{%- </mermaid> %}{% endraw %}
````

این به شکل زیر نمایش داده می‌شود:

{% <mermaid> -%}

```mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hello John, how are you?
    loop Healthcheck
        John->>John: Fight against hypochondria
    end
    Note right of John: Rational thoughts <br/>prevail!
    John-->>Alice: Great!
    John->>Bob: How about you?
    Bob-->>John: Jolly good!
```

{%- </mermaid> %}

## اعلان‌ها (Admonition)

مولفه `<admonition>` بنری را نمایش می‌دهد تا به شما در قرار دادن پیام‌ها و نکات توجه در صفحه‌تان کمک کند.

می‌توانید از این مولفه مانند زیر استفاده کنید:

```markdown
{% raw %}{% <admonition type="tip" title="tip"> %}
اعلان `tip`.
{% </admonition> %}{% endraw %}
```

مولفه اعلان ۱۲ نوع مختلف دارد:

{% <admonition type="note" title="note"> %}
اعلان `note`.
{% </admonition> %}

{% <admonition type="abstract" title="abstract"> %}
اعلان `abstract`.
{% </admonition> %}

{% <admonition type="info" title="info"> %}
اعلان `info`.
{% </admonition> %}

{% <admonition type="tip" title="tip"> %}
اعلان `tip`.
{% </admonition> %}

{% <admonition type="success" title="success"> %}
اعلان `success`.
{% </admonition> %}

{% <admonition type="question" title="question"> %}
اعلان `question`.
{% </admonition> %}

{% <admonition type="warning" title="warning"> %}
اعلان `warning`.
{% </admonition> %}

{% <admonition type="failure" title="failure"> %}
اعلان `failure`.
{% </admonition> %}

{% <admonition type="danger" title="danger"> %}
اعلان `danger`.
{% </admonition> %}

{% <admonition type="bug" title="bug"> %}
اعلان `bug`.
{% </admonition> %}

{% <admonition type="example" title="example"> %}
اعلان `example`.
{% </admonition> %}

{% <admonition type="quote" title="quote"> %}
اعلان `quote`.
{% </admonition> %}

## نگارخانه (Gallery)

مولفه `<gallery />` یک گالری تصاویر بسیار ساده، کلیک‌پذیر و صرفاً مبتنی بر HTML است که همه تصاویر را از دارایی‌های صفحه نمایش می‌دهد.

این از [مستندات زولا](https://www.getzola.org/documentation/content/image-processing/) برگرفته شده است.

```markdown
{% raw %}{{ <gallery /> }}{% endraw %}
```

{{ <gallery alt="Demo image for the gallery" /> }}

## پروژه‌ها (Projects)

مولفه `<projects />` به شما امکان می‌دهد صفحه‌ای برای پروژه‌های خود بسازید.

یک فایل به نام `content/pages/projects/index.md` ایجاد کنید:

```markdown
+++
title = "My Projects"
description = ""
path = "projects"
+++

{% raw %}{{ <projects path="data.toml" format="toml" /> }}{% endraw %}
```

یک فایل به نام `content/pages/projects/data.toml` ایجاد کنید:

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

این به شکل زیر نمایش داده خواهد شد:

{{ <projects path="projects.toml" format="toml" /> }}
