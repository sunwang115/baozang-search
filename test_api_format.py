import requests
import json

# 测试外部API的响应格式
url = 'http://47.113.216.40:5004/api?keyword=周杰伦'
try:
    resp = requests.get(url, timeout=30)
    data = resp.json()
    
    if data.get('success') and data.get('results'):
        print(f'Total results: {len(data["results"])}')
        print('\nFirst result structure:')
        first = data['results'][0]
        print(json.dumps(first, ensure_ascii=False, indent=2))
        
        print('\nChecking filter_output logic:')
        keyword = '周杰伦'
        keywords = [k.strip() for k in keyword.split() if k.strip()]
        print(f'Keywords: {keywords}')
        
        for i, item in enumerate(data['results'][:5]):
            name = item.get('name', '')
            title_lower = name.lower()
            is_match = any(kw in title_lower for kw in keywords)
            print(f'{i+1}. Match: {is_match}, Title: {name}')
    else:
        print('No results or API failed')
except Exception as e:
    print(f'Error: {e}')
