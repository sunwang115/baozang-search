#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
验证百度网盘Cookie有效性
"""

import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from src.db.cookie_config_dao import get_cookie_by_cloud_name
import requests
import re

def test_cookie_validity():
    """验证Cookie是否能正常使用"""

    print("\n" + "=" * 70)
    print("🔍 验证百度网盘Cookie有效性")
    print("=" * 70)

    cookie = get_cookie_by_cloud_name("百度网盘")
    if not cookie:
        print("❌ 未配置Cookie")
        return

    print(f"\n[1] Cookie长度: {len(cookie)}")

    # 提取关键字段
    fields = {}
    for item in cookie.split(';'):
        item = item.strip()
        if '=' in item:
            key, value = item.split('=', 1)
            if key in ['BDUSS', 'STOKEN', 'BAIDUID', 'PANWEB', 'csrfToken']:
                fields[key] = value[:30] + '...' if len(value) > 30 else value

    print(f"[2] 关键字段:")
    for key, value in fields.items():
        print(f"   {key}: {value}")

    # 测试1：获取用户信息
    print(f"\n[3] 测试API: 获取用户信息...")
    session = requests.Session()
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        'Cookie': cookie,
        'Referer': 'https://pan.baidu.com/',
    }
    session.headers.update(headers)

    try:
        resp = session.get(
            'https://pan.baidu.com/api/gettemplatevariable',
            params={
                'clienttype': '0',
                'app_id': '38824127',
                'web': '1',
                'fields': '["bdstoken","token","uk","isdocuser","servertime"]'
            },
            timeout=15
        )

        data = resp.json()
        errno = data.get('errno', -1)

        if errno == 0:
            bdstoken = data.get('result', {}).get('bdstoken', '')
            uk = data.get('result', {}).get('uk', '')
            print(f"   ✅ API调用成功!")
            print(f"      bdstoken: {bdstoken[:30]}...")
            print(f"      uk (用户ID): {uk}")

            # 测试2：获取文件列表
            print(f"\n[4] 测试API: 获取根目录文件列表...")

            resp2 = session.get(
                'https://pan.baidu.com/api/list',
                params={
                    'order': 'time',
                    'desc': '1',
                    'showempty': '0',
                    'web': '1',
                    'page': '1',
                    'num': '10',
                    'dir': '/',
                    'bdstoken': bdstoken,
                },
                timeout=15
            )

            data2 = resp2.json()
            errno2 = data2.get('errno', -1)

            if errno2 == 0:
                file_list = data2.get('list', [])
                print(f"   ✅ 文件列表获取成功! 共{len(file_list)}个文件")
                if file_list:
                    print(f"      示例文件: {file_list[0].get('server_filename', 'N/A')}")
            else:
                error_msg = {
                    -6: '请用浏览器无痕模式获取 Cookie 后再试',
                    -1: '链接错误或未登录',
                }.get(errno2, f'未知错误({errno2})')
                print(f"   ❌ 获取文件列表失败 (errno={errno2}): {error_msg}")
                print(f"      完整响应: {str(data2)[:200]}")

        else:
            error_msg = {
                -6: '请用浏览器无痕模式获取 Cookie 后再试',
                -1: '未登录或Cookie无效',
            }.get(errno, f'未知错误({errno})')
            print(f"   ❌ API调用失败 (errno={errno}): {error_msg}")
            print(f"      完整响应: " + str(data)[:200])

    except Exception as e:
        print(f"   ❌ 请求异常: {e}")
        import traceback
        traceback.print_exc()

if __name__ == '__main__':
    test_cookie_validity()
