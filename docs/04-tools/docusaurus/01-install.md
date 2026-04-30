---
title: 설치 & 시작
sidebar_position: 2
---

# 설치 & 시작

## 사전 준비

Node.js v18 이상이 필요해요.

```bash
# 버전 확인
node -v   # v18 이상
npm -v
```

Node.js가 없다면 [nodejs.org](https://nodejs.org) 에서 LTS 버전을 설치해주세요.

## 프로젝트 생성

```bash
npx create-docusaurus@latest my-docs classic
```

- `my-docs` — 프로젝트 폴더명 (원하는 이름으로 변경 가능)
- `classic` — 기본 테마

설치 중 TypeScript 여부를 묻는데 **JavaScript**를 선택하면 더 간단해요.

## 로컬 실행

```bash
cd my-docs
npm start
```

브라우저에서 `http://localhost:3000` 으로 접속하면 기본 페이지가 보여요.

## 폴더 구조

```
my-docs/
├── blog/                 ← 블로그 포스트
├── docs/                 ← 문서 파일
├── src/
│   ├── css/
│   │   └── custom.css   ← 테마 커스터마이징
│   └── pages/
│       └── index.js     ← 홈페이지
├── static/
│   └── img/             ← 이미지, GIF 파일
└── docusaurus.config.js ← 사이트 전체 설정
```

## 기본 설정

`docusaurus.config.js` 에서 사이트 기본 정보를 변경해요:

```javascript
const config = {
  title: 'title 쓰기',
  tagline: 'tagline 쓰기',
  url: 'https://username.github.io',
  baseUrl: '/repo-name/',
  organizationName: 'username',
  projectName: 'repo-name',
  favicon: 'img/favicon.ico',
}
```

:::tip
`url` 과 `baseUrl` 은 GitHub Pages 배포 주소와 일치해야 해요.
:::