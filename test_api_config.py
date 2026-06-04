import requests
import json

# 测试外部API的原始响应
url = 'http://47.113.216.40:5004/api?keyword=周杰伦'
try:
    resp = requests.get(url, timeout=30)
    data = resp.json()
    
    print(f'Success: {data.get("success")}')
    print(f'Total: {data.get("total")}')
    print(f'Message: {data.get("message")}')
    
    if data.get('results'):
        print(f'\nTotal results: {len(data["results"])}')
        print('\nFirst 5 results:')
        for i, item in enumerate(data['results'][:5]):
            print(f'{i+1}. Source: {item.get("source")}, Name: {item.get("name")}')
    else:
        print('No results')
except Exception as e:
    print(f'Error: {e}')
