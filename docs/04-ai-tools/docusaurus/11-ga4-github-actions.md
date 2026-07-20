# GA4 방문자 카운터 자동화 및 Footer 적용

:::note 
작성 배경
10번 문서의 삽질에 이어, 자동화까지 완성하는 데 또 한 번의 시행착오가 있었습니다.
누군가에게는 이 문서가 지름길이 되길 바랍니다. 🐱
:::

이전 문서에서 GA4 설정과 토큰 발급을 완료했다면,
이 문서에서는 GitHub Actions 자동화와 Docusaurus Footer 컴포넌트 적용 방법을 설명합니다.

:::info 
어제 방문자를 표시하는 이유
GA4는 데이터 처리에 24~48시간 지연이 있습니다.
오늘 방문자를 표시하면 하루 종일 0으로 표시되는 문제가 있어,
**어제 방문자**를 표시하는 방식으로 구현합니다.
:::

## 전체 흐름

```
fetch_ga4_stats.py 작성
    ↓
VisitorCount 컴포넌트 생성
    ↓
Footer Swizzle
    ↓
GitHub Actions 워크플로우 설정
    ↓
커밋 & 배포
```

---

## 1단계 — GA4 데이터 가져오기 스크립트

`scripts/fetch_ga4_stats.py` 파일 생성:

```python
import json
import os
import datetime
from google.analytics.data_v1beta import BetaAnalyticsDataClient
from google.analytics.data_v1beta.types import DateRange, Metric, RunReportRequest
from google.oauth2.credentials import Credentials
from google.auth.transport.requests import Request

# token.json에서 인증 정보 로드
with open('secrets/token.json', 'r') as f:
    token_data = json.load(f)

creds = Credentials(
    token=token_data['token'],
    refresh_token=token_data['refresh_token'],
    token_uri=token_data['token_uri'],
    client_id=token_data['client_id'],
    client_secret=token_data['client_secret'],
    scopes=token_data['scopes']
)

# 토큰 강제 갱신
try:
    creds.refresh(Request())
except Exception as e:
    print(f"토큰 갱신 실패: {e}")
    raise

client = BetaAnalyticsDataClient(credentials=creds)

# GA4 속성 ID (Google Analytics → 관리 → 속성 설정에서 확인)
property_id = "123456789"  # 실제 속성 ID로 변경

# 어제 방문자
yesterday_response = client.run_report(RunReportRequest(
    property=f"properties/{property_id}",
    date_ranges=[DateRange(start_date="yesterday", end_date="yesterday")],
    metrics=[Metric(name="activeUsers")]
))

# 전체 방문자 (사이트 오픈일부터)
total_response = client.run_report(RunReportRequest(
    property=f"properties/{property_id}",
    date_ranges=[DateRange(start_date="2026-01-01", end_date="today")],  # 실제 오픈일로 변경
    metrics=[Metric(name="totalUsers")]
))

yesterday = int(yesterday_response.rows[0].metric_values[0].value) if yesterday_response.rows else 0
total = int(total_response.rows[0].metric_values[0].value) if total_response.rows else 0

result = {
    "yesterday": yesterday,
    "total": total,
    "updated_at": datetime.date.today().isoformat()
}

# static 폴더에 저장 (로컬/GitHub Actions 환경 자동 감지)
static_dir = '../static' if os.path.exists('../static') else 'static'
os.makedirs(static_dir, exist_ok=True)
with open(f'{static_dir}/visitor_count.json', 'w') as f:
    json.dump(result, f)

print(f"완료: {result}")
```

### 로컬 테스트

```bash
cd scripts
python fetch_ga4_stats.py
# 완료: {'yesterday': 1, 'total': 3, 'updated_at': '2026-01-01'}
```

`static/visitor_count.json`이 생성되면 성공입니다.

---

## 2단계 — VisitorCount 컴포넌트 생성

`src/components/VisitorCount.jsx` 파일 생성:

