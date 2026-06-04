#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
调试百度网盘转存问题
"""

import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from src.db.cookie_config_dao import get_cookie_by_cloud_name
from src.clients.baidu_client import Baidu

def test_baidu_transfer():
    """测试百度网盘转存流程"""

    print("\n" + "=" * 60)
    print("🔍 测试百度网盘转存")
    print("=" * 60)

    # 1. 获取Cookie
    cookie = get_cookie_by_cloud_name("百度网盘")
    if not cookie:
        print("❌ 未配置百度网盘Cookie")
        return

    print(f"\n[1] Cookie长度: {len(cookie)}")

    # 检查关键字段
    fields = ['BDUSS', 'STOKEN', 'BAIDUID', 'PANWEB', 'csrfToken']
    for field in fields:
        if f'{field}=' in cookie:
            print(f"   ✅ 包含 {field}")
        else:
            print(f"   ❌ 缺少 {field}")

    # 2. 初始化客户端
    print(f"\n[2] 初始化百度网盘客户端...")
    client = Baidu(cookie)

    # 3. 获取bdstoken
    print(f"\n[3] 获取bdstoken...")
    bdstoken = client.get_bdstoken()
    if isinstance(bdstoken, int) and bdstoken != 0:
        print(f"   ❌ 获取bdstoken失败 (errno={bdstoken})")
        return
    elif not bdstoken:
        print(f"   ❌ 获取bdstoken失败: 返回空值")
        return

    print(f"   ✅ bdstoken获取成功: {bdstoken[:30]}...")

    # 4. 测试一个带提取码的链接
    test_url = "https://pan.baidu.com/s/13xoQBXhEAfOiKSLvw2n1kA?pwd=0422"
    print(f"\n[4] 测试提取码验证...")
    print(f"   测试链接: {test_url}")

    surl, pwd = client._parse_share_url(test_url)
    print(f"   surl: {surl}")
    print(f"   pwd: {pwd}")

    if pwd:
        print(f"\n[5] 调用 _verify_passcode()...")
        randsk = client._verify_passcode(test_url, pwd)

        if randsk:
            print(f"   ✅ 提取码验证成功!")
            print(f"      randsk: {randsk[:30]}...")
        else:
            print(f"   ❌ 提取码验证失败!")
            print(f"   请查看上方详细错误信息")

if __name__ == '__main__':
    test_baidu_transfer()
