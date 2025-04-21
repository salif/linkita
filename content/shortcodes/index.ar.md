+++
title = "الاختصارات"
description = "اختصارات قالب لينكيتا."
date = 2022-10-20
updated = 2025-04-20
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["kita", "salif"]
[extra]
mermaid = true
+++

يوفر قالب لينكيتا العديد من الاختصارات.

لم تسمع عن الاختصارات من قبل؟ راجع [توثيق Zola](https://www.getzola.org/documentation/content/shortcodes/) لمزيد من المعلومات.

## Mermaid {#mermaid-header}

لاستخدام Mermaid في صفحتك، يجب عليك ضبط `extra.mermaid = true` في مقدمة الصفحة.

```toml
+++
title = "عنوان صفحتك"

[extra]
mermaid = true
+++
```

ثم يمكنك استخدام اختصار `mermaid()` مثل:

```markdown
{%/* mermaid() */%}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{%/* end */%}
```

سيتم عرض هذا على النحو التالي:

{% mermaid() %}

graph TD;
A-->B;
A-->C;
B-->D;
C-->D;

{% end %}

بالإضافة إلى ذلك، يمكنك استخدام كتلة التعليمات البرمجية داخل اختصار `mermaid()` وسيتم تجاهل كتلة التعليمات البرمجية.

تمنع كتلة التعليمات البرمجية المنسق من كسر تنسيق Mermaid.

````markdown
{%/* mermaid() */%}

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

{%/* end */%}
````

سيتم عرض هذا على النحو التالي:

{% mermaid() %}

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

{% end %}

## التنبيهات

يعرض اختصار `admonition()` لافتة لمساعدتك في وضع ملاحظة في صفحتك.

يمكنك استخدام اختصار `admonition()` مثل:

```markdown
{%/* admonition(type="tip", title="نصيحة") */%}
تنبيه `tip`.
{%/* end */%}
```

يحتوي اختصار التنبيه على 12 نوعًا مختلفًا:

{% admonition(type="note", title="ملاحظة") %}
تنبيه `note`.
{% end %}

{% admonition(type="abstract", title="ملخص") %}
تنبيه `abstract`.
{% end %}

{% admonition(type="info", title="معلومات") %}
تنبيه `info`.
{% end %}

{% admonition(type="tip", title="نصيحة") %}
تنبيه `tip`.
{% end %}

{% admonition(type="success", title="نجاح") %}
تنبيه `success`.
{% end %}

{% admonition(type="question", title="سؤال") %}
تنبيه `question`.
{% end %}

{% admonition(type="warning", title="تحذير") %}
تنبيه `warning`.
{% end %}

{% admonition(type="failure", title="فشل") %}
تنبيه `failure`.
{% end %}

{% admonition(type="abstract", title="خطر") %}
تنبيه `danger`.
{% end %}

{% admonition(type="bug", title="خطأ") %}
تنبيه `bug`.
{% end %}

{% admonition(type="example", title="مثال") %}
تنبيه `example`.
{% end %}

{% admonition(type="quote", title="اقتباس") %}
تنبيه `quote`.
{% end %}

## معرض الصور

اختصار `gallery()` هو معرض صور بسيط قابل للنقر يعتمد على HTML فقط ويعرض جميع الصور من أصول الصفحة.

إنه من [توثيق Zola](https://www.getzola.org/documentation/content/image-processing/)

```markdown
{{/* gallery() */}}
```

{{ gallery(alt="صورة تجريبية لمعرض الصور") }}

## المشاريع

يتيح لك الكود المختصر `projects()` إنشاء صفحة لمشاريعك.

أنشئ ملفًا باسم `content/pages/projects/index.md`:

```markdown
+++
title = "مشاريعي"
description = ""
path = "projects"
+++

{{/* projects(path="data.toml", format="toml") */}}
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

{{ projects(path="projects.toml", format="toml") }}
