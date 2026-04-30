---
title: 테마 커스터마이징
sidebar_position: 4
---

# 테마 커스터마이징

## 다크모드 기본값 설정

`docusaurus.config.js` 에서 설정해요:

```javascript
themeConfig: {
  colorMode: {
    defaultMode: 'dark',
    disableSwitch: false,
  },
}
```

## CSS 변수로 색상 변경

`src/css/custom.css` 에서 색상을 변경해요:

```css
/* 라이트 모드 */
:root {
  --ifm-color-primary: #2563eb;
  --ifm-font-family-base: 'Inter', -apple-system, sans-serif;
  --ifm-font-size-base: 15px;
}

/* 다크 모드 */
[data-theme='dark'] {
  --ifm-color-primary: #60a5fa;
  --ifm-background-color: #0f1117;
  --ifm-navbar-background-color: #0f1117;
}
```

:::tip
`--ifm-color-primary` 색상을 바꾸면 링크, 버튼, 강조 색상이 한 번에 바뀌어요.
:::

## 네비게이션바 설정

```javascript
navbar: {
  title: 'navbar title 쓰기',
  logo: {
    alt: 'Logo',
    src: 'img/logo.png',
  },
  items: [
    {
      type: 'docSidebar',
      sidebarId: 'tutorialSidebar',
      position: 'left',
      label: 'Docs',
    },
    { to: '/blog', label: 'Blog', position: 'left' },
    {
      href: 'https://github.com/username',
      label: 'GitHub',
      position: 'right',
    },
  ],
},
```

## 푸터 설정

```javascript
footer: {
  style: 'dark',
  copyright: `Copyright © ${new Date().getFullYear()} navbar title · Made by username ??`,
},
```

## 로고 & 파비콘 변경

1. 이미지 파일을 `static/img/` 폴더에 저장
2. `docusaurus.config.js` 에서 경로 지정

```javascript
const config = {
  favicon: 'img/favicon.png',
  ...
  navbar: {
    logo: {
      src: 'img/logo.png',
    },
  },
}
```

:::info
파비콘은 `.ico` 대신 `.png` 도 사용 가능해요.
:::

## 코드 하이라이팅 테마

```javascript
import {themes as prismThemes} from 'prism-react-renderer';

prism: {
  theme: prismThemes.github,        // 라이트 모드
  darkTheme: prismThemes.dracula,   // 다크 모드
},
```