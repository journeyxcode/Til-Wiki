import json
import os
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

# 토큰 만료 시 자동 갱신
if creds.expired and creds.refresh_token:
    creds.refresh(Request())

client = BetaAnalyticsDataClient(credentials=creds)

property_id = "535351340"

# 오늘 방문자
today_response = client.run_report(RunReportRequest(
    property=f"properties/{property_id}",
    date_ranges=[DateRange(start_date="today", end_date="today")],
    metrics=[Metric(name="activeUsers")]
))

# 전체 방문자
total_response = client.run_report(RunReportRequest(
    property=f"properties/{property_id}",
    date_ranges=[DateRange(start_date="2026-01-01", end_date="today")],
    metrics=[Metric(name="totalUsers")]
))

today = int(today_response.rows[0].metric_values[0].value) if today_response.rows else 0
total = int(total_response.rows[0].metric_values[0].value) if total_response.rows else 0

result = {
    "today": today,
    "total": total,
    "updated_at": __import__('datetime').date.today().isoformat()
}

# static 폴더에 저장 (로컬: ../static, GitHub Actions: static)
static_dir = '../static' if os.path.exists('../static') else 'static'
os.makedirs(static_dir, exist_ok=True)
with open(f'{static_dir}/visitor_count.json', 'w') as f:
    json.dump(result, f)

print(f"완료: {result}")