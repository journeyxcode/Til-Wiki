# 🐱 AI LOG

![Deploy](https://github.com/journeyxcode/ailog/actions/workflows/deploy.yml/badge.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/journeyxcode/ailog)
![Docusaurus](https://img.shields.io/badge/Docusaurus-3ECC5F?logo=docusaurus&logoColor=fff)
![GitHub Pages](https://img.shields.io/badge/GitHub_Pages-121013?logo=github&logoColor=white)

> Android 개발자가 AI 엔지니어로 전환하는 여정을 기록한 기술 문서 블로그

🔗 **[ailog 바로가기](https://journeyxcode.github.io/ailog/)**

---

## 📖 소개

AI LOG는 [Docusaurus](https://docusaurus.io/) 기반의 기술 문서 사이트입니다.

Android 개발 경력을 바탕으로 AI 엔지니어로 전환하며 학습한 내용,
프로젝트 경험, AI 최신 소식을 체계적으로 정리합니다.

---

## 🗂️ 다루는 내용

| 카테고리 | 내용 |
|----------|------|
| 🤖 AI 기본기 | 수학/통계, ML, DL, NLP, LLM, Agent, RAG, Ops |
| 📰 소식 & 논문 | AI 뉴스, 모바일 트렌드, 논문 리뷰 |
| 🖥️ 백엔드 | FastAPI, 데이터베이스, API 설계 |
| 🛠️ 도구 | AI 도구, 개발 환경, Git |
| 💼 프로젝트 | 부트캠프 & 개인 프로젝트 |
| 📚 기타 | 도서 리뷰, 강의 정리, 면접 준비 |

---

## 🛠️ 기술 스택

### 이 사이트를 만든 기술

| 분야 | 기술 |
|------|------|
| 문서 프레임워크 | Docusaurus 3.x |
| 배포 | GitHub Pages + GitHub Actions |

### 블로그에서 다루는 기술

이 블로그에서 학습하고 정리하는 기술 스택입니다.

| 분야 | 기술 |
|------|------|
| LLM & RAG | LangChain, LangGraph, Qdrant, BGE-M3 |
| MLOps | Docker, FastAPI, AWS, W&B |
| Language | Python, Kotlin |

---

## ⚙️ 로컬 실행

```bash
# 의존성 설치
npm install

# 로컬 서버 실행
npm start
# → http://localhost:3000/ailog/

# 빌드
npm run build
```

---

## 🚀 배포

`main` 브랜치에 push하면 GitHub Actions가 자동으로 빌드 & 배포해요.

```
main 브랜치 push
    ↓
GitHub Actions 실행
    ↓
gh-pages 브랜치 자동 배포
    ↓
https://journeyxcode.github.io/ailog/
```

배포 워크플로우: [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml)

---

## 📁 프로젝트 구조

```
ailog/
├── blog/                   # 블로그 포스트
├── docs/                   # 기술 문서
│   ├── 01-fundamentals/    # AI 기본기
│   ├── 02-news-papers/     # 소식 & 논문
│   ├── 03-backend/         # 백엔드
│   ├── 04-tools/           # 도구
│   ├── 05-projects/        # 프로젝트
│   └── 06-etc/             # 기타
├── src/
│   ├── css/custom.css      # 테마 커스터마이징
│   └── pages/              # 홈페이지
├── static/                 # 정적 파일 (이미지 등)
└── docusaurus.config.js    # 사이트 설정
```

---

> 🐱 **Happy Coding!**