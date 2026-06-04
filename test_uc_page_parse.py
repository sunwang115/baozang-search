#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
测试UC网盘分享页面解析
"""

import sys
import os
import re
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from src.clients.uc_client import UcDrive
from src.db.cookie_config_dao import get_cookie_by_cloud_name
import requests
import logging

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

def test_uc_page_parse():
    """测试解析UC网盘分享页面"""

    print("\n" + "=" * 70)
    print("UC网盘分享页面解析测试")
    print("=" * 70)

    # 获取Cookie
    cookie = get_cookie_by_cloud_name("UC网盘")
    if not cookie:
        print("❌ 未配置UC网盘Cookie")
        return False

    print(f"\nCookie长度: {len(cookie)}")

    # 测试链接
    test_url = "https://drive.uc.cn/s/ce0c650982e64?public=1"

    print(f"\n测试链接: {test_url}")

    # 创建session
    session = requests.Session()
    session.headers.update({
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
        "Accept-Language": "zh-CN,zh;q=0.9",
        "Referer": "https://drive.uc.cn/",
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36",
        "cookie": cookie,
    })

    try:
        print("\n[步骤1] 访问分享页面...")
        resp = session.get(test_url, timeout=15)
        print(f"HTTP状态码: {resp.status_code}")
        print(f"页面长度: {len(resp.text)}")

        # 尝试解析页面中的数据
        html = resp.text
        
        # 查找可能的API端点或数据
        print("\n[步骤2] 解析页面数据...")
        
        # 查找 window.__INITIAL_STATE__ 或类似的JSON数据
        init_state_match = re.search(r'window\.__INITIAL_STATE__\s*=\s*({.+?});', html, re.DOTALL)
        if init_state_match:
            print("✅ 找到 __INITIAL_STATE__")
            print(f"数据长度: {len(init_state_match.group(1))}")
            
        # 查找其他JSON数据
        json_data_match = re.search(r'data-config\s*=\s*["\'](.+?)["\']', html)
        if json_data_match:
            print("✅ 找到 data-config")
            print(f"数据: {json_data_match.group(1)[:100]}...")
            
        # 查找 script 标签中的数据
        script_matches = re.findall(r'<script[^>]*>(.+?)</script>', html, re.DOTALL)
        for i, script in enumerate(script_matches[:3]):
            if 'token' in script.lower() or 'share' in script.lower():
                print(f"\n✅ 脚本 {i+1} 包含关键数据")
                print(f"内容预览: {script[:150]}...")

        # 查找可能的新API端点
        api_matches = re.findall(r'https?://pc-api\.uc\.cn/[^"\'\s]+', html)
        if api_matches:
            print("\n✅ 找到API端点:")
            for api in api_matches[:5]:
                print(f"   {api}")

        return True

    except Exception as e:
        print(f"\n❌ 异常: {e}")
        import traceback
        traceback.print_exc()
        return False

if __name__ == '__main__':
    success = test_uc_page_parse()
    sys.exit(0 if success else 1)
