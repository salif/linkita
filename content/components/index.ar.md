+++
title = "المكونات"
description = "كيفية استخدام المكونات"
date = 2022-10-20
updated = 2026-08-16
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["salif"]
[extra]
mermaid = true
+++

يوفر قالب لينكيتا العديد من المكونات.

لم تسمع عن المكونات من قبل؟ راجع [توثيق Zola](https://keats.github.io/tera/#components) لمزيد من المعلومات.

## مكون Mermaid

لاستخدام Mermaid في صفحتك، يجب عليك ضبط `extra.mermaid = true` في مقدمة الصفحة.

```toml
+++
title = "عنوان صفحتك"

[extra]
mermaid = true
+++
```

ثم يمكنك استخدام مكون `<mermaid>` مثل:

```markdown
{% raw %}{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}{% endraw %}
```

سيتم عرض هذا على النحو التالي:

{% <mermaid> %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% </mermaid> %}

بالإضافة إلى ذلك، يمكنك استخدام كتلة التعليمات البرمجية داخل مكونات `<mermaid>` وسيتم تجاهل كتلة التعليمات البرمجية.

تمنع كتلة التعليمات البرمجية المنسق من كسر تنسيق Mermaid.

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

سيتم عرض هذا على النحو التالي:

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

## التنبيهات

يعرض مكون `<admonition>` لافتة لمساعدتك في وضع ملاحظة في صفحتك.

يمكنك استخدام المكون مثل:

```markdown
{% raw %}{% <admonition type="tip" title="نصيحة"> %}
تنبيه `tip`.
{% </admonition> %}{% endraw %}
```

يحتوي مكون التنبيه على 12 نوعًا مختلفًا:

{% <admonition type="note" title="ملاحظة"> %}
تنبيه `note`.
{% </admonition> %}

{% <admonition type="abstract" title="ملخص"> %}
تنبيه `abstract`.
{% </admonition> %}

{% <admonition type="info" title="معلومات"> %}
تنبيه `info`.
{% </admonition> %}

{% <admonition type="tip" title="نصيحة"> %}
تنبيه `tip`.
{% </admonition> %}

{% <admonition type="success" title="نجاح"> %}
تنبيه `success`.
{% </admonition> %}

{% <admonition type="question" title="سؤال"> %}
تنبيه `question`.
{% </admonition> %}

{% <admonition type="warning" title="تحذير"> %}
تنبيه `warning`.
{% </admonition> %}

{% <admonition type="failure" title="فشل"> %}
تنبيه `failure`.
{% </admonition> %}

{% <admonition type="danger" title="خطر"> %}
تنبيه `danger`.
{% </admonition> %}

{% <admonition type="bug" title="خطأ"> %}
تنبيه `bug`.
{% </admonition> %}

{% <admonition type="example" title="مثال"> %}
تنبيه `example`.
{% </admonition> %}

{% <admonition type="quote" title="اقتباس"> %}
تنبيه `quote`.
{% </admonition> %}

## معرض الصور

مكون `<gallery />` هو معرض صور بسيط قابل للنقر يعتمد على HTML فقط ويعرض جميع الصور من أصول الصفحة.

إنه من [توثيق Zola](https://www.getzola.org/documentation/content/image-processing/)

```markdown
{% raw %}{{ <gallery /> }}{% endraw %}
```

{{ <gallery page config alt="صورة تجريبية لمعرض الصور" /> }}

## المشاريع

يتيح لك مكون `<projects />` إنشاء صفحة لمشاريعك.

أنشئ ملفًا باسم `content/pages/projects/index.md`:

```markdown
+++
title = "مشاريعي"
description = ""
path = "projects"
+++

{% raw %}{{ <projects path="data.toml" format="toml" page config /> }}{% endraw %}
```

أنشئ ملفًا باسم `content/pages/projects/data.toml`:

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

سيتم عرض هذا كالتالي:

{{ <projects path="projects.toml" format="toml" page config /> }}
