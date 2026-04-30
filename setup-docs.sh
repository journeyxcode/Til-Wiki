#!/bin/bash

write_file() {
  mkdir -p "$(dirname "$1")"
  cat > "$1"
}

# ── intro.md ──────────────────────────────────────────
write_file "docs/intro.md" << 'EOF'
---
id: intro
title: 소개
slug: /
---

# Til-Wiki

AI 엔지니어링 기술과 실무 경험을 정리한 기술 문서 공간입니다.

8년간의 Android 개발 경험을 바탕으로 AI 엔지니어로 전환하며
학습한 내용과 프로젝트 경험을 체계적으로 기록합니다.

## 다루는 내용

| 카테고리 | 내용 |
|----------|------|
| AI 기본기 | ML, DL, NLP, LLM, RAG, Agent |
| Ops | MLOps, LLMOps, AIOps |
| 프로젝트 | 부트캠프 & 개인 프로젝트 |
| 소식 & 논문 | AI, 모바일 트렌드, 논문 리뷰 |
| 백엔드 | FastAPI, DB, API 설계 |
| TIL | 알고리즘, 도구, 일일 학습 |

## 기술 스택

| 분야 | 기술 |
|------|------|
| LLM & RAG | LangChain, LangGraph, Qdrant, BGE-M3 |
| MLOps | Docker, FastAPI, AWS, W&B |
| Language | Python, Kotlin |
EOF

# ── 01-fundamentals ───────────────────────────────────
write_file "docs/01-fundamentals/index.md" << 'EOF'
---
title: AI 기본기
---
# AI 기본기
AI 엔지니어링의 핵심 개념과 기술을 정리한 공간입니다.
## 구성
| 섹션 | 내용 |
|------|------|
| 수학 & 통계 | 선형대수, 확률, 통계 |
| 머신러닝 | 주요 알고리즘, 모델 평가 |
| 딥러닝 | CNN, RNN, Transformer |
| NLP | 텍스트 처리, 임베딩 |
| LLM | 대규모 언어 모델, 프롬프팅, LangChain |
| Agent | LangGraph, 멀티에이전트 |
| RAG | 검색 증강 생성, 벡터 DB |
| Ops | MLOps, LLMOps, AIOps |
EOF

write_file "docs/01-fundamentals/math-stats/index.md" << 'EOF'
---
title: 수학 & 통계
---
# 수학 & 통계
AI/ML의 이론적 기반이 되는 수학과 통계를 정리합니다.
## 다루는 내용
- **선형대수** — 벡터, 행렬 연산, 고유값 분해
- **미적분** — 경사하강법, 역전파 이해
- **확률론** — 확률 분포, 베이즈 정리
- **통계** — 가설 검정, 회귀 분석, 모델 평가 지표
EOF

write_file "docs/01-fundamentals/ml/index.md" << 'EOF'
---
title: 머신러닝
---
# 머신러닝
주요 머신러닝 알고리즘과 실전 적용 방법을 정리합니다.
## 다루는 내용
- **지도학습** — 회귀, 분류, 앙상블
- **비지도학습** — 클러스터링, 차원 축소
- **모델 평가** — 교차 검증, 지표 해석
- **Feature Engineering** — 전처리, 특성 선택
## 주요 도구
| 도구 | 용도 |
|------|------|
| Scikit-learn | 머신러닝 모델 |
| Pandas | 데이터 처리 |
| Matplotlib | 시각화 |
EOF

write_file "docs/01-fundamentals/dl/index.md" << 'EOF'
---
title: 딥러닝
---
# 딥러닝
딥러닝 아키텍처와 학습 방법론을 정리합니다.
## 다루는 내용
- **신경망 기초** — 퍼셉트론, 활성화 함수, 역전파
- **CNN** — 이미지 분류, 객체 탐지
- **RNN / LSTM** — 시퀀스 모델링
- **Transformer** — Attention 메커니즘, BERT, GPT
## 주요 도구
| 도구 | 용도 |
|------|------|
| PyTorch | 모델 구현 |
| HuggingFace | 사전학습 모델 |
| W&B | 실험 추적 |
EOF

write_file "docs/01-fundamentals/nlp/index.md" << 'EOF'
---
title: NLP
---
# NLP (자연어 처리)
텍스트 데이터 처리와 언어 모델 활용을 정리합니다.
## 다루는 내용
- **텍스트 전처리** — 토크나이징, 정규화, 불용어 처리
- **임베딩** — Word2Vec, FastText, Sentence Transformer
- **한국어 NLP** — KoBART, KR-SBERT, BGE-M3
- **태스크** — 분류, 요약, 감성 분석, NER
## 주요 도구
| 도구 | 용도 |
|------|------|
| HuggingFace | 사전학습 모델 |
| KoNLPy | 한국어 형태소 분석 |
| BGE-M3 | 다국어 임베딩 |
EOF

