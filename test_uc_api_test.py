#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
测试UC网盘新API端点
"""

import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from src.db.cookie_config_dao import get_cookie_by_cloud_name
import requests
import logging

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

def test_uc_new_api():
    """测试UC网盘新API"""

    print("\n" + "=" * 70)
    print("UC网盘新API测试")
    print("=" * 70)

    cookie = get_cookie_by_cloud_name("UC网盘")
    if not cookie:
        print("❌ 未配置UC网盘Cookie")
        return False

    print(f"\nCookie长度: {len(cookie)}")

    test_url = "https://drive.uc.cn/s/ce0c650982e64?public=1"
    pwd_id = "ce0c650982e64"

    session = requests.Session()
    session.headers.update({
        "Accept": "application/json, text/plain, */*",
        "Accept-Language": "zh-CN,zh;q=0.9",
        "Content-Type": "application/json;charset=UTF-8",
        "Referer": "https://drive.uc.cn/",
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36",
        "cookie": cookie,
    })

    # 尝试各种可能的API端点
    api_endpoints = [
        # 新格式的API
        f"https://drive.uc.cn/api/share/getShareInfo?pwdId={pwd_id}",
        f"https://drive.uc.cn/api/share/detail?pwdId={pwd_id}",
        f"https://drive.uc.cn/api/share/getDetail?pwdId={pwd_id}",
        
        # 旧格式的API
        f"https://pc-api.uc.cn/1/clouddrive/share/sharepage/detail?pwd_id={pwd_id}&pr=UCBrowser&fr=pc",
        f"https://pc-api.uc.cn/2/clouddrive/share/sharepage/detail?pwd_id={pwd_id}&pr=UCBrowser&fr=pc",
        
        # 移动端API
        f"https://api.drive.uc.cn/v2/share/detail?pwd_id={pwd_id}",
        f"https://api.drive.uc.cn/v3/share/detail?pwd_id={pwd_id}",
        
        # 其他可能的端点
        f"https://drive.uc.cn/api/share/v2/detail?pwdId={pwd_id}",
        f"https://drive.uc.cn/api/share/v3/detail?pwdId={pwd_id}",
    ]

    print(f"\n测试 {len(api_endpoints)} 个API端点...")

    for i, api_url in enumerate(api_endpoints):
        print(f"\n--- 尝试端点 {i+1} ---")
        print(f"URL: {api_url}")
        
        try:
            resp = session.get(api_url, timeout=10)
            print(f"HTTP状态码: {resp.status_code}")
            
            if resp.status_code == 200:
                try:
                    data = resp.json()
                    print(f"响应长度: {len(resp.text)}")
                    if 'status' in data:
                        print(f"status: {data.get('status')}")
                    if 'message' in data:
                        print(f"message: {data.get('message')}")
                    if 'data' in data:
                        data_keys = list(data['data'].keys()) if isinstance(data['data'], dict) else f"数组长度: {len(data['data'])}"
                        print(f"data keys: {data_keys}")
                except:
                    print(f"响应不是JSON，前200字符: {resp.text[:200]}")
                    
        except Exception as e:
            print(f"❌ 异常: {e}")

    return True

if __name__ == '__main__':
    success = test_uc_new_api()
    sys.exit(0 if success else 1)
