import requests
import json

# 测试外部API的原始响应
url = 'http://47.113.216.40:5004/api?keyword=周杰伦'
try:
    resp = requests.get(url, timeout=30)
    data = resp.json()
    
    print(f'Success: {data.get("success")}')
    print(f'Total: {data.get("total")}')
    
    if data.get('results'):
        print(f'\nTotal results: {len(data["results"])}')
        
        # 检查有多少结果包含关键词
        keyword = '周杰伦'
        keywords = [k.strip() for k in keyword.split() if k.strip()]
        
        match_count = 0
        no_match_count = 0
        
        for item in data['results']:
            name = item.get('name', '')
            title_lower = name.lower()
            is_match = any(kw in title_lower for kw in keywords)
            
            if is_match:
                match_count += 1
            else:
                no_match_count += 1
        
        print(f'\nSummary:')
        print(f'Total: {len(data["results"])}')
        print(f'MATCH: {match_count}')
        print(f'NO_MATCH: {no_match_count}')
        
        # 显示前5个匹配的结果
        print(f'\nFirst 5 matching results:')
        count = 0
        for item in data['results']:
            name = item.get('name', '')
            title_lower = name.lower()
            is_match = any(kw in title_lower for kw in keywords)
            
            if is_match:
                count += 1
                print(f'{count}. {name}')
                if count >= 5:
                    break
        
        if count == 0:
            print('No matching results found!')
    else:
        print('No results')
except Exception as e:
    print(f'Error: {e}')
