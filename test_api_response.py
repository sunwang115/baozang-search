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
        print('\nFirst 10 results (checking keyword match):')
        keyword = '周杰伦'
        keywords = [k.strip() for k in keyword.split() if k.strip()]
        
        match_count = 0
        no_match_count = 0
        
        for i, item in enumerate(data['results'][:20]):
            name = item.get('name', '')
            title_lower = name.lower()
            is_match = any(kw in title_lower for kw in keywords)
            
            if is_match:
                match_count += 1
                mark = 'MATCH'
            else:
                no_match_count += 1
                mark = 'NO_MATCH'
            
            print(f'{i+1}. [{mark}] {name}')
        
        print(f'\nSummary: MATCH={match_count}, NO_MATCH={no_match_count}')
    else:
        print('No results')
except Exception as e:
    print(f'Error: {e}')
