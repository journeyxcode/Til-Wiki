---
title: 개요
sidebar_position: 1
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
