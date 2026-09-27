+++
title = "راهنمای ساختار نگارش مارک‌داون"
description = "یک مقاله نمونه که ساختار و نحوه قالب‌بندی اولیه مارک‌داون را برای عناصر HTML نمایش می‌دهد."
date = 2023-10-20
[taxonomies]
tags = ["markdown", "html"]
authors = ["salif"]
[extra]
[extra.cover]
image = "images/markdown-syntax.png"
alt = "یک لوگوی مارک‌داون"
width = 1600
height = 800
+++

این مقاله نمونه‌ای از ساختار نگارش اولیه مارک‌داون (Markdown) را ارائه می‌دهد که می‌تواند در فایل‌های محتوای زولا استفاده شود؛ همچنین نشان می‌دهد که آیا عناصر پایه HTML با CSS در پوسته لینکیتا آراسته شده‌اند یا خیر.

<!--more-->

## سرعنوان‌ها (Headings)

عناصر HTML از `<h1>` تا `<h6>` نشان‌دهنده شش سطح از سرعنوان‌های بخش‌ها هستند. عنصر `<h1>` بالاترین سطح بخش و `<h6>` پایین‌ترین سطح است.

# H1

## H2

### H3

#### H4

##### H5

###### H6

## بند (Paragraph)

Xerum, quo qui aut unt expliquam qui dolut labo. Aque venitatiusda cum, voluptionse latur sitiae dolessi aut parist aut dollo enim qui voluptate ma dolestendit peritin re plis aut quas inctum laceat est volestemque commosa as cus endigna tectur, offic to cor sequas etum rerum idem sintibus eiur? Quianimin porecus evelectur, cum que nis nust voloribus ratem aut omnimi, sitatur? Quiatem. Nam, omnis sum am facea corem alique molestrunt et eos evelece arcillit ut aut eos eos nus, sin conecerem erum fuga. Ri oditatquam, ad quibus unda veliamenimin cusam et facea ipsamus es exerum sitate dolores editium rerore eost, temped molorro ratiae volorro te reribus dolorer sperchicium faceata tiustia prat.

Itatur? Quiatae cullecum rem ent aut odis in re eossequodi nonsequ idebis ne sapicia is sinveli squiatum, core et que aut hariosam ex eat.

## نقل‌قول‌ها (Blockquotes)

عنصر blockquote نمایانگر محتوایی است که از منبع دیگری نقل شده است، همراه با ارجاع اختیاری که باید داخل یک عنصر `footer` یا `cite` قرار گیرد، و همچنین تغییرات درون‌خطی اختیاری مانند حاشیه‌نویسی‌ها و اختصارات.

#### نقل‌قول بدون ذکر منبع

> Tiam, ad mint andaepu dandae nostion secatur sequo quae.
> **توجه داشته باشید** که می‌توانید از _ساختار نگارش مارک‌داون_ درون یک نقل‌قول استفاده کنید.

#### نقل‌قول با ذکر منبع

> با به اشتراک گذاشتن حافظه ارتباط برقرار نکنید، با ارتباط برقرار کردن حافظه را به اشتراک بگذارید.<br>
> — <cite>راب پایک[^1]</cite>

[^1]: نقل‌قول فوق برگرفته از [سخنرانی](https://www.youtube.com/watch?v=PAAkCSZUG1c) راب پایک در جریان Gopherfest، مورخ ۱۸ نوامبر ۲۰۱۵ است.

## پیوندها (Links)

برای ایجاد پیوند، متن پیوند را در براکت قرار دهید و بلافاصله پس از آن، نشانی وب (URL) را در پرانتز بیاورید.

[YouTube](https://www.youtube.com)

برای تبدیل سریع یک آدرس اینترنتی یا ایمیل به پیوند، آن را در علامت‌های کوچکتر و بزرگتر قرار دهید.

<https://www.youtube.com>

## تصاویر (Images)

![راهنمای مارک‌داون](../images/markdown-syntax.png)

## جدول‌ها (Tables)

جدول‌ها بخشی از مشخصات اصلی مارک‌داون نیستند، اما زولا به صورت پیش‌فرض از آن‌ها پشتیبانی می‌کند.

| نام | سن |
| ----- | --- |
| باب | ۲۷ |
| آلیس | ۲۳ |

#### مارک‌داون درون‌خطی در جدول‌ها

| کج (Italics) | پررنگ (Bold) | کد (Code) |
| --------- | -------- | ------ |
| _کج_ | **پررنگ** | `code` |

## بلوک‌های کد (Code Blocks)

#### بلوک کد با بک‌تیک (Backticks)

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

#### بلوک کد با چهار فاصله تورفتگی

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

## انواع فهرست‌ها (List Types)

#### فهرست مرتب (شماره‌دار)

1. مورد اول
2. مورد دوم
3. مورد سوم

#### فهرست نامرتب (نشانه‌دار)

- مورد فهرست
- موردی دیگر
- و موردی دیگر

#### فهرست تودرتو

- میوه
  - سیب
  - پرتقال
  - موز
- لبنیات
  - شیر
  - پنیر

## سایر عناصر — abbr، sub، sup، kbd، mark

فرمت <abbr title="Graphics Interchange Format">GIF</abbr> یک فرمت تصویر بیتی (bitmap) است.

H<sub>2</sub>O

X<sup>n</sup> + Y<sup>n</sup> = Z<sup>n</sup>

کلیدهای <kbd><kbd>CTRL</kbd>+<kbd>ALT</kbd>+<kbd>Delete</kbd></kbd> را برای پایان دادن به نشست فشار دهید.

بیشتر <mark>سمندرها</mark> شب‌زی هستند و به شکار حشرات، کرم‌ها و سایر موجودات کوچک می‌پردازند.
