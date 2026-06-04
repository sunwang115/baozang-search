#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
详细调试：完全模拟心悦 BaiduWork::verifyPassCode()
"""

import sys
import os
import re
import time
import requests

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from src.db.cookie_config_dao import get_cookie_by_cloud_name

def debug_verify_passcode():
    """详细调试提取码验证过程"""

    print("\n" + "=" * 70)
    print("详细调试：提取码验证（参照心悦 BaiduWork::verifyPassCode）")
    print("=" * 70)

    # 1. 获取Cookie
    cookie = get_cookie_by_cloud_name("百度网盘")
    if not cookie:
        print("❌ 未配置百度网盘Cookie")
        return

    print(f"\n[1] Cookie长度: {len(cookie)}")

    # 2. 构造headers（参照 BaiduWork.php L39-52）
    headers_list = [
        'Host: pan.baidu.com',
        'Connection: keep-alive',
        'Upgrade-Insecure-Requests: 1',
        'Sec-Fetch-Dest: document',
        'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
        'Sec-Fetch-Site: same-site',
        'Sec-Fetch-Mode: navigate',
        'Referer: https://pan.baidu.com',
        'Accept-Encoding: gzip, deflate, br',
        'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,en-US;q=0.7,en-GB;q=0.6,ru;q=0.5',
        'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',
        f'Cookie: {cookie}'
    ]

    headers_dict = {}
    for h in headers_list:
        if ': ' in h:
            key, value = h.split(': ', 1)
            headers_dict[key] = value

    session = requests.Session()
    session.headers.update(headers_dict)

    # 3. 获取bdstoken
    print(f"\n[2] 获取 bdstoken...")
    resp_token = session.get(
        'https://pan.baidu.com/api/gettemplatevariable',
        params={
            'clienttype': '0',
            'app_id': '38824127',
            'web': '1',
            'fields': '["bdstoken","token","uk","isdocuser","servertime"]'
        },
        timeout=15
    )

    token_data = resp_token.json()
    if token_data.get('errno') != 0:
        print(f"❌ 获取bdstoken失败: {token_data}")
        return

    bdstoken = (token_data.get('result') or {}).get('bdstoken', '')
    print(f"✅ bdstoken: {bdstoken[:30]}...")

    # 4. 解析链接（关键！）
    test_url = "https://pan.baidu.com/s/1-Ymb_ziMlMAMs0N-3d4mtA?pwd=9527"
    print(f"\n[3] 解析链接:")
    print(f"   原始链接: {test_url}")

    # 参照 Transfer.php L61 的方式
    url_parts = test_url.split('/s/')
    if len(url_parts) < 2:
        print("❌ 链接格式错误")
        return

    surl_full = url_parts[1].split('?')[0].split('#')[0]
    print(f"   surl (完整): {surl_full}")

    # 提取pwd
    pwd_match = re.search(r'[?&]pwd=([a-zA-Z0-9]{4})', test_url)
    pwd = pwd_match.group(1) if pwd_match else ''
    print(f"   pwd: {pwd}")

    # 5. 构造 linkUrl（参照 BaiduPan.php L34）
    from urllib.parse import urlparse
    parsed = urlparse(test_url)
    link_url = f"{parsed.scheme}://{parsed.hostname}{parsed.path}"
    print(f"\n[4] linkUrl (用于验证):")
    print(f"   {link_url}")

    # 心悦的方式：substr($linkUrl, 25, 23)
    surl_xinyue = link_url[25:48] if len(link_url) > 48 else link_url[25:]
    print(f"\n[5] 心悦的 surl 截取方式:")
    print(f"   substr(linkUrl, 25, 23): '{surl_xinyue}'")
    print(f"   linkUrl长度: {len(link_url)}")
    print(f"   linkUrl[20:50]: '{link_url[20:50]}'")

    # 6. 验证提取码（尝试两种方式）
    print(f"\n[6] 验证提取码...")

    for i, surl_test in enumerate([surl_full, surl_xinyue]):
        print(f"\n--- 尝试方式 {i+1}: surl='{surl_test}' ---")

        verify_resp = session.post(
            'https://pan.baidu.com/share/verify',
            params={
                'surl': surl_test,
                'bdstoken': bdstoken,
                't': round(time.time() * 1000),
                'channel': 'chunlei',
                'web': '1',
                'clienttype': '0'
            },
            data={
                'pwd': pwd,
                'vcode': '',
                'vcode_str': ''
            },
            allow_redirects=False,
            timeout=15
        )

        verify_data = verify_resp.json()
        errno = verify_data.get('errno', -1)

        print(f"   HTTP状态码: {verify_resp.status_code}")
        print(f"   errno: {errno}")
        print(f"   完整响应: {verify_data}")

        if errno == 0:
            randsk = verify_data.get('randsk')
            print(f"   ✅✅✅ 验证成功! randsk={randsk[:30] if randsk else ''}...")
        elif errno == -12:
            print(f"   ❌ 提取码错误")
        elif errno == -9:
            print(f"   ❌ 链接不存在或提取码错误")
        elif errno == 105:
            print(f"   ⚠️  该文件禁止分享")
        else:
            print(f"   ❌ 其他错误: {errno}")

if __name__ == '__main__':
    debug_verify_passcode()
