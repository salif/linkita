+++
title = "Zola 0.23.4으로 전환하기"
description = "Linkita 사이트를 Zola v0.23.4으로 마이그레이션하는 방법"
date = 2026-08-16
updated = 2026-08-16
[taxonomies]
authors = ["salif"]
[extra]
inline_code_fix = true
+++

Zola v0.23에서는 템플릿 엔진인 Tera를 새로운 메이저 버전(Tera v2)으로 교체했습니다. Zola 프로젝트 자체에서도 이를
> 아마도 Zola 역사상 가장 큰 변화를 가져올 버전

이라고 부르고 있으며, Linkita의 템플릿도 이에 맞춰 다시 작성되어야 했습니다. 이 문서는 Linkita 사이트를 Zola v0.22.1에서 Zola v0.23.4으로 마이그레이션하는 과정을 안내합니다.

## 저장소 이전

Linkita는 이와 동시에 Codeberg에서 GitHub으로 이전되었습니다. 여전히 Codeberg 저장소를 사용하고 계시다면, 먼저 GitHub 저장소로 전환해야 합니다. git 서브모듈(submodule) 사용자를 위한 지침은 다음과 같습니다:

```sh
git submodule init
git config -f .gitmodules submodule."themes/linkita".url https://github.com/salif/linkita.git
git config -f .gitmodules submodule."themes/linkita".branch tera1
git submodule sync
git submodule update
git add .gitmodules
```

## 이 가이드의 대상

이 가이드는 현재 Zola v0.22.1 이하 버전과 함께 `tera1` 브랜치(또는 `linkita` / `v4`)의 Linkita를 사용하는 사이트를 위한 것입니다.

아직 Zola를 업그레이드하고 싶지 않다면 아무것도 할 필요가 없습니다. `tera1` 브랜치는 이전 Zola 버전에서 계속 작동하며 사라지지 않습니다.

## 1단계: Zola를 v0.23.4으로 업그레이드

Zola v0.23.4 이상을 설치하세요. 다음 명령어로 설치된 버전을 확인합니다:

```sh
zola --version
```

