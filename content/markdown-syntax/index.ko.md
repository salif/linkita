+++
title = "마크다운 문법 가이드"
description = "기본적인 마크다운 문법과 HTML 요소 서식 예제를 보여주는 샘플 글입니다."
date = 2022-10-20
#updated =
[taxonomies]
tags = ["markdown", "css", "html"]
authors = ["kita", "salif"]
[extra]
[extra.cover]
image = "images/markdown-syntax.png"
alt = "마크다운 로고"
width = 1600
height = 800
+++

이 글은 Zola 콘텐츠 파일에서 사용할 수 있는 기본적인 마크다운 문법 샘플을 제공하며, Linkita 테마에서 기본 HTML 요소들이 CSS로 어떻게 꾸며지는지 보여줍니다.

<!--more-->

## 제목

다음 HTML `<h1>`—`<h6>` 요소는 여섯 단계의 섹션 제목을 나타냅니다. `<h1>`이 가장 높은 단계의 제목이고 `<h6>`이 가장 낮은 단계입니다.

# H1

## H2

### H3

#### H4

##### H5

###### H6

## 문단

이것은 예시 문단입니다. 글의 내용을 구성하는 기본 단위이며, 여러 문장으로 이루어질 수 있습니다. 마크다운에서는 단순히 줄바꿈으로 문단을 구분합니다. 한국어 텍스트를 사용하여 문단이 어떻게 보이는지 테스트합니다.

또 다른 문단입니다. 문단과 문단 사이에는 한 줄의 공백이 있어야 합니다. 이 공백은 HTML에서 `<p>` 태그로 변환되어 문단을 시각적으로 분리하는 역할을 합니다.

## 인용문

인용문 요소는 다른 출처에서 인용한 내용을 나타냅니다. 선택적으로 `footer` 또는 `cite` 요소 안에 출처를 명시할 수 있으며, 주석이나 약어와 같은 인라인 변경 사항을 포함할 수 있습니다.

#### 출처 없는 인용문

> 이것은 인용문입니다.
> **참고**로 인용문 안에서도 _마크다운 문법_을 사용할 수 있습니다.

#### 출처 있는 인용문

> 메모리를 공유하여 소통하지 말고, 소통을 통해 메모리를 공유하세요.<br>
> — <cite>롭 파이크(Rob Pike)[^1]</cite>

[^1]: 위 인용문은 2015년 11월 18일 Gopherfest에서 있었던 롭 파이크의 [강연](https://www.youtube.com/watch?v=PAAkCSZUG1c)에서 발췌했습니다.

## 링크

링크를 만들려면, 링크 텍스트를 대괄호로 묶은 다음 바로 뒤에 URL을 소괄호로 묶어주세요.

[GitHub](https://github.com)

URL이나 이메일 주소를 빠르게 링크로 바꾸려면, 꺾쇠괄호로 묶어주세요.

<https://github.com>

## 이미지

![마크다운 가이드](../../images/markdown-syntax.png)

## 표

표는 핵심 마크다운 사양의 일부는 아니지만, Zola는 기본적으로 지원합니다.

| 이름  | 나이 |
| ----- | --- |
| 밥    | 27  |
| 앨리스| 23  |

#### 표 안의 인라인 마크다운

| 기울임꼴 | 굵게     | 코드   |
| --------- | -------- | ------ |
| _기울임꼴_ | **굵게** | `코드` |

## 코드 블록

#### 백틱을 사용한 코드 블록

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

#### 네 칸 들여쓰기를 사용한 코드 블록

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

## 목록 유형

#### 순서 있는 목록

1. 첫 번째 항목
2. 두 번째 항목
3. 세 번째 항목

#### 순서 없는 목록

- 목록 항목
- 다른 항목
- 또 다른 항목

#### 중첩 목록

- 과일
  - 사과
  - 오렌지
  - 바나나
- 유제품
  - 우유
  - 치즈

## 기타 요소 — abbr, sub, sup, kbd, mark

<abbr title="Graphics Interchange Format">GIF</abbr>는 비트맵 이미지 형식입니다.

H<sub>2</sub>O

X<sup>n</sup> + Y<sup>n</sup> = Z<sup>n</sup>

세션을 종료하려면 <kbd><kbd>CTRL</kbd>+<kbd>ALT</kbd>+<kbd>Delete</kbd></kbd>를 누르세요.

대부분의 <mark>도롱뇽</mark>은 야행성이며, 곤충, 벌레, 그리고 다른 작은 생물들을 사냥합니다.
