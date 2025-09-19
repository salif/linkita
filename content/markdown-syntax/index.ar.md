+++
title = "دليل تنسيق ماركداون"
description = "نموذج مقال يعرض تنسيق ماركداون الأساسي وتنسيق عناصر HTML."
date = 2022-10-20
updated = 2025-01-05
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["kita", "salif"]
[extra]
[extra.cover]
image = "images/markdown-syntax.png"
alt = "شعار ماركداون"
width = 1600
height = 800
+++

تقدم هذه المقالة عينة من تنسيق ماركداون الأساسي الذي يمكن استخدامه في ملفات محتوى Zola، كما توضح ما إذا كانت عناصر HTML الأساسية مزينة بـ CSS في سمة لينكيتا.

<!--more-->

## العناوين

تمثل عناصر HTML `<h1>`—`<h6>`  التالية ستة مستويات من عناوين الأقسام. `<h1>` هو أعلى مستوى للقسم بينما `<h6>` هو الأدنى.

# H1

## H2

### H3

#### H4

##### H5

###### H6

## الفقرة

Xerum، quo qui aut unt expliquam qui dolut labo. Aque venitatiusda cum، voluptionse latur sitiae dolessi aut parist aut dollo enim qui voluptate ma dolestendit peritin re plis aut quas inctum laceat est volestemque commosa as cus endigna tectur، offic to cor sequas etum rerum idem sintibus eiur؟ Quianimin porecus evelectur، cum que nis nust voloribus ratem aut omnimi، sitatur؟ Quiatem. Nam، omnis sum am facea corem alique molestrunt et eos evelece arcillit ut aut eos eos nus، sin conecerem erum fuga. Ri oditatquam، ad quibus unda veliamenimin cusam et facea ipsamus es exerum sitate dolores editium rerore eost، temped molorro ratiae volorro te reribus dolorer sperchicium faceata tiustia prat.

Itatur؟ Quiatae cullecum rem ent aut odis in re eossequodi nonsequ idebis ne sapicia is sinveli squiatum، core et que aut hariosam ex eat.

## الاقتباسات

يمثل عنصر الاقتباس المحتوى المقتبس من مصدر آخر، مع اقتباس اختياري يجب أن يكون داخل عنصر `footer` أو `cite`، واختياريًا مع تغييرات مضمنة مثل التعليقات التوضيحية والاختصارات.

#### اقتباس بدون إسناد

> Tiam، ad mint andaepu dandae nostion secatur sequo quae.
> **ملاحظة** أنه يمكنك استخدام _تنسيق ماركداون_ داخل اقتباس.

#### اقتباس مع إسناد

> لا تتواصل من خلال مشاركة الذاكرة، شارك الذاكرة من خلال التواصل. <br>
> — <cite>روب بايك[^1]</cite>

[^1]: الاقتباس أعلاه مقتطف من [حديث](https://www.youtube.com/watch?v=PAAkCSZUG1c) روب بايك خلال Gopherfest، 18 نوفمبر 2015.

## الروابط

لإنشاء رابط، قم بإحاطة نص الرابط بين قوسين ثم اتبعه مباشرةً بعنوان URL بين قوسين.

[GitHub](https://github.com)

لتحويل عنوان URL أو عنوان بريد إلكتروني بسرعة إلى رابط، قم بإحاطته بين أقواس زاوية.

<https://github.com>

## الصور

![دليل ماركداون](../../images/markdown-syntax.png)

## الجداول

الجداول ليست جزءًا من مواصفات ماركداون الأساسية، لكن Zola تدعمها.

| الاسم  | العمر |
| ----- | --- |
| بوب   | 27  |
| أليس | 23  |

#### ماركداون المضمنة داخل الجداول

| مائل     | عريض   | كود   |
| -------- | ------ | ----- |
| _مائل_ | **عريض** | `code` |

## كتل التعليمات البرمجية

#### كتلة التعليمات البرمجية مع backticks

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Example HTML5 Document</title>
  </head>
  <body>
    <p>Test</p>
  </body>
</html>
```

#### كتلة التعليمات البرمجية بمسافة بادئة أربعة مسافات

    <!doctype html>
    <html lang="en">
    <head>
      <meta charset="utf-8">
      <title>Example HTML5 Document</title>
    </head>
    <body>
      <p>Test</p>
    </body>
    </html>

## أنواع القوائم

#### قائمة مرتبة

1. العنصر الأول
2. العنصر الثاني
3. العنصر الثالث

#### قائمة غير مرتبة

- عنصر القائمة
- عنصر آخر
- وعنصر آخر

#### قائمة متداخلة

- فاكهة
  - تفاح
  - برتقال
  - موز
- ألبان
  - حليب
  - جبن

## عناصر أخرى — abbr، sub، sup، kbd، mark

<abbr title="Graphics Interchange Format">GIF</abbr> هو تنسيق صورة نقطية.

H<sub>2</sub>O

X<sup>n</sup> + Y<sup>n</sup> = Z<sup>n</sup>

اضغط على <kbd><kbd>CTRL</kbd>+<kbd>ALT</kbd>+<kbd>Delete</kbd></kbd> لإنهاء الجلسة.

معظم <mark>السلمندرات</mark> ليلية، وتصطاد الحشرات والديدان والمخلوقات الصغيرة الأخرى.
