import requests
import json

# 测试外部API
url = 'http://47.113.216.40:5004/api?keyword=周杰伦'
try:
    resp = requests.get(url, timeout=30)
    print(f'Status: {resp.status_code}')
    data = resp.json()
    
    print(f'Success: {data.get("success")}')
    print(f'Total: {data.get("total")}')
    
    if data.get('results'):
        print(f'Results count: {len(data["results"])}')
        print(f'\nFirst 3 results:')
        for i, item in enumerate(data['results'][:3]):
            print(f'  {i+1}. {item.get("name", "")}')
    else:
        print('No results')
except Exception as e:
    print(f'Error: {e}')