write_file "docs/01-fundamentals/llm/index.md" << 'EOF'
---
title: LLM
---
# LLM (대규모 언어 모델)
LLM의 개념, 활용, 프롬프트 엔지니어링을 정리합니다.
## 다루는 내용
- **LLM 개념** — GPT, Claude, Gemini 아키텍처 비교
- **프롬프트 엔지니어링** — Zero-shot, Few-shot, CoT
- **파인튜닝** — LoRA, QLoRA, RLHF
- **LangChain** — 체인 구성, 메모리, 툴 연동
## 주요 도구
| 도구 | 용도 |
|------|------|
| LangChain | LLM 프레임워크 |
| OpenAI API | GPT 모델 |
| Groq | 빠른 추론 |
| Google AI Studio | Gemini 모델 |
EOF

write_file "docs/01-fundamentals/agent/index.md" << 'EOF'
---
title: Agent
---
# AI Agent
자율적으로 작업을 수행하는 AI Agent 설계와 구현을 정리합니다.
## 다루는 내용
- **Agent 개념** — ReAct, Plan-and-Execute 패턴
- **LangGraph** — 상태 기반 워크플로우, 멀티에이전트
- **Tool Use** — 외부 API 연동, 함수 호출
- **멀티에이전트** — 에이전트 간 협업 구조
## 주요 도구
| 도구 | 용도 |
|------|------|
| LangGraph | 에이전트 워크플로우 |
| LangChain | 도구 & 체인 |
EOF

write_file "docs/01-fundamentals/rag/index.md" << 'EOF'
---
title: RAG
---
# RAG (검색 증강 생성)
Retrieval-Augmented Generation 개념과 실제 구현 방법을 정리합니다.
## 다루는 내용
- **RAG 파이프라인** — 문서 로딩, 청킹, 임베딩, 검색, 생성
- **벡터 DB** — Qdrant, ChromaDB, Pinecone 비교
- **검색 전략** — Dense, Sparse, Hybrid 검색
- **고급 RAG** — Re-ranking, HyDE, Query Rewriting
## 기술 스택
| 기술 | 용도 |
|------|------|
| Qdrant | 벡터 저장소 |
| BGE-M3 | 임베딩 모델 |
| bge-reranker | 리랭킹 |
| LangChain | RAG 파이프라인 |
EOF

write_file "docs/01-fundamentals/ops/index.md" << 'EOF'
---
title: Ops
---
# Ops
AI 서비스의 개발, 배포, 운영에 필요한 Ops 기술을 정리합니다.
## 구성
| 섹션 | 내용 |
|------|------|
| MLOps | 모델 배포, 파이프라인 자동화, 클라우드 |
| LLMOps | LLM 평가, 프롬프트 관리, 모니터링 |
| AIOps | AI 기반 운영 자동화, 장애 감지 |
EOF

write_file "docs/01-fundamentals/ops/mlops/index.md" << 'EOF'
---
title: MLOps
---
# MLOps
머신러닝 모델의 개발부터 배포, 운영까지의 파이프라인을 정리합니다.
## 다루는 내용
- **컨테이너화** — Docker, Docker Compose
- **실험 관리** — W&B, MLflow
- **파이프라인** — Airflow, Prefect
- **클라우드** — AWS S3, EC2, SageMaker
- **데이터 플랫폼** — Databricks
## 기술 스택
| 기술 | 용도 |
|------|------|
| Docker | 컨테이너화 |
| W&B | 실험 추적 |
| Airflow | 워크플로우 자동화 |
| AWS | 클라우드 인프라 |
| Databricks | 데이터 플랫폼 |
EOF

write_file "docs/01-fundamentals/ops/llmops/index.md" << 'EOF'
---
title: LLMOps
---
# LLMOps
LLM 서비스의 품질 관리와 운영 방법을 정리합니다.
## 다루는 내용
- **LLM 평가** — 자동 평가, 사람 평가, RAG 평가
- **프롬프트 관리** — 버전 관리, A/B 테스트
- **모니터링** — LangSmith, 비용 추적
- **파인튜닝 파이프라인** — 데이터 준비, 학습, 배포
## 기술 스택
| 기술 | 용도 |
|------|------|
| LangSmith | LLM 모니터링 |
| RAGAS | RAG 평가 |
EOF

write_file "docs/01-fundamentals/ops/aiops/index.md" << 'EOF'
---
title: AIOps
---
# AIOps
AI를 활용한 IT 운영 자동화와 모니터링을 정리합니다.
## 다루는 내용
- **이상 탐지** — 로그 분석, 장애 예측
- **자동화** — 알림, 자동 복구
- **모니터링** — 대시보드, 지표 수집
EOF

