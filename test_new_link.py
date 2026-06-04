#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
测试新链接的转存
"""

import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from src.clients.baidu_client import Baidu
from src.db.cookie_config_dao import get_cookie_by_cloud_name
import logging

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

def test_new_link():
    """测试新链接"""

    print("\n" + "=" * 70)
    print("测试新链接: https://pan.baidu.com/s/16OEZS6U9sKxJNAjcUQ39kA?pwd=9527")
    print("=" * 70)

    cookie = get_cookie_by_cloud_name("百度网盘")
    if not cookie:
        print("❌ 未配置Cookie")
        return False

    baidu = Baidu(cookie)
    
    # 测试新链接
    test_url = "https://pan.baidu.com/s/16OEZS6U9sKxJNAjcUQ39kA?pwd=9527"
    
    print(f"\n开始转存测试...")
    file_id, file_name, share_url = baidu.store(test_url, "/")

    print(f"\n{'=' * 70}")
    if file_id and share_url and file_name:
        print(f"✅ 转存成功!")
        print(f"   file_id: {file_id}")
        print(f"   file_name: {file_name[:50]}...")
        print(f"   share_url: {share_url[:60]}...")
        return True
    else:
        print(f"❌ 转存失败!")
        print(f"   file_id: {file_id}")
        print(f"   file_name: {file_name}")
        print(f"   share_url: {share_url}")
        return False

if __name__ == '__main__':
    success = test_new_link()
    sys.exit(0 if success else 1)