```jsx
import React, { useEffect, useState } from 'react';
import useBaseUrl from '@docusaurus/useBaseUrl';

export default function VisitorCount() {
  const [stats, setStats] = useState(null);
  const jsonUrl = useBaseUrl('/visitor_count.json');

  useEffect(() => {
    fetch(jsonUrl)
      .then(res => res.json())
      .then(data => setStats(data))
      .catch(() => {});
  }, [jsonUrl]);

  if (!stats) return null;

  return (
    <div style={{
      textAlign: 'center',
      fontSize: '0.9rem',
      color: 'var(--ifm-color-emphasis-500)',
      padding: '0 0 12px',
      marginTop: '-16px',
    }}>
      👁 어제 방문자: <strong>{stats.yesterday.toLocaleString()}</strong>
      &nbsp;|&nbsp;
      👥 총 방문자: <strong>{stats.total.toLocaleString()}</strong>
    </div>
  );
}
```

:::info 
useBaseUrl 사용 이유
`useBaseUrl`을 사용하면 `docusaurus.config.js`의 `baseUrl` 값을 자동으로 읽어옵니다.
`baseUrl`이 변경되어도 컴포넌트 코드를 수정할 필요가 없습니다.
:::

---

## 3단계 — Footer Swizzle

```bash
npm run swizzle @docusaurus/theme-classic Footer -- --wrap
```

생성된 `src/theme/Footer/index.js` 수정:

```jsx
import React from 'react';
import Footer from '@theme-original/Footer';
import VisitorCount from '@site/src/components/VisitorCount';

export default function FooterWrapper(props) {
  return (
    <>
      <Footer {...props} />
      <VisitorCount />
    </>
  );
}
```

---

## 4단계 — GitHub Actions 워크플로우 설정

`.github/workflows/deploy.yml` 수정:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches:
      - main
  schedule:
    - cron: '0 15 * * *'  # 매일 자정 KST (UTC 15시)

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

      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'

      - name: Install Python packages
        run: pip install google-analytics-data google-auth-oauthlib

      - name: Write secrets to files
        env:
          GA4_TOKEN: ${{ secrets.GA4_TOKEN }}
          GA4_CLIENT_SECRET: ${{ secrets.GA4_CLIENT_SECRET }}
        run: |
          mkdir -p scripts/secrets
          python3 -c "import os; open('scripts/secrets/token.json','w').write(os.environ['GA4_TOKEN'])"
          python3 -c "import os; open('scripts/secrets/client_secret.json','w').write(os.environ['GA4_CLIENT_SECRET'])"

      - name: Fetch GA4 Stats
        run: |
          cd scripts
          python fetch_ga4_stats.py

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

:::info 
자동 갱신
`schedule` 설정으로 매일 자정(KST)에 자동으로 GA4 데이터를 갱신합니다.
`main` 브랜치에 push할 때도 함께 갱신됩니다.
:::

---

## 5단계 — 커밋 & 배포

```bash
git add .
git commit -m "feat: GA4 방문자 카운터 추가"
git push origin main
```

---

## 결과 확인

배포 완료 후 사이트 Footer 하단에 방문자 수가 표시됩니다:

```
Copyright © 2026 AI LOG · Made by yourname
👁 어제 방문자: 1 | 👥 총 방문자: 3
```

---

## 트러블슈팅

| 문제 | 원인 | 해결 |
|---|---|---|
| Footer에 숫자가 안 보임 | `visitor_count.json` 경로 오류 | `baseUrl` 확인 후 `useBaseUrl` 사용 |
| JSON 파싱 오류 | secrets 파일 쓰기 오류 | Python으로 파일 쓰기 방식 사용 |
| 어제 방문자가 항상 0 | GA4 데이터 지연 | 정상 (24~48시간 지연) |
| 토큰 만료 오류 | refresh_token 미설정 | `get_token.py` 재실행 후 Secrets 재등록 |