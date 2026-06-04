import sys
sys.path.insert(0, 'd:\\自己搭建的网站\\20260203\\API接口搭建测试版本\\小青盘搜加心悦融合\\宝藏盘搜\\search-ucmao-master')

from src.services.search_service import search_public_resources, search_in_database, filter_by_keyword

# 测试数据库搜索
keyword = "周杰伦"
print(f"=== 测试数据库搜索 ===")
print(f"关键词: {keyword}")

db_results = search_in_database(keyword)
print(f"数据库结果: {len(db_results)} 条")
for i, item in enumerate(db_results[:3]):
    print(f"  {i+1}. {item}")

# 测试filter_by_keyword
print(f"\n=== 测试 filter_by_keyword ===")
test_data = [
    ["database", "周杰伦-七里香", "https://pan.baidu.com/s/123", "百度网盘"],
    ["other", "【音乐】周杰伦-寻找周杰伦(EP)", "https://pan.quark.cn/s/abc", "夸克网盘"],
    ["other", "哪吒之魔童闹海", "https://pan.baidu.com/s/def", "百度网盘"],
]
filtered = filter_by_keyword(test_data, keyword)
print(f"输入: {len(test_data)} 条")
print(f"输出: {len(filtered)} 条")
for item in filtered:
    print(f"  - {item[1]}")

# 测试完整搜索
print(f"\n=== 测试完整搜索 ===")
success, message, results = search_public_resources(keyword=keyword, limit=100, skip_transfer=True)
print(f"Success: {success}")
print(f"Message: {message}")
print(f"Total results: {len(results)}")

# 检查关键词匹配
keywords = [k.strip() for k in keyword.split() if k.strip()]
match_count = 0
no_match_count = 0

for item in results:
    name = item.get('name', '')
    title_lower = name.lower()
    is_match = any(kw in title_lower for kw in keywords)
    
    if is_match:
        match_count += 1
    else:
        no_match_count += 1

print(f"MATCH: {match_count}")
print(f"NO_MATCH: {no_match_count}")
