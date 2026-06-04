import requests
import json

# 测试本地API的响应
url = 'http://127.0.0.1:5004/api?keyword=周杰伦'
try:
    resp = requests.get(url, timeout=30)
    data = resp.json()
    
    print(f'Success: {data.get("success")}')
    print(f'Total: {data.get("total")}')
    
    if data.get('results'):
        print(f'\nTotal results: {len(data["results"])}')
        
        # 检查所有结果的关键词匹配情况
        keyword = '周杰伦'
        keywords = [k.strip() for k in keyword.split() if k.strip()]
        
        match_count = 0
        no_match_count = 0
        no_match_items = []
        
        for item in data['results']:
            name = item.get('name', '')
            title_lower = name.lower()
            is_match = any(kw in title_lower for kw in keywords)
            
            if is_match:
                match_count += 1
            else:
                no_match_count += 1
                no_match_items.append(name)
        
        print(f'\nSummary:')
        print(f'Total: {len(data["results"])}')
        print(f'MATCH: {match_count}')
        print(f'NO_MATCH: {no_match_count}')
        
        if no_match_items:
            print(f'\nNo match items (first 10):')
            for i, name in enumerate(no_match_items[:10]):
                print(f'{i+1}. {name}')
    else:
        print('No results')
except Exception as e:
    print(f'Error: {e}')
