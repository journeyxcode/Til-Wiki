import os
import json
from google_auth_oauthlib.flow import InstalledAppFlow

SCOPES = ['https://www.googleapis.com/auth/analytics.readonly']

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
CLIENT_SECRET_PATH = os.path.join(BASE_DIR, 'secrets', 'client_secret_928382858108-114isu2ktt6hl0ec81cktotsivik0894.apps.googleusercontent.com.json')
TOKEN_PATH = os.path.join(BASE_DIR, 'token.json')


flow = InstalledAppFlow.from_client_secrets_file(
    CLIENT_SECRET_PATH,
    SCOPES
)
creds = flow.run_local_server(port=0)

import json
token_data = {
    'token': creds.token,
    'refresh_token': creds.refresh_token,
    'token_uri': creds.token_uri,
    'client_id': creds.client_id,
    'client_secret': creds.client_secret,
    'scopes': list(creds.scopes)
}

with open(TOKEN_PATH, 'w') as f:
    json.dump(token_data, f)

print(f'완료! {TOKEN_PATH} 저장됨')