# ── 02-projects ───────────────────────────────────────
write_file "docs/02-projects/index.md" << 'EOF'
---
title: 프로젝트
---
# 프로젝트
부트캠프와 개인 프로젝트를 통해 구현한 AI 서비스를 정리합니다.
## 구성
| 섹션 | 내용 |
|------|------|
| 부트캠프 | AI 부트캠프 팀 프로젝트 |
| 개인 프로젝트 | 직접 기획하고 개발한 서비스 |
EOF

write_file "docs/02-projects/bootcamp/index.md" << 'EOF'
---
title: 부트캠프 프로젝트
---
# 부트캠프 프로젝트
AI 부트캠프에서 진행한 팀 프로젝트를 정리합니다.
## 프로젝트 목록
| 프로젝트 | 기술 스택 | 성과 |
|----------|-----------|------|
| 여행 챗봇 | Qdrant, BGE-M3, GPT-4o-mini, LangChain ReAct | - |
| IR 경진대회 | BM25, BGE-M3, bge-reranker, GPT-4o-mini | MAP 0.7977 |
| 문서 이미지 분류 | EfficientNet-B5, Augraphy, K-fold | - |
| 한국어 대화 요약 | KoBART, Solar API, KMeans | - |
EOF

write_file "docs/02-projects/personal/index.md" << 'EOF'
---
title: 개인 프로젝트
---
# 개인 프로젝트
직접 기획하고 개발한 AI 서비스를 정리합니다.
## 프로젝트 목록
| 프로젝트 | 설명 | 기술 스택 |
|----------|------|-----------|
| MediAsk | RAG 기반 의약품 정보 챗봇 | Qdrant, LangChain, FastAPI |
EOF

# ── 03-news-papers ────────────────────────────────────
write_file "docs/03-news-papers/index.md" << 'EOF'
---
title: 소식 & 논문
---
# 소식 & 논문
AI, 모바일 분야의 최신 트렌드와 논문 리뷰를 공유합니다.
## 구성
| 섹션 | 내용 |
|------|------|
| AI 소식 | AI 업계 주요 뉴스, 모델 출시 |
| 모바일 소식 | Android, 온디바이스 AI 트렌드 |
| 논문 리뷰 | 주요 AI 논문 요약 및 분석 |
EOF

write_file "docs/03-news-papers/ai/index.md" << 'EOF'
---
title: AI 소식
---
# AI 소식
AI 업계의 주요 뉴스와 모델 출시 소식을 정리합니다.
## 다루는 내용
- 주요 LLM 모델 업데이트 및 비교
- AI 기업 동향
- 새로운 기술 트렌드
EOF

write_file "docs/03-news-papers/mobile/index.md" << 'EOF'
---
title: 모바일 소식
---
# 모바일 소식
Android 및 온디바이스 AI 관련 최신 소식을 정리합니다.
## 다루는 내용
- Android 플랫폼 업데이트
- 온디바이스 AI (Gemini Nano, MediaPipe)
- 모바일 AI 서비스 트렌드
EOF

write_file "docs/03-news-papers/papers/index.md" << 'EOF'
---
title: 논문 리뷰
---
# 논문 리뷰
AI 분야 주요 논문을 읽고 핵심 내용을 정리합니다.
## 리뷰 형식
- **문제 정의** — 논문이 해결하려는 문제
- **방법론** — 핵심 아이디어와 구조
- **실험 결과** — 주요 성능 지표
- **활용 포인트** — 실무 적용 가능성
EOF

# ── 04-til ────────────────────────────────────────────
write_file "docs/04-til/index.md" << 'EOF'
---
title: TIL
---
# TIL (Today I Learned)
개발하면서 배운 개념, 도구 사용법, 알고리즘을 짧고 명확하게 정리합니다.
## 구성
| 섹션 | 내용 |
|------|------|
| 알고리즘 | 코딩 테스트, 자료구조, 풀이 패턴 |
| 도구 | Git, Docker, Linux, IDE 팁 |
| 일일 기록 | 그날 배운 핵심 내용 |
EOF

write_file "docs/04-til/algorithm/index.md" << 'EOF'
---
title: 알고리즘
---
# 알고리즘
코딩 테스트 준비와 자료구조/알고리즘 개념을 정리합니다.
## 다루는 내용
- **자료구조** — 스택, 큐, 트리, 그래프
- **탐색** — BFS, DFS, 이진 탐색
- **정렬** — 병합 정렬, 퀵 정렬
- **패턴** — 투 포인터, 슬라이딩 윈도우, Parametric Search
EOF

write_file "docs/04-til/tools/index.md" << 'EOF'
---
title: 도구
---
# 개발 도구
자주 쓰는 개발 도구의 사용법과 팁을 정리합니다.
## 다루는 내용
- **Git** — 브랜치 전략, 충돌 해결, 컨벤션
- **Linux** — 자주 쓰는 명령어, 쉘 스크립트
- **Docker** — 이미지 빌드, 컨테이너 관리
- **IDE** — VSCode, PyCharm 단축키 & 플러그인
EOF

