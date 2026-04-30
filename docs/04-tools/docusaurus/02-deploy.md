---
title: GitHub Pages 배포
sidebar_position: 3
---

# GitHub Pages 배포

## GitHub 레포지토리 생성

1. GitHub에서 새 레포지토리 생성
2. **Public** 으로 설정 (GitHub Pages 무료 사용 조건)
3. README 파일 생성 여부 — 체크해도 무방

## 로컬 프로젝트와 연결

```bash
git init
git add .
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/username/repo-name.git
git push -u origin main
```

:::caution
레포 생성 시 README를 자동 생성했다면 push 전에 pull이 필요해요:
```bash
git config pull.rebase false
git pull origin main --allow-unrelated-histories
git push -u origin main
```
:::

## GitHub Actions 설정

`.github/workflows/deploy.yml` 파일을 만들어요:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches:
      - main

jobs:
  deploy:
    name: Deploy to GitHub Pages
    runs-on: ubuntu-latest
    permissions:
      contents: write
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: npm

      - name: Install dependencies
        run: npm ci

      - name: Build website
        run: npm run build

      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./build
```

```bash
git add .
git commit -m "add github actions deploy workflow"
git push
```

## GitHub Pages 설정

1. GitHub 레포 → **Settings** → **Pages**
2. Branch를 `gh-pages` → `/ (root)` 로 변경
3. **Save** 클릭

:::info
`gh-pages` 브랜치는 GitHub Actions가 처음 실행된 후 자동으로 생성돼요.
:::

## 배포 확인

```
https://username.github.io/repo-name/
```

Actions 탭에서 배포 진행 상황을 확인할 수 있어요:
- ✅ 초록색 — 성공
- ⏳ 노란색 — 진행 중
- ❌ 빨간색 — 실패 (로그 확인 필요)

## 자동 배포 흐름

```
로컬에서 파일 수정
    ↓
git push
    ↓
GitHub Actions 자동 실행 (1~2분)
    ↓
사이트 자동 반영
```