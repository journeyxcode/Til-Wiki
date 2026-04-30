---
title: 댓글 기능 (Giscus)
sidebar_position: 6
---

# 댓글 기능 (Giscus)

Giscus는 GitHub Discussions 기반의 무료 댓글 시스템이에요.
GitHub 계정으로 로그인해야 댓글을 작성할 수 있어서 스팸이 없어요.

## 사전 준비

### 1 — GitHub Discussions 활성화

GitHub 레포 → **Settings** → **Features** → **Discussions** 체크

### 2 — Giscus 앱 설치

```
https://github.com/apps/giscus
```

1. **Install** 클릭
2. **Only select repositories** 선택
3. 레포 선택 후 **Install**

### 3 — 설정값 발급

```
https://giscus.app/ko
```

| 항목 | 설정값 |
|------|--------|
| 저장소 | username/repo-name |
| 페이지 연결 | pathname |
| 카테고리 | General |
| 테마 | dark_dimmed |

하단에 자동 생성되는 `data-repo-id`, `data-category-id` 값을 복사해두세요.

## 설치

```bash
npm install @giscus/react
```

## 컴포넌트 생성

`src/components/GiscusComment.js` 파일 생성:

```javascript
import Giscus from '@giscus/react';
import { useColorMode } from '@docusaurus/theme-common';

function GiscusCommentInner() {
  const { colorMode } = useColorMode();
  return (
    <Giscus
      repo="username/repo-name"
      repoId="여기에_repo-id"
      category="General"
      categoryId="여기에_category-id"
      mapping="pathname"
      strict="0"
      reactionsEnabled="1"
      emitMetadata="0"
      inputPosition="bottom"
      theme={colorMode === 'dark' ? 'dark_dimmed' : 'light'}
      lang="ko"
      loading="lazy"
    />
  );
}

export default function GiscusComment() {
  if (typeof window === 'undefined') return null;
  return <GiscusCommentInner />;
}
```

:::caution
`typeof window === 'undefined'` 체크가 없으면 SSG 빌드 시 오류가 발생해요.
`useColorMode` 훅이 `ColorModeProvider` 외부에서 호출되기 때문이에요.
:::

## 문서에 적용

`src/theme/DocItem/Layout/index.js` 파일 생성:

```javascript
import Layout from '@theme-original/DocItem/Layout';
import GiscusComment from '@site/src/components/GiscusComment';

export default function LayoutWrapper(props) {
  return (
    <>
      <Layout {...props} />
      <div style={{ marginTop: '3rem', padding: '0 1rem' }}>
        <GiscusComment />
      </div>
    </>
  );
}
```

## 블로그에 적용

`src/theme/BlogPostPage.js` 파일 생성:

```javascript
import BlogPostPage from '@theme-original/BlogPostPage';
import GiscusComment from '@site/src/components/GiscusComment';

export default function BlogPostPageWrapper(props) {
  return (
    <>
      <BlogPostPage {...props} />
      <div style={{ maxWidth: '800px', margin: '0 auto', padding: '2rem' }}>
        <GiscusComment />
      </div>
    </>
  );
}
```