write_file "docs/04-til/daily/index.md" << 'EOF'
---
title: 일일 기록
---
# 일일 기록
날짜별로 배운 내용을 짧게 기록합니다.
## 작성 형식
\`\`\`
## 날짜
### 배운 것
- 핵심 내용
### 참고 자료
- 링크
\`\`\`
EOF

# ── 05-etc ────────────────────────────────────────────
write_file "docs/05-etc/index.md" << 'EOF'
---
title: 기타
---
# 기타
도서 리뷰, 강의 정리, 면접 준비 자료를 모아둔 공간입니다.
## 구성
| 섹션 | 내용 |
|------|------|
| 도서 리뷰 | AI 관련 도서 핵심 내용 정리 |
| 강의 정리 | 수강한 강의 핵심 내용 |
| 면접 준비 | AI 엔지니어 면접 QnA |
EOF

write_file "docs/05-etc/books/index.md" << 'EOF'
---
title: 도서 리뷰
---
# 도서 리뷰
AI 엔지니어링 관련 도서의 핵심 내용을 정리합니다.
## 리뷰 형식
- **핵심 개념** — 책의 주요 아이디어
- **실무 적용** — 실제 활용 포인트
- **추천 대상** — 어떤 사람에게 유용한지
EOF

write_file "docs/05-etc/interview/index.md" << 'EOF'
---
title: 면접 준비
---
# 면접 준비
AI 엔지니어 포지션 면접에서 자주 나오는 질문과 답변을 정리합니다.
## 다루는 내용
- **ML 기초** — 모델, 학습, 평가 관련 질문
- **LLM & RAG** — 구조, 최적화, 트레이드오프
- **시스템 설계** — AI 서비스 아키텍처
- **코딩** — Python, 자료구조 관련
EOF

write_file "docs/05-etc/lectures/index.md" << 'EOF'
---
title: 강의 정리
---
# 강의 정리
수강한 강의의 핵심 내용을 정리합니다.
## 정리 형식
- **강의 개요** — 다루는 기술과 난이도
- **핵심 내용** — 챕터별 주요 개념
- **실습 코드** — 주요 예제 코드
EOF

# ── 06-backend ────────────────────────────────────────
write_file "docs/06-backend/index.md" << 'EOF'
---
title: 백엔드
---
# 백엔드
AI 서비스 개발에 필요한 백엔드 기술을 정리합니다.
## 구성
| 섹션 | 내용 |
|------|------|
| FastAPI | REST API 설계 및 구현 |
| 데이터베이스 | SQL, NoSQL, 벡터 DB |
| API 설계 | RESTful 설계 원칙, 인증 |
EOF

write_file "docs/06-backend/fastapi/index.md" << 'EOF'
---
title: FastAPI
---
# FastAPI
Python 기반 고성능 API 프레임워크 FastAPI를 정리합니다.
## 다루는 내용
- **기본 구조** — 라우터, 의존성 주입, 미들웨어
- **데이터 검증** — Pydantic 모델
- **인증** — JWT, OAuth2
- **배포** — Docker, Uvicorn
## 기술 스택
| 기술 | 용도 |
|------|------|
| FastAPI | API 프레임워크 |
| Pydantic | 데이터 검증 |
| SQLAlchemy | ORM |
| Docker | 컨테이너화 |
EOF

write_file "docs/06-backend/database/index.md" << 'EOF'
---
title: 데이터베이스
---
# 데이터베이스
AI 서비스에서 활용하는 다양한 데이터베이스를 정리합니다.
## 다루는 내용
- **관계형 DB** — MySQL, PostgreSQL
- **NoSQL** — MongoDB, Redis
- **벡터 DB** — Qdrant, ChromaDB, Pinecone
- **검색 엔진** — Elasticsearch
## 벡터 DB 비교
| DB | 장점 | 특징 |
|----|------|------|
| Qdrant | 빠른 속도, Rust 기반 | 클라우드 지원 |
| ChromaDB | 간단한 설정 | 로컬 개발 적합 |
| Pinecone | 완전 관리형 | 서버리스 |
EOF

write_file "docs/06-backend/api-design/index.md" << 'EOF'
---
title: API 설계
---
# API 설계
확장 가능하고 유지보수하기 쉬운 API 설계 원칙을 정리합니다.
## 다루는 내용
- **RESTful 설계** — 리소스 구조, HTTP 메서드
- **인증 & 보안** — JWT, API Key, OAuth2
- **에러 처리** — 상태 코드, 에러 응답 형식
- **문서화** — Swagger, OpenAPI
EOF

echo "✅ 완료! 총 $(find docs -name 'index.md' | wc -l)개 파일 생성됨"
