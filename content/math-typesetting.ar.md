+++
title = "تنضيد المعادلات الرياضية"
description = "دليل موجز لإعداد KaTeX."
date = 2022-10-20
updated = 2025-01-05
[taxonomies]
authors = ["kita", "salif"]
[extra]
math = true
+++

يدعم قالب لينكيتا المعادلات الرياضية بصيغة $\LaTeX$ باستخدام [KaTeX](https://katex.org/).

<!--more-->

- لتمكين KaTeX بشكل عام، قم بتعيين المتغير `extra.math` إلى `true` في إعدادات المشروع.
- لتمكين KaTeX على أساس كل صفحة على حدة، قم بتضمين المتغير `extra.math = true` في البيانات الوصفية لملفات المحتوى.

**ملاحظة:** استخدم المرجع عبر الإنترنت لـ [دوال TeX المدعومة](https://katex.org/docs/supported.html).

## أمثلة

### معادلة رياضية مُضمّنة

```markdown
عندما $x = \pi$، يمكن إعادة كتابة صيغة أويلر بالشكل $e^{i \pi} + 1 = 0$.
```

عندما $x = \pi$، يمكن إعادة كتابة صيغة أويلر بالشكل $e^{i \pi} + 1 = 0$.

### كتلة رياضية

```markdown
$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
```

$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
