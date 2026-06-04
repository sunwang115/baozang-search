#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
百度网盘转存终极调试 - 模拟完整浏览器行为
"""

import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from src.db.cookie_config_dao import get_cookie_by_cloud_name
import requests
import re
import time
import json

def test_full_browser_flow():
    """模拟完整的浏览器访问流程"""

    print("\n" + "=" * 70)
    print("🌐 模拟完整浏览器流程测试")
    print("=" * 70)

    cookie = get_cookie_by_cloud_name("百度网盘")
    if not cookie:
        print("❌ 未配置Cookie")
        return

    # 创建持久化session
    session = requests.Session()

    # 设置headers（参照Chrome浏览器）
    headers = {
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
        'Cache-Control': 'no-cache',
        'Connection': 'keep-alive',
        'Host': 'pan.baidu.com',
        'Pragma': 'no-cache',
        'Sec-Fetch-Dest': 'document',
        'Sec-Fetch-Mode': 'navigate',
        'Sec-Fetch-Site': 'none',
        'Sec-Fetch-User': '?1',
        'Upgrade-Insecure-Requests': '1',
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',  # 更新的Chrome版本
        'Cookie': cookie,
    }
    session.headers.update(headers)

    test_url = "https://pan.baidu.com/s/1q0jjvX0_dIuhBDhisNaiFA?pwd=1234"
    pass_code = "1234"

    # 步骤1：先访问百度网盘首页（建立初始session）
    print(f"\n[步骤1] 访问百度网盘首页...")
    try:
        resp_home = session.get('https://pan.baidu.com/', timeout=15)
        print(f"   状态码: {resp_home.status_code}")
        time.sleep(0.5)  # 模拟人类操作间隔
    except Exception as e:
        print(f"   ⚠️ 首页访问失败(可忽略): {e}")

    # 步骤2：获取bdstoken
    print(f"\n[步骤2] 获取bdstoken...")
    try:
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
        data_token = resp_token.json()
        if data_token.get('errno') != 0:
            print(f"   ❌ 获取bdstoken失败")
            return
        bdstoken = data_token['result']['bdstoken']
        print(f"   ✅ bdstoken: {bdstoken[:30]}...")
    except Exception as e:
        print(f"   ❌ 异常: {e}")
        return

    # 步骤3：先GET访问分享页面（关键！模拟用户点击链接）
    print(f"\n[步骤3] GET访问分享页面 (模拟用户打开链接)...")
    surl_match = re.search(r'/s/([a-zA-Z0-9_-]+)', test_url)
    surl = surl_match.group(1) if surl_match else ""

    try:
        # 先访问不带pwd的URL
        share_url_no_pwd = f"https://pan.baidu.com/s/1{surl}"
        resp_share = session.get(
            share_url_no_pwd,
            allow_redirects=True,
            max_redirects=5,
            timeout=20
        )
        print(f"   状态码: {resp_share.status_code}")
        print(f"   最终URL: {resp_share.url[:80]}...")

        # 检查Set-Cookie
        if 'Set-Cookie' in resp_share.headers:
            print(f"   🍪 收到新Cookie:")
            for sc in resp_share.headers.get_list('Set-Cookie'):
                print(f"      {sc[:60]}...")
        else:
            print(f"   无新Cookie")

        time.sleep(1)  # 等待页面加载

        # 尝试从HTML中提取信息
        html = resp_share.text
        share_id = re.search(r'"shareid":(\d+),', html)
        if share_id:
            print(f"   ✅ 从HTML提取到shareid: {share_id.group(1)}")
        else:
            print(f"   ⚠️ HTML中未找到shareid（可能需要验证后才能看到）")

    except Exception as e:
        print(f"   ⚠️ 访问分享页面异常: {e}")

    # 步骤4：POST验证提取码
    print(f"\n[步骤4] POST验证提取码...")
    try:
        resp_verify = session.post(
            'https://pan.baidu.com/share/verify',
            params={
                'surl': surl,
                'bdstoken': bdstoken,
                't': round(time.time() * 1000),
                'channel': 'chunlei',
                'web': '1',
                'clienttype': '0'
            },
            data={
                'pwd': pass_code,
                'vcode': '',
                'vcode_str': ''
            },
            allow_redirects=False,
            timeout=20
        )

        print(f"   状态码: {resp_verify.status_code}")

        # 再次检查Set-Cookie
        if 'Set-Cookie' in resp_verify.headers:
            print(f"   🍪 验证后收到新Cookie:")
            for sc in resp_verify.headers.get_list('Set-Cookie'):
                print(f"      {sc[:60]}...")

        verify_data = resp_verify.json()
        errno = verify_data.get('errno', -1)

        print(f"\n   完整响应:")
        print(json.dumps(verify_data, indent=2, ensure_ascii=False))

        if errno == 0:
            randsk = verify_data.get('randsk')
            if randsk:
                print(f"\n   ✅✅✅ 成功！！！ 提取码验证通过!")
                print(f"   randsk: {randsk}")
                return True
            else:
                print(f"\n   ⚠️ errno=0 但无randsk")
        else:
            error_map = {
                -9: '链接不存在或提取码错误',
                -12: '提取码错误',
                -62: '访问次数过多，需验证码',
                105: '该文件禁止分享',
                115: '该文件禁止分享',
            }
            msg = error_map.get(errno, f'未知错误({errno})')
            print(f"\n   ❌ 失败 (errno={errno}): {msg}")

    except Exception as e:
        print(f"   ❌ 异常: {e}")
        import traceback
        traceback.print_exc()

    return False


if __name__ == '__main__':
    success = test_full_browser_flow()
    if success:
        print("\n" + "=" * 70)
        print("🎉 测试成功！找到了正确的调用方式！")
        print("=" * 70)
    else:
        print("\n" + "=" * 70)
        print("💡 建议：检查提取码是否正确，或稍后重试")
        print("=" * 70)
