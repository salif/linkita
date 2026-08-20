+++
title = "الترقية إلى Zola 0.23.4"
description = "كيفية ترحيل موقع Linkita إلى Zola v0.23.4"
date = 2026-08-16
updated = 2026-08-16
[taxonomies]
authors = ["salif"]
[extra]
inline_code_fix = true
+++

استبدل Zola v0.23 محرك القوالب الخاص به، Tera، بإصدار رئيسي جديد (Tera v2). يصفه مشروع Zola نفسه بأنه
> ربما يكون أكثر إصدار يسبب تغييرات جذرية في Zola على الإطلاق

وكان لا بد من إعادة كتابة قوالب Linkita للتوافق معه. يرشدك هذا الدليل خلال عملية نقل موقع Linkita من Zola v0.22.1 إلى Zola v0.23.4.

## نقل المستودع

تم نقل Linkita في الوقت نفسه من Codeberg إلى GitHub. إذا كنت لا تزال تستخدم مستودع Codeberg، فيجب عليك التبديل إلى مستودع GitHub أولاً. بالنسبة لمستخدمي الوحدات الفرعية (submodule)، إليك التعليمات:

```sh
git submodule init
git config -f .gitmodules submodule."themes/linkita".url https://github.com/salif/linkita.git
git config -f .gitmodules submodule."themes/linkita".branch tera1
git submodule sync
git submodule update
git add .gitmodules
```

## من يحتاج إلى هذا الدليل

هذا الدليل مخصص لك إذا كان موقعك يستخدم حالياً Linkita على فرع `tera1` (أو على `linkita` / `v4`) مع Zola v0.22.1 أو إصدار أقدم.

إذا كنت لا ترغب في ترقية Zola بعد، فلن تحتاج إلى القيام بأي شيء – سيستمر فرع `tera1` في العمل مع إصدارات Zola القديمة ولن يتم حذفه.

## الخطوة 1: ترقية Zola إلى v0.23.4

قم بتثبيت Zola v0.23.4 أو إصدار أحدث. تحقق من الإصدار المثبت لديك عبر:

```sh
zola --version
```

