---
title: 검색 기능 (Algolia)
sidebar_position: 8
---

# 검색 기능 (Algolia)

Algolia DocSearch는 기술 문서 사이트에 무료로 제공하는 검색 서비스예요.
React, Vue, Docusaurus 공식 사이트도 Algolia를 사용해요.

## DocSearch 신청

### 신청 조건
- 공개된 기술 문서 사이트 ✅
- 오픈소스 또는 개인 기술 블로그 ✅
- 직접 관리하는 사이트 ✅

### 신청 방법

```
https://docsearch.algolia.com/apply/
```

| 항목 | 입력값 |
|------|--------|
| URL | https://username.github.io/repo/ |
| Repository | https://github.com/username/repo |
| Email | 본인 이메일 |

승인까지 **1~2주** 소요돼요.
승인 후 이메일로 아래 값을 받아요:

```
appId: XXXXXXXXXX
apiKey: XXXXXXXXXXXXXXXX
indexName: XXXXXXXXXX
```

## docusaurus.config.js 설정

```javascript
themeConfig: {
  algolia: {
    appId: 'XXXXXXXXXX',
    apiKey: 'XXXXXXXXXXXXXXXX',
    indexName: 'XXXXXXXXXX',
    contextualSearch: true,
  },
},
```

## 로컬 검색 플러그인 (Algolia 승인 전 대안)

Algolia 승인을 기다리는 동안 로컬 검색 플러그인을 사용할 수 있어요:

```bash
npm install @easyops-cn/docusaurus-search-local
```

`docusaurus.config.js` 에 추가:

```javascript
plugins: [
  [
    require.resolve('@easyops-cn/docusaurus-search-local'),
    {
      hashed: true,
      language: ['ko', 'en'],
      highlightSearchTermsOnTargetPage: true,
    },
  ],
],
```

:::tip
로컬 검색은 빌드된 사이트에서만 동작해요.
`npm start` 가 아닌 `npm run build && npm run serve` 로 확인해야 해요.
:::