import sys
sys.path.insert(0, 'd:\\自己搭建的网站\\20260203\\API接口搭建测试版本\\小青盘搜加心悦融合\\宝藏盘搜\\search-ucmao-master')

from src.services.search_service import process_config

# 测试配置
config = {
    "name": "官方接口",
    "url": "http://47.113.216.40:5004/api?keyword=周杰伦",
    "method": "GET",
    "request": "{}",
    "response": "results[*].[name, share_link]",
    "status": True,
    "is_enabled": True,
}

keyword = "周杰伦"
print(f"=== 测试 process_config ===")
print(f"关键词: {keyword}")
print(f"配置: {config['name']}")

results = process_config(config, keyword)
print(f"\n返回结果: {len(results)} 条")

# 检查关键词匹配
keywords = [k.strip() for k in keyword.split() if k.strip()]
match_count = 0
no_match_count = 0

for item in results:
    name = item[1] if len(item) > 1 else ""
    title_lower = name.lower()
    is_match = any(kw in title_lower for kw in keywords)
    
    if is_match:
        match_count += 1
    else:
        no_match_count += 1

print(f"MATCH: {match_count}")
print(f"NO_MATCH: {no_match_count}")

if results:
    print(f"\n前3条结果:")
    for i, item in enumerate(results[:3]):
        print(f"  {i+1}. {item}")