يعد Zola v0.23 قفزة كبيرة. ألقِ نظرة سريعة على [سجل تغييرات Zola v0.23.0](https://github.com/getzola/zola/blob/master/CHANGELOG.md#0230-2026-08-05) إذا كان موقعك يحتوي على قوالب مخصصة تتجاوز قوالب Linkita الخاصة – يغطي الجزء المتبقي من هذا الدليل فقط التغييرات من جانب Linkita.

## الخطوة 2: التبديل إلى الفرع `main`

يستهدف فرع `main` في Linkita الآن Zola v0.23.0+. يظل فرع `tera1` مخصصاً لمحرك القوالب القديم لـ Zola v0.22.1 والإصدارات الأقدم.

إذا قمت بتثبيت Linkita كوحدة فرعية في git:

```sh
git submodule set-branch --branch main themes/linkita
git submodule update --remote themes/linkita
```

## الخطوة 3: تحديث ملف `zola.toml` / `config.toml`

راجع كلاً من العناصر التالية. لا يفرض Zola أياً منها – لن يؤدي ترك المفاتيح القديمة إلى كسر عملية البناء، لكنها ستتوقف عن العمل بصمت، لذا يجدر تنظيفها.

### روابط القوائم والتواصل الاجتماعي: `$BASE_URL` ← `@base`

يُكتب `$BASE_URL` في `extra.menus` وعناوين URL لملفات التعريف `social` و`extra.footer.license_url` الآن بالصيغة `@base`:

```toml ,name=zola.toml
# قبل
[extra.menus]
menu_name = [
  { url = "$BASE_URL/blog/", name = "الأرشيف" },
]

# بعد
[extra.menus]
menu_name = [
  { url = "@base/blog/", name = "الأرشيف" },
]
```

ينطبق تغيير الاسم نفسه على مدخلات `social` للملف الشخصي و`extra.footer.license_url`. يمكنك أيضاً استخدام [روابط Zola الداخلية](https://www.getzola.org/documentation/content/linking/#internal-links) (`@/...`) بدلاً من `@base` إذا كنت تفضل ذلك.

هناك أيضاً بادئة جديدة `@lang` لعناوين URL في القوائم/التواصل الاجتماعي تُعيّن مساراً بلغة محددة، إذا احتجت إلى ذلك.

لاحظ أن هذا **لا** ينطبق على `extra.footer.copyright` – لا تزال هذه السلسلة تستخدم `$BASE_URL` و`$YEAR` و`$LICENSE_URL` كما كان من قبل:

```toml ,name=zola.toml
[extra.footer]
copyright = "&copy; $YEAR اسمك &vert; [CC BY-SA 4.0]($LICENSE_URL)"
```

### الملفات الشخصية: تبسيط إعدادات Open Graph

تمت إزالة الجدول الفرعي `[extra.profiles.<user>.open_graph]`. تم نقل `image` و`image_alt` إلى مستوى أعلى وتمت إعادة تسميتهما، وتم نقل `fediverse_creator` إلى مستوى أعلى أيضاً، كما تمت إزالة الحقول الخاصة بـ Facebook بالكامل (`first_name` و`last_name` و`username` و`gender` و`fb_app_id` و`fb_admins`) وقسم ترجمة Open Graph لكل لغة:

```toml ,name=zola.toml
# قبل
[extra.profiles.your_username.open_graph]
image = "cover.png"
image_alt = "وصف الصورة"
fediverse_creator = { handle = "me", domain = "mastodon.social" }

# بعد
[extra.profiles.your_username]
# ...avatar_url و name و bio و social، إلخ كما كانت سابقاً، بالإضافة إلى:
og_image = "cover.png"
og_image_alt = "وصف الصورة"
fediverse_creator = { handle = "me", domain = "mastodon.social" }
```

إذا كنت تعتمد على `first_name` / `last_name` / `gender` / `fb_app_id` / `fb_admins` أو على تجاوز `open_graph.languages.<lang>.image_alt` لكل لغة، فلا يوجد بديل مباشر – لم يعد القالب يُخرج حقول Open Graph هذه.

### خيارات اللغة: إزالة `locale` وتغيير تنسيق التاريخ

لم يعد عامل تصفية `date` في Zola يقبل وسيطة `locale`، لذا تمت إزالة متغير `extra.languages.<lang>.locale` (مثل `locale = "fr_FR"`). انتقل تنسيق التاريخ من حزمة `chrono` إلى `jiff`، لذا تُفسَّر سلاسل `date_format` الآن وفقاً لـ [مرجع strftime الخاص بـ jiff](https://docs.rs/jiff/latest/jiff/fmt/strtime/index.html#conversion-specifications) بدلاً من chrono.

```toml ,name=zola.toml
# قبل
[extra.languages.fr]
locale = "fr_FR"
date_format = "%x"

# بعد
[extra.languages.fr]
date_format = "%F"
num_format = "fr"
```

التأثير العملي: إذا كنت تعتمد على `locale` لطباعة أسماء الأشهر/أيام الأسبوع المترجمة (عبر رموز مثل `%B` أو `%A`)، فلن يحدث ذلك تلقائياً بعد الآن. راجع رموز `date_format` الخاصة بك وفقاً لوثائق jiff – قد ترغب في التبديل إلى تنسيق رقمي فقط، أو قبول عرض أسماء الأشهر/الأيام بما ينتجه jiff افتراضياً لهذا الرمز. يظل `num_format` (لتنسيق الأرقام، ولا علاقة له بالتواريخ) دون تغيير ولا يزال لكل لغة.

### إزالة `disable_javascript`

تمت إزالة متغير الإعداد `extra.disable_javascript`، والذي كان يتيح لك إيقاف تشغيل JS الخاص بالقالب وإعادة تنفيذه بنفسك عبر حقن الشفرات (injects).

### روابط التوثيق

إذا كنت تضع روابط لتوثيق Linkita في أي مكان، فلاحظ أن عرض الأكواد القصيرة (shortcodes) انتقل من `/shortcodes/` إلى `/components/` (على سبيل المثال، ميزة المشاريع موثقة الآن في `https://salif.github.io/linkita/components/#projects`).

تم توضيح وثائق صورة الغلاف لتبين أن `extra.cover.image` يقبل إما اسم ملف من أصول الصفحة أو مساراً متوافقاً مع `get_url` – كان هذا يعمل بالفعل من قبل، لكنه لم يكن موضحاً بالتفصيل.

## الخطوة 4: تحديث المحتوى – الأكواد القصيرة أصبحت مكونات

هذا هو التغيير الأكثر احتمالاً للتأثير على مقالاتك الحالية.

أزال Zola v0.23 الأكواد القصيرة (shortcodes) تماماً. لم يعد هناك دليل `templates/shortcodes/`، واختفى الأسلوب القديم لاستدعاء الكود القصير في محتوى Markdown (بوجود محتوى بداخله أو بدونه) – كلا الشكلين يفشلان الآن في البناء مع ظهور خطأ "unknown function" / "unknown tag". بدلاً من ذلك، تتم معالجة ملفات `.md` بواسطة Tera مباشرة تماماً مثل قوالب `.html`، وتستدعي **مكونات** Linkita المدمجة باستخدام صيغة الاستدعاء الجديدة في Tera v2.

يتم استدعاء المكون الذي يحتوي على نص كالتالي – لاحظ أن علامة النسبة المئوية والقوس المعقوف يحيطان بعلامات الأقواس الزاوية، وليس أقواس معقوفة مزدوجة:

```markdown
{% <component_name arg="value"> %}
محتوى النص
{% </component_name> %}
```

يستخدم المكون الذي ليس له نص (مغلق ذاتياً) أقواس معقوفة مزدوجة بدلاً من ذلك:

```markdown
{{<component_name arg="value" />}}
```

### التنبيهات (Admonition)

```markdown
# قبل
{% admonition(type="note", title="ملاحظة") %}
هذا نص **ملاحظة**.
{% end %}

# بعد
{% <admonition type="note" title="ملاحظة"> %}
هذا نص **ملاحظة**.
{% </admonition> %}
```

### المعرض (Gallery)

يحتاج المعرض الآن إلى تمرير `page` و`config` بشكل صريح (مكونات Tera v2 لا تحصل على وصول ضمني إلى الصفحة/الإعدادات كما كانت الأكواد القصيرة القديمة – أنت تمررها بالاسم، وبما أن أسماء المتغيرات تتطابق بالفعل مع أسماء المعاملات، يمكنك فقط كتابة `page config`):

```markdown
# قبل
{{ gallery() }}

# بعد
{{<gallery page config alt="" />}}
```

### Mermaid

````markdown
# قبل
{% mermaid() %}
```mermaid
graph TD;
A-->B;
```
{% end %}

# بعد
{% <mermaid> -%}
```mermaid
graph TD;
A-->B;
```
{%- </mermaid> %}
````

استخدم شرطات تقليم المسافات البيضاء الموضحة أعلاه (مباشرة بعد علامة النسبة المئوية للفتح ومباشرة قبل علامة الإغلاق) – بدونها، لن يتم حذف السطر الفارغ السابق قبل كتلة الشيفرة وسيتم عرض المخطط مع بقاء علامات ` ```mermaid ` مرئية بدلاً من تنظيفها بواسطة المكون.

### المشاريع (Projects)

تحتاج المشاريع أيضاً الآن إلى تمرير `page` و`config` بشكل صريح:

```markdown
# قبل
{{ projects(path="data.toml", format="toml") }}

# بعد
{{<projects path="data.toml" format="toml" page config />}}
```

### إذا كنت تكتب عن صيغة Tera في منشوراتك

نظراً لأن ملفات `.md` تتم معالجتها الآن بواسطة Tera قبل تحليل Markdown، فإن علامات Tera الحرفية داخل كتل الشيفرة البرمجية – مثل الأمثلة أعلاه – سيتم تنفيذها بالفعل بدلاً من عرضها كنص، حتى داخل كتل الفواصل الثلاثية. غلف أي مثال كهذا في كتلة raw لعرضه حرفياً.

```markdown
{% raw %}
...
{% endraw %}
```

## الخطوة 5: ملفات اللغة المخصصة

إذا أضفت ملف `static/i18n/<lang>.json` مخصصاً، فقم بمزامنة تغييراتك مع ملف اللغة الافتراضي للسمة.

## الخطوة 6 (متقدم): تجاوزات القوالب المخصصة أو الحقن

تخطَّ هذا القسم إلا إذا كنت قد قمت بتجاوز أحد قوالب Linkita الخاصة، أو كنت تستدعي وحدات الماكرو الداخلية الخاصة به مباشرة من قوالبك أو عمليات الحقن.

اختفت وحدات ماكرو Tera v1 في Tera v2، وحلت محلها **المكونات (components)**، والتي يتم استدعاؤها عالمياً بالاسم – لم يعد هناك `{% import %}` أو مساحة أسماء `self::`.

تغييرات أخرى في صيغة Tera v2 تظهر عبر القوالب، في حال كانت تجاوزاتك تستخدمها:

- أصبحت `trim_start_matches(pat=...)` / `trim_end_matches(pat=...)` الآن `trim_start(pat=...)` / `trim_end(pat=...)`.
- أصبحت `linebreaksbr` الآن `newlines_to_br`.
- تحتاج `default(value=x)` إلى إضافة `boolean=true` (أي `default(value=x, boolean=true)`) لمعاملة السلاسل الفارغة/`false` على أنها "استخدم القيمة الافتراضية" – بدونها، فقط القيمة غير المعرفة/الخالية حقاً هي التي تُفعّل القيمة الافتراضية.
- السلسلة الاختيارية (`?.` / `?[...]`) متاحة ومستخدمة في جميع الأنحاء لقراءة قيم الإعدادات التي قد لا تكون معينة بأمان.
- لم يعد السياق العام (`page`، `config`، `lang`، إلخ) متاحاً بشكل ضمني داخل المكون كما كان داخل الماكرو – تعلن المكونات وتستقبله صراحة، ولهذا السبب سترى معاملات `page: map` و`config: map` في جميع القوالب الجديدة.
- تمت إزالة قوالب `templates/sitemap.xml` و`templates/split_sitemap_index.xml` المخصصة من السمة. إذا كنت قد قمت بتجاوز أي منهما بنفسك، فتحقق مما إذا كنت لا تزال بحاجة إلى ذلك.

للحصول على الصورة الكاملة لما تغير في Tera نفسها، راجع [دليل ترحيل Tera v1 إلى v2](https://github.com/Keats/tera/blob/master/MIGRATION.md).

## الخطوة 7: إعادة البناء والتحقق

```sh
zola build
```

ثم راجع الموقع، وخاصة:

- عناصر القائمة وأيقونات التواصل الاجتماعي تشير إلى عناوين URL الصحيحة (تغيير `@base`).
- صورة/وصف Open Graph لملفك الشخصي وعلامة رابط التحقق من Fediverse موجودة في علامة `<head>` بالصفحة.
- تنسيق التاريخ غير الإنجليزي لا يزال يبدو صحيحاً – هذا هو العنصر الأكثر عرضة للتغيير بصمت (لا مزيد من أسماء الأشهر/الأيام المترجمة محلياً).
- تعمل أي تنبيهات أو معارض أو مخططات Mermaid أو صفحة مشاريع بشكل صحيح.

## الحصول على المساعدة

إذا لم يتطابق شيء مع ما هو موضح هنا، فراجع [README](https://github.com/salif/linkita/blob/main/README.md) و[CHANGELOG](https://github.com/salif/linkita/blob/main/CHANGELOG.md) على فرع `main`، أو [ابدأ مناقشة](https://github.com/salif/linkita/discussions).
