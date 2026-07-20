---
title: SEO 설정
sidebar_position: 9
---

# SEO 설정

SEO(검색 엔진 최적화) 설정으로 Google 검색 결과에 사이트가 잘 노출되도록 해요.

## 기본 메타데이터 설정

`docusaurus.config.js` 에 메타데이터 추가:

```javascript
const config = {
  title: '사이트 제목',
  tagline: '사이트 설명',
  url: 'https://username.github.io',
  baseUrl: '/repo-name/',

  themeConfig: {
    image: 'img/social-card.jpg',  // SNS 공유 시 표시되는 이미지
    metadata: [
      {
        name: 'description',
        content: '검색 결과에 표시될 설명 (150자 이내)',
      },
      {
        name: 'keywords',
        content: 'AI, 머신러닝, LLM, RAG, Python',
      },
    ],
  },
};
```

## 문서별 SEO 설정

각 `.md` 파일 frontmatter에 추가:

```markdown
---
title: 문서 제목
description: 이 문서에 대한 설명 (검색 결과에 표시)
keywords: [키워드1, 키워드2]
image: /img/thumbnail.png
---
```

## 사이트맵 설정

Docusaurus는 기본적으로 `sitemap.xml` 을 자동 생성해요.
배포 후 아래 주소에서 확인 가능해요:

```
https://username.github.io/repo-name/sitemap.xml
```

## Google Search Console 등록

사이트맵을 Google에 제출하면 검색 색인이 빨라져요:

```
https://search.google.com/search-console
```

1. **속성 추가** 클릭
2. URL 접두사 → 사이트 주소 입력
3. 소유권 확인 (HTML 태그 방식 추천)
4. **Sitemaps** → 사이트맵 URL 제출

```
https://username.github.io/repo-name/sitemap.xml
```

## 소유권 확인 (HTML 태그 방식)

Google Search Console에서 발급받은 메타 태그를 `docusaurus.config.js` 에 추가:

```javascript
themeConfig: {
  metadata: [
    {
      name: 'google-site-verification',
      content: '여기에_발급받은_값',
    },
  ],
},
```

:::tip
SEO 효과는 즉시 나타나지 않아요.
Google이 사이트를 색인하는 데 **수 주~수 개월** 이 걸릴 수 있어요.
꾸준히 내용을 업데이트하는 것이 장기적으로 가장 효과적이에요.
:::