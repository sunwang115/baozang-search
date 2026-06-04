import requests
import json

url = 'http://47.113.216.40:5004/api?keyword=周杰伦'
try:
    resp = requests.get(url, timeout=30)
    print(f'Status: {resp.status_code}')
    data = resp.json()
    print(f'Total results: {len(data.get("results", []))}')
    for i, item in enumerate(data.get('results', [])[:10]):
        print(f'{i+1}. {item.get("name", "")}')
except Exception as e:
    print(f'Error: {e}')
