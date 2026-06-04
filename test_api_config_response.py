import sys
sys.path.insert(0, 'd:\\自己搭建的网站\\20260203\\API接口搭建测试版本\\小青盘搜加心悦融合\\宝藏盘搜\\search-ucmao-master')

from src.db.api_config_dao import get_all_configs

# 检查API配置的response字段
configs = get_all_configs(order_by_created=False)
print(f"总配置数: {len(configs)}")

for i, config in enumerate(configs):
    print(f"\n=== 配置 {i+1}: {config['name']} ===")
    print(f"URL: {config['url']}")
    print(f"Response (JMESPath): {config['response']}")
    print(f"Status: {config['status']}")
    print(f"Is Enabled: {config['is_enabled']}")
