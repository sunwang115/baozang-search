#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""检查数据库中的链接模式配置"""

import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from src.db.system_config_dao import get_config_value
import json

print("=" * 60)
print("检查数据库配置")
print("=" * 60)

# 检查链接模式配置
link_mode_raw = get_config_value("frontend_link_mode")
print(f"\n[1] frontend_link_mode 原始值:")
print(f"    类型: {type(link_mode_raw)}")
print(f"    值: {repr(link_mode_raw)}")

if link_mode_raw:
    try:
        parsed = json.loads(link_mode_raw)
        print(f"\n[2] 解析后:")
        print(f"    JSON: {parsed}")
        print(f"    mode: {parsed.get('mode', '未找到')}")
    except Exception as e:
        print(f"\n[2] 解析失败: {e}")

print("\n" + "=" * 60)