Zola v0.23은 큰 도약입니다. 사이트에 Linkita 자체 템플릿 외에 커스텀 템플릿이 있다면 [Zola v0.23.0 변경 로그](https://github.com/getzola/zola/blob/master/CHANGELOG.md#0230-2026-08-05)를 훑어보세요. 이 가이드의 나머지 부분에서는 Linkita 측에서 변경된 내용만 다룹니다.

## 2단계: `main` 브랜치로 전환

이제 Linkita의 `main` 브랜치는 Zola v0.23.0+를 대상으로 합니다. `tera1` 브랜치는 Zola v0.22.1 이하를 위한 이전 템플릿 엔진으로 유지됩니다.

Linkita를 git 서브모듈로 설치한 경우:

```sh
git submodule set-branch --branch main themes/linkita
git submodule update --remote themes/linkita
```

## 3단계: `zola.toml` / `config.toml` 업데이트

다음 항목들을 차례로 검토하세요. 이 중 어느 것도 Zola에서 강제하는 것은 아닙니다. 남아 있는 이전 키가 빌드를 중단시키지는 않지만 조용히 작동을 멈추므로 정리하는 것이 좋습니다.

### 메뉴 및 소셜 링크: `$BASE_URL` → `@base`

`extra.menus`, 프로필의 `social` URL 및 `extra.footer.license_url`의 `$BASE_URL`은 이제 `@base`로 작성합니다:

```toml ,name=zola.toml
# 이전
[extra.menus]
menu_name = [
  { url = "$BASE_URL/blog/", name = "아카이브" },
]

# 이후
[extra.menus]
menu_name = [
  { url = "@base/blog/", name = "아카이브" },
]
```

동일한 이름 변경이 프로필의 `social` 항목과 `extra.footer.license_url`에도 적용됩니다. 원하는 경우 `@base` 대신 [Zola 내부 링크](https://www.getzola.org/documentation/content/linking/#internal-links)(`@/...`)를 사용할 수도 있습니다.

필요한 경우 특정 언어 내의 경로를 확인하는 메뉴/소셜 URL용 새 `@lang` 접두사도 있습니다.

이것은 `extra.footer.copyright`에는 **적용되지 않습니다**. 해당 문자열은 이전과 마찬가지로 여전히 `$BASE_URL`, `$YEAR` 및 `$LICENSE_URL`을 사용합니다:

```toml ,name=zola.toml
[extra.footer]
copyright = "&copy; $YEAR 작성자 이름 &vert; [CC BY-SA 4.0]($LICENSE_URL)"
```

### 프로필: Open Graph 설정 간소화

`[extra.profiles.<user>.open_graph]` 하위 테이블이 제거되었습니다. `image` 및 `image_alt`가 한 단계 위로 이동하고 이름이 변경되었으며, `fediverse_creator`도 한 단계 위로 이동했습니다. Facebook 전용 필드(`first_name`, `last_name`, `username`, `gender`, `fb_app_id`, `fb_admins`)와 언어별 Open Graph 번역 섹션이 완전히 삭제되었습니다:

```toml ,name=zola.toml
# 이전
[extra.profiles.your_username.open_graph]
image = "cover.png"
image_alt = "설명"
fediverse_creator = { handle = "me", domain = "mastodon.social" }

# 이후
[extra.profiles.your_username]
# ...avatar_url, name, bio, social 등 기존과 동일하게 유지하고 다음 추가:
og_image = "cover.png"
og_image_alt = "설명"
fediverse_creator = { handle = "me", domain = "mastodon.social" }
```

`first_name` / `last_name` / `gender` / `fb_app_id` / `fb_admins` 또는 언어별 `open_graph.languages.<lang>.image_alt` 재정의를 사용하고 계셨다면 직접적인 대체 기능은 없습니다. 해당 Open Graph 필드는 더 이상 테마에서 출력되지 않습니다.

### 언어 옵션: `locale` 제거, 날짜 형식 변경

Zola의 `date` 필터가 더 이상 `locale` 인수를 허용하지 않으므로 `extra.languages.<lang>.locale` 변수(예: `locale = "fr_FR"`)가 제거되었습니다. 날짜 형식이 `chrono` 크레이트에서 `jiff`로 이전되었으므로, `date_format` 문자열은 이제 chrono 대신 [jiff의 strftime 참조 문서](https://docs.rs/jiff/latest/jiff/fmt/strtime/index.html#conversion-specifications)에 따라 해석됩니다.

```toml ,name=zola.toml
# 이전
[extra.languages.fr]
locale = "fr_FR"
date_format = "%x"

# 이후
[extra.languages.fr]
date_format = "%F"
num_format = "fr"
```

실제 영향: 번역된 월/요일 이름을 출력하기 위해 `locale`에 의존하고 계셨다면(예: `%B` 또는 `%A` 토큰), 더 이상 자동으로 번역되지 않습니다. jiff 문서를 참조하여 `date_format` 토큰을 확인하세요. 숫자 전용 형식으로 전환하거나 해당 토큰에 대해 jiff가 기본적으로 출력하는 형식을 사용할 수 있습니다. `num_format`(날짜와 무관한 숫자 서식 지정)은 변경되지 않았으며 여전히 언어별로 유지됩니다.

### `disable_javascript` 제거

테마의 JS를 비활성화하고 인젝트를 통해 직접 다시 구현할 수 있도록 지원하던 `extra.disable_javascript` 설정 변수가 제거되었습니다.

### 문서 링크

Linkita의 자체 문서를 링크하는 경우, 숏코드 데모가 `/shortcodes/`에서 `/components/`로 이동했습니다(예: 프로젝트 기능은 현재 `https://salif.github.io/linkita/components/#projects`에 문서화되어 있습니다).

커버 이미지 문서는 `extra.cover.image`가 페이지 자산 파일 이름 또는 `get_url` 호환 경로를 허용하도록 명확히 정리되었습니다(이전에도 작동했지만 명시적으로 설명되지 않았습니다).

## 4단계: 콘텐츠 업데이트 – 숏코드가 이제 컴포넌트로 변경됨

이 변경 사항은 기존 게시물에 영향을 미칠 가능성이 가장 큽니다.

Zola v0.23에서는 숏코드가 완전히 제거되었습니다. 더 이상 `templates/shortcodes/` 디렉터리가 없으며, Markdown 콘텐츠에서 숏코드를 함수 호출 스타일(본문 포함 또는 제외)로 호출하던 방식은 사라졌습니다. 두 형식 모두 빌드 시 "unknown function" / "unknown tag" 오류가 발생합니다. 대신 `.html` 템플릿과 마찬가지로 `.md` 파일이 Tera로 직접 템플릿화되며, Tera v2의 새로운 호출 구문을 사용하여 Linkita의 내장 **컴포넌트**를 호출합니다.

본문이 있는 컴포넌트는 다음과 같이 호출합니다(이중 중괄호가 아닌 백분율 기호와 중괄호가 꺾쇠괄호 태그를 감싸는 것에 유의하세요):

```markdown
{% <component_name arg="value"> %}
본문 내용
{% </component_name> %}
```

본문이 없는(자체 닫힘) 컴포넌트는 이중 중괄호를 사용합니다:

```markdown
{{<component_name arg="value" />}}
```

### 알림 상자 (Admonition)

```markdown
# 이전
{% admonition(type="note", title="참고") %}
이것은 **참고** 본문입니다.
{% end %}

# 이후
{% <admonition type="note" title="참고"> %}
이것은 **참고** 본문입니다.
{% </admonition> %}
```

### 갤러리 (Gallery)

이제 갤러리에는 `page`와 `config`를 명시적으로 전달해야 합니다(Tera v2 컴포넌트는 이전 숏코드처럼 page/config에 암시적으로 접근할 수 없습니다. 이름으로 전달하며 변수 이름이 매개변수 이름과 이미 일치하므로 `page config`라고만 작성하면 됩니다):

```markdown
# 이전
{{ gallery() }}

# 이후
{{<gallery page config alt="" />}}
```

### Mermaid

````markdown
# 이전
{% mermaid() %}
```mermaid
graph TD;
A-->B;
```
{% end %}

# 이후
{% <mermaid> -%}
```mermaid
graph TD;
A-->B;
```
{%- </mermaid> %}
````

위에 표시된 공백 제거 대시(여는 백분율 괄호 바로 뒤와 닫는 백분율 괄호 바로 앞)를 사용하세요. 대시가 없으면 코드 블록 앞의 선행 빈 줄이 제거되지 않아 다이어그램이 컴포넌트에 의해 정리되지 않고 ` ```mermaid ` 펜스 마커가 그대로 표시된 채 렌더링됩니다.

### 프로젝트 (Projects)

프로젝트 역시 이제 `page`와 `config`를 명시적으로 전달해야 합니다:

```markdown
# 이전
{{ projects(path="data.toml", format="toml") }}

# 이후
{{<projects path="data.toml" format="toml" page config />}}
```

### 게시물에서 Tera 구문에 대해 작성하는 경우

Markdown이 파싱되기 전에 `.md` 파일이 Tera에 의해 먼저 템플릿 처리되므로, 백틱 3개 내부라도 위의 예제와 같이 코드 블록 내의 문자 그대로의 Tera 태그가 텍스트로 표시되지 않고 실제로 실행됩니다. 이러한 예제는 `raw` 블록으로 감싸서 문자 그대로 표시되도록 하세요.

```markdown
{% raw %}
...
{% endraw %}
```

## 5단계: 커스텀 언어 파일

커스텀 `static/i18n/<lang>.json` 파일을 추가한 경우, 테마의 기본 언어 파일과 변경 사항을 동기화하세요.

## 6단계(고급): 커스텀 템플릿 재정의 또는 인젝트

Linkita 자체 템플릿을 재정의했거나 자체 템플릿 또는 인젝트에서 내부 매크로를 직접 호출하지 않는 한 이 섹션은 건너뛰셔도 됩니다.

Tera v1 매크로는 Tera v2에서 제거되고 이름으로 전역 호출되는 **컴포넌트**로 대체되었습니다(더 이상 `{% import %}`나 `self::` 네임스페이스가 필요하지 않습니다).

자체 재정의에서 사용하는 경우를 위해 템플릿 전반에 걸쳐 확인되는 기타 Tera v2 구문 변경 사항:

- `trim_start_matches(pat=...)` / `trim_end_matches(pat=...)`가 `trim_start(pat=...)` / `trim_end(pat=...)`로 변경되었습니다.
- `linebreaksbr`가 `newlines_to_br`로 변경되었습니다.
- `default(value=x)`에서 빈 문자열/`false`를 "기본값 사용"으로 처리하려면 `boolean=true`를 추가해야 합니다(`default(value=x, boolean=true)`). 이것이 없으면 완전히 정의되지 않은/null 값만 기본값을 트리거합니다.
- 설정되지 않았을 수 있는 구성 값을 안전하게 읽기 위해 옵셔널 체이닝(`?.` / `?[...]`)이 제공되며 전반적으로 사용됩니다.
- 전역 컨텍스트(`page`, `config`, `lang` 등)가 매크로 내부에서처럼 컴포넌트 내부에서 암시적으로 사용 가능하지 않습니다. 컴포넌트는 이를 명시적으로 선언하고 전달받으므로 새 템플릿 전체에서 `page: map`, `config: map` 매개변수를 볼 수 있습니다.
- 커스텀 `templates/sitemap.xml` 및 `templates/split_sitemap_index.xml` 템플릿이 테마에서 제거되었습니다. 직접 재정의한 적이 있다면 여전히 필요한지 확인하세요.

Tera 자체에서 변경된 내용의 전체 정보는 [Tera v1 → v2 마이그레이션 가이드](https://github.com/Keats/tera/blob/master/MIGRATION.md)를 참조하세요.

## 7단계: 다시 빌드 및 확인

```sh
zola build
```

빌드 후 특히 다음 사항을 검토하세요:

- 메뉴 항목 및 소셜 아이콘이 올바른 URL로 확인되는지(`@base` 변경 사항).
- 프로필의 Open Graph 이미지/설명 및 Fediverse 인증 링크 태그가 페이지 `<head>`에 있는지 확인.
- 영어가 아닌 날짜 형식이 여전히 올바르게 표시되는지 확인(로케일 번역 월/요일 이름이 제거되어 가장 조용히 변경되었을 가능성이 높은 부분입니다).
- 알림 상자, 갤러리, Mermaid 다이어그램 또는 프로젝트 페이지가 올바르게 렌더링되는지 확인.

## 도움 받기

설명된 내용과 일치하지 않는 부분이 있다면 `main` 브랜치의 [README](https://github.com/salif/linkita/blob/main/README.md) 및 [CHANGELOG](https://github.com/salif/linkita/blob/main/CHANGELOG.md)를 확인하거나 [토론을 시작](https://github.com/salif/linkita/discussions)하세요.
