import sys
sys.path.insert(0, 'd:\\自己搭建的网站\\20260203\\API接口搭建测试版本\\小青盘搜加心悦融合\\宝藏盘搜\\search-ucmao-master')

from src.db.api_config_dao import get_all_configs
from src.services.search_service import read_all_api_configs_from_db

# 检查API配置
print("=== 检查API配置 ===")
configs = get_all_configs(order_by_created=False)
print(f"总配置数: {len(configs)}")

enabled_configs = [c for c in configs if c.get("status", False) and c.get("is_enabled", False)]
print(f"启用的配置数: {len(enabled_configs)}")

for i, config in enumerate(enabled_configs):
    print(f"  {i+1}. {config['name']} - {config['url']}")
    print(f"     status: {config['status']}, is_enabled: {config['is_enabled']}")

# 检查read_all_api_configs_from_db
print(f"\n=== 检查read_all_api_configs_from_db ===")
configs2 = read_all_api_configs_from_db()
print(f"返回配置数: {len(configs2)}")

for i, config in enumerate(configs2):
    print(f"  {i+1}. {config.get('name', 'N/A')} - {config.get('url', 'N/A')}")
    print(f"     status: {config.get('status')}, is_enabled: {config.get('is_enabled')}")
