---
title: 삽질 & 팁 모음
sidebar_position: 6
---

# 삽질 & 팁 모음

직접 겪은 오류와 해결 방법을 정리했어요.

## 오류 모음

### intro 중복 오류

```
Error: The docs plugin found docs sharing the same id: `intro`
```

**원인** — `intro.md` 와 `intro.mdx` 가 동시에 존재할 때 발생해요.

**해결**
```bash
rm docs/intro.mdx  # 둘 중 하나 삭제
```

---

### Broken Links 오류

```
Error: Docusaurus found broken links!
```

**원인** — 존재하지 않는 페이지로 연결되는 링크가 있을 때 발생해요.

**해결** — `docusaurus.config.js` 에서 경고로 변경:
```javascript
onBrokenLinks: 'warn',
onBrokenMarkdownLinks: 'warn',
```

---

### GitHub Actions 배포 실패 (Node 버전)

```
Process completed with exit code 1.
Node.js 20 actions are deprecated.
```

**해결** — `deploy.yml` 에서 Node 버전 변경:
```yaml
- uses: actions/setup-node@v4
  with:
    node-version: 20   # 18 → 20
```

---

### MDX 주석 오류

```
Error: Unexpected character `!` (U+0021) before name
```

**원인** — MDX 파일에서 HTML 주석을 사용했을 때 발생해요.

**해결** — HTML 주석 → JSX 주석으로 변경:
```
❌ <!-- truncate -->
✅ {/* truncate */}
```

---

### Docusaurus 버전 불일치

```
Error: Invalid version number. All official @docusaurus/* packages
should have the exact same version.
```

**해결**
```bash
npm i @docusaurus/core@latest @docusaurus/preset-classic@latest
```

---

### push 충돌 (non-fast-forward)

```
error: failed to push some refs
hint: Updates were rejected because the tip of your current branch is behind
```

**원인** — 레포 생성 시 README 자동 생성으로 인한 충돌

**해결**
```bash
git config pull.rebase false
git pull origin main --allow-unrelated-histories
git push -u origin main
```

---

## 팁 모음

### 로컬 서버 포트 변경

기본 포트(3000)가 사용 중일 때:
```bash
npm start -- --port 3001
```

### 빌드 전 로컬 확인

배포 전 빌드 결과를 로컬에서 확인:
```bash
npm run build
npm run serve
```

### 문서 파일 frontmatter 기본 형식

```markdown
---
title: 문서 제목
sidebar_position: 1
description: SEO에 사용되는 설명
tags: [태그1, 태그2]
---
```

### 블로그 포스트 frontmatter 기본 형식

```markdown
---
title: 포스트 제목
date: 2026-01-01
authors: username
tags: [태그1, 태그2]
---

요약 내용 (블로그 목록에서 보임)

{/* truncate */}

본문 내용...
```

### authors.yml 설정

블로그 작성자 정보를 한 곳에서 관리:

```yaml
# blog/authors.yml
username:
  name: 표시할 이름
  url: https://github.com/username
  image_url: https://github.com/username.png
```