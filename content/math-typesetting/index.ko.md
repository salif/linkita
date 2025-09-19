+++
title = "수식 조판"
description = "KaTeX 설정에 대한 간략한 안내서입니다."
date = 2022-10-20
#updated =
[taxonomies]
authors = ["kita", "salif"]
[extra]
math = true
+++

Linkita 테마는 [KaTeX](https://katex.org/)를 사용하여 $\LaTeX$ 수학 공식을 지원합니다.

<!--more-->

- KaTeX를 전체적으로 활성화하려면, 프로젝트 설정 파일에서 `extra.math` 파라미터를 `true`로 설정하세요.
- 페이지별로 KaTeX를 활성화하려면, 콘텐츠 파일의 프론트매터에 `extra.math = true` 파라미터를 포함하세요.

**참고:** [지원되는 TeX 함수](https://katex.org/docs/supported.html) 온라인 레퍼런스를 사용하세요.

## 예시

### 인라인 수식

```markdown
$x = \pi$일 때, 오일러 공식은 $e^{i \pi} + 1 = 0$로 다시 쓸 수 있습니다.
```

$x = \pi$일 때, 오일러 공식은 $e^{i \pi} + 1 = 0$로 다시 쓸 수 있습니다.

### 블록 수식

```markdown
$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
```

$$
 \varphi = 1+\frac{1} {1+\frac{1} {1+\frac{1} {1+\cdots} } }
$$
