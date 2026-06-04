import sys
sys.path.insert(0, 'd:\\自己搭建的网站\\20260203\\API接口搭建测试版本\\小青盘搜加心悦融合\\宝藏盘搜\\search-ucmao-master')

from src.services.search_service import filter_output

# 测试数据
test_data = [
    ["长夜将尽（1080P&4K）（官方正式版)", "https://pan.quark.cn/s/de8c4ce7b2bd"],
    ["N哪吒之魔童闹海幕后纪录片《不破不立》2025", "https://pan.quark.cn/s/bd0d8726dcf9"],
    ["【推荐电影】哪吒之魔童闹海（2025）（1080P.极高码）官方正式版", "https://pan.baidu.com/s/1UvIzft6s0z97c4wdiypSAg?pwd=6666"],
    ["【音乐】周杰伦-寻找周杰伦(EP)", "https://pan.quark.cn/s/cbfcb262da9b"],
    ["【音乐】周杰伦-周杰伦的床边故事", "https://pan.quark.cn/s/6dfb2ec3c1af"],
]

keyword = "周杰伦"
result = filter_output(test_data, keyword)

print(f"Input: {len(test_data)} items")
print(f"Output: {len(result)} items")
print(f"Keyword: {keyword}")
print("\nFiltered results:")
for item in result:
    print(f"- {item[0]}")
