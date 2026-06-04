import sys
sys.path.insert(0, 'd:\\自己搭建的网站\\20260203\\API接口搭建测试版本\\小青盘搜加心悦融合\\宝藏盘搜\\search-ucmao-master')

from src.services.search_service import search_public_resources

# 测试搜索
keyword = "周杰伦"
success, message, results = search_public_resources(keyword=keyword, limit=100, skip_transfer=True)

print(f"Success: {success}")
print(f"Message: {message}")
print(f"Total results: {len(results)}")

# 检查关键词匹配
keywords = [k.strip() for k in keyword.split() if k.strip()]
match_count = 0
no_match_count = 0
no_match_items = []

for item in results:
    name = item.get('name', '')
    title_lower = name.lower()
    is_match = any(kw in title_lower for kw in keywords)
    
    if is_match:
        match_count += 1
    else:
        no_match_count += 1
        no_match_items.append(name)

print(f"\nSummary:")
print(f"MATCH: {match_count}")
print(f"NO_MATCH: {no_match_count}")

if no_match_items:
    print(f"\nNo match items (first 10):")
    for i, name in enumerate(no_match_items[:10]):
        print(f"{i+1}. {name}")
