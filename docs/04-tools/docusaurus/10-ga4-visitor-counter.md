# GA4 방문자 카운터 설정하기

:::note 작성 배경
GA4 서비스 계정 UI 버그와 며칠간의 삽질 끝에 완성한 설정 가이드입니다.
같은 고생을 반복하지 않도록 기록해 둡니다. 😅
:::

Docusaurus 사이트에 Google Analytics 4(GA4) 방문자 수를 Footer에 표시하는 방법을 설명합니다.

## 전체 흐름

```
Google Cloud 프로젝트 생성
    ↓
API 활성화
    ↓
OAuth 클라이언트 ID 생성
    ↓
OAuth 동의 화면 설정
    ↓
토큰 발급 (최초 1회)
    ↓
GitHub Secrets 등록
```

---

## 사전 준비

- Google 계정
- GitHub 레포지토리
- Docusaurus 프로젝트
- Python 3.x 설치

:::caution 주의
Google Analytics와 Google Cloud Console은 **반드시 동일한 Google 계정**으로 로그인해야 합니다.
:::

---

## 1단계 — Google Cloud 프로젝트 생성

1. [Google Cloud Console](https://console.cloud.google.com) 접속
2. 상단 프로젝트 선택 드롭다운 → **새 프로젝트** 클릭
3. 프로젝트 이름 입력 후 **만들기** 클릭

---

## 2단계 — API 활성화

좌측 메뉴 → **API 및 서비스** → **라이브러리**에서 아래 두 가지를 검색 후 각각 **사용** 클릭:

- `Google Analytics Data API`
- `Google Analytics Admin API`

---

## 3단계 — OAuth 동의 화면 설정

1. 좌측 메뉴 → **API 및 서비스** → **OAuth 동의 화면**
2. User Type: **외부** 선택 → **만들기**
3. 아래 내용 입력:
   - 앱 이름: `your-app-name`
   - 사용자 지원 이메일: `your-email@gmail.com`
   - 개발자 연락처 이메일: `your-email@gmail.com`
4. **저장 후 계속** 클릭
5. **범위** 화면 → 그냥 **저장 후 계속**
6. **테스트 사용자** → **+ ADD USERS** → 본인 이메일 추가
7. **저장 후 계속** → **대시보드로 돌아가기**

:::info
동의 화면은 사이트 방문자와 무관합니다. 본인이 최초 1회 Google 계정 접근을 허용할 때만 표시됩니다.
:::

---

## 4단계 — OAuth 클라이언트 ID 생성

1. 좌측 메뉴 → **API 및 서비스** → **사용자 인증 정보**
2. **+ 사용자 인증 정보 만들기** → **OAuth 클라이언트 ID**
3. 애플리케이션 유형: **데스크톱 앱** 선택
4. 이름 입력 후 **만들기**
5. **JSON 다운로드** → `scripts/secrets/` 폴더에 저장

---

## 5단계 — 프로젝트 폴더 구조 설정

```
your-project/
  scripts/
    get_token.py
    fetch_ga4_stats.py
    secrets/               ← .gitignore에 등록 필수!
      client_secret_xxx.json
      token.json
```

### .gitignore 설정

```gitignore
# GA4 인증 정보 (절대 커밋 금지!)
scripts/secrets/
```

:::danger
`scripts/secrets/` 폴더가 GitHub에 올라가면 보안 사고입니다.
반드시 `.gitignore`에 추가 후 진행하세요.
:::

---

## 6단계 — 가상환경 설정 및 패키지 설치

```bash
# 프로젝트 루트에서 가상환경 생성
python3 -m venv ga4_env

# 가상환경 활성화
source ga4_env/bin/activate

# 패키지 설치
pip install google-analytics-data google-auth-oauthlib
```

---

## 7단계 — OAuth 토큰 발급 (최초 1회)

`scripts/get_token.py` 파일 생성:

```python
from google_auth_oauthlib.flow import InstalledAppFlow
import json

SCOPES = ['https://www.googleapis.com/auth/analytics.readonly']

flow = InstalledAppFlow.from_client_secrets_file(
    'secrets/client_secret_xxx.json',  # 실제 파일명으로 변경
    SCOPES
)

creds = flow.run_local_server(port=0)

token_data = {
    'token': creds.token,
    'refresh_token': creds.refresh_token,
    'token_uri': creds.token_uri,
    'client_id': creds.client_id,
    'client_secret': creds.client_secret,
    'scopes': list(creds.scopes)
}

with open('secrets/token.json', 'w') as f:
    json.dump(token_data, f)

print('완료! secrets/token.json 저장됨')
```

```bash
# scripts 폴더에서 실행
cd scripts
python get_token.py
```

실행하면 브라우저가 자동으로 열리며 Google 로그인 화면이 표시됩니다.
본인 계정으로 로그인 후 **허용** 클릭하면 `token.json`이 저장됩니다.

---

## 8단계 — GitHub Secrets 등록

1. GitHub 레포지토리 → **Settings** → **Secrets and variables** → **Actions**
2. 아래 두 가지 등록:

| Name | Value |
|---|---|
| `GA4_TOKEN` | `scripts/secrets/token.json` 파일 전체 내용 |
| `GA4_CLIENT_SECRET` | `scripts/secrets/client_secret_xxx.json` 파일 전체 내용 |

```bash
# 파일 내용 확인
cat scripts/secrets/token.json
cat scripts/secrets/client_secret_xxx.json
```

각 파일 내용을 복사해서 GitHub Secret Value에 붙여넣기 합니다.

---

## 다음 단계

GA4 설정이 완료되었습니다.
다음 문서에서 GitHub Actions 자동화 및 Docusaurus Footer 컴포넌트 적용 방법을 설명합니다.