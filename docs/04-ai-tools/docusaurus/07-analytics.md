---
title: Google Analytics
sidebar_position: 7
---

# Google Analytics

Google Analytics를 연동하면 사이트 방문자 수, 페이지별 조회수, 유입 경로 등을 확인할 수 있어요.

## 측정 ID 발급

```
https://analytics.google.com
```

1. **측정 시작** 클릭
2. 계정 이름 입력
3. 속성 이름 입력 (사이트 이름)
4. 시간대 → **대한민국**, 통화 → **원**
5. 플랫폼 → **웹** 선택
6. 웹사이트 URL 입력
7. 완료 후 **측정 ID** 복사

```
G-XXXXXXXXXX  ← 이 형태의 값
```

## docusaurus.config.js 설정

```javascript
presets: [
  [
    'classic',
    {
      // ...
      gtag: {
        trackingID: 'G-XXXXXXXXXX',  // ← 측정 ID 입력
        anonymizeIP: true,            // ← IP 익명화 (개인정보 보호)
      },
    },
  ],
],
```

:::info
`G-XXXXXXXXXX` 형태의 측정 ID는 공개해도 안전해요.
읽기 전용이라 데이터 수집만 가능하고 수정/삭제는 불가능해요.
:::

## 작동 확인

### 실시간 확인
1. 배포 후 사이트 접속
2. Google Analytics → **보고서** → **실시간**
3. 활성 사용자가 표시되면 성공

### 주의사항

```
로컬(localhost) → 데이터가 잘 안 잡힐 수 있음
배포된 사이트   → 정확하게 수집됨
```

데이터 수집까지 **24~48시간** 정도 소요돼요.

## 확인 가능한 데이터

| 항목 | 내용 |
|------|------|
| 실시간 | 현재 접속자 수 |
| 페이지 | 페이지별 조회수, 체류 시간 |
| 유입 | 검색, 직접, 소셜 등 유입 경로 |
| 사용자 | 신규/재방문, 지역, 기기 정보 |