import sys
sys.path.insert(0, 'd:\\自己搭建的网站\\20260203\\API接口搭建测试版本\\小青盘搜加心悦融合\\宝藏盘搜\\search-ucmao-master')

import requests
import jmespath
import json

# 测试外部API响应
url = 'http://47.113.216.40:5004/api?keyword=周杰伦'
try:
    resp = requests.get(url, timeout=30)
    data = resp.json()
    
    print(f'Status: {resp.status_code}')
    print(f'Success: {data.get("success")}')
    print(f'Total: {data.get("total")}')
    
    # 测试不同的JMESPath查询
    queries = [
        "results",
        "results[*].name",
        "results[*].[name, share_link]",
        "results[*].{name: name, url: share_link}",
    ]
    
    for query in queries:
        print(f"\n=== 测试查询: {query} ===")
        try:
            result = jmespath.search(query, data)
            print(f"结果类型: {type(result)}")
            if isinstance(result, list):
                print(f"结果数量: {len(result)}")
                if result:
                    print(f"第一个结果: {result[0]}")
            else:
                print(f"结果: {result}")
        except Exception as e:
            print(f"错误: {e}")
    
    # 检查实际的results结构
    print(f"\n=== 实际results结构 ===")
    if data.get('results'):
        first = data['results'][0]
        print(f"第一个结果类型: {type(first)}")
        print(f"第一个结果: {json.dumps(first, ensure_ascii=False)[:200]}")
        
except Exception as e:
    print(f'Error: {e}')
