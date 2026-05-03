from google_auth_oauthlib.flow import InstalledAppFlow

SCOPES = ['https://www.googleapis.com/auth/analytics.readonly']

flow = InstalledAppFlow.from_client_secrets_file(
    'secrets/client_secret_928382858108-114isu2ktt6hl0ec81cktotsivik0894.apps.googleusercontent.com.json',
    SCOPES
)

creds = flow.run_local_server(port=0)

# token.json 저장
import json
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