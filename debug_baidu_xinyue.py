#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
完全模拟心悦盘搜BaiduWork的百度网盘测试脚本
逐步对比每一步的差异
"""

import sys
import os
import re
import json
import time
import requests

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from src.db.cookie_config_dao import get_cookie_by_cloud_name

def test_baidu_like_xinyue():
    """完全按照心悦盘搜的方式测试百度网盘"""

    print("\n" + "=" * 70)
    print("🔬 完全模拟心悦盘搜 BaiduWork 的测试")
    print("=" * 70)

    # 1. 获取Cookie
    cookie = get_cookie_by_cloud_name("百度网盘")
    if not cookie:
        print("❌ 未配置百度网盘Cookie")
        return

    print(f"\n[步骤1] Cookie长度: {len(cookie)}")

    # 2. 完全按照心悦盘搜的headers构造
    print(f"\n[步骤2] 构造请求头（完全参照BaiduWork.php L39-52）...")
    headers = [
        'Host: pan.baidu.com',
        'Connection: keep-alive',
        'Upgrade-Insecure-Requests: 1',
        'Sec-Fetch-Dest: document',
        'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
        'Sec-Fetch-Site: same-site',
        'Sec-Fetch-Mode: navigate',
        'Referer: https://pan.baidu.com',           # 心悦盘搜有这个
        'Accept-Encoding: gzip, deflate, br',
        'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,en-US;0.7,en-GB;0.6,ru;q=0.5',
        'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36',  # 心悦盘搜用Chrome 114
        f'Cookie: {cookie}'
    ]

    # 转换为requests格式
    headers_dict = {}
    for h in headers:
        if ': ' in h:
            key, value = h.split(': ', 1)
            headers_dict[key] = value

    print(f"   User-Agent: {headers_dict.get('User-Agent', 'N/A')[:50]}...")
    print(f"   Referer: {headers_dict.get('Referer', 'N/A')}")

    # 3. 创建session（保持cookie一致性）
    session = requests.Session()
    session.headers.update(headers_dict)

    # 4. 获取bdstoken（参照getBdstoken）
    print(f"\n[步骤3] 获取bdstoken (参照 BaiduWork::getBdstoken)...")
    url_gettemplate = 'https://pan.baidu.com/api/gettemplatevariable'
    params_template = {
        'clienttype': '0',
        'app_id': '38824127',
        'web': '1',
        'fields': '["bdstoken","token","uk","isdocuser","servertime"]'
    }

    try:
        resp = session.get(url_gettemplate, params=params_template, timeout=15)
        print(f"   HTTP状态码: {resp.status_code}")

        if resp.status_code != 200:
            print(f"   ❌ HTTP错误: {resp.status_code}")
            return

        data = resp.json()
        print(f"   响应errno: {data.get('errno', 'N/A')}")

        if data.get('errno') != 0:
            print(f"   ❌ 获取bdstoken失败: {data}")
            return

        bdstoken = data.get('result', {}).get('bdstoken', '')
        if not bdstoken:
            print(f"   ❌ 响应中缺少bdstoken")
            return

        print(f"   ✅ bdstoken获取成功: {bdstoken[:30]}...")

    except Exception as e:
        print(f"   ❌ 请求异常: {e}")
        import traceback
        traceback.print_exc()
        return

    # 5. 测试提取码验证（关键步骤！）
    test_url = "https://pan.baidu.com/s/1q0jjvX0_dIuhBDhisNaiFA"
    pass_code = "1234"

    # 提取surl（参照心悦盘搜的substr方式，但我们用正则更灵活）
    surl_match = re.search(r'/s/([a-zA-Z0-9_-]+)', test_url)
    surl = surl_match.group(1) if surl_match else ""

    print(f"\n[步骤4] 验证提取码 (参照 BaiduWork::verifyPassCode)...")
    print(f"   分享链接: {test_url}")
    print(f"   surl: {surl}")
    print(f"   提取码: {pass_code}")

    url_verify = f"https://pan.baidu.com/share/verify"
    params_verify = {
        'surl': surl,
        'bdstoken': bdstoken,
        't': round(time.time() * 1000),  # 毫秒时间戳
        'channel': 'chunlei',
        'web': '1',
        'clienttype': '0'
    }
    data_verify = {
        'pwd': pass_code,
        'vcode': '',
        'vcode_str': ''
    }

    try:
        # 使用POST请求（参照心悦盘搜）
        resp_verify = session.post(
            url_verify,
            params=params_verify,
            data=data_verify,
            timeout=15,
            allow_redirects=False  # 心悦盘搜默认不跟随重定向
        )

        print(f"\n   HTTP状态码: {resp_verify.status_code}")
        print(f"   响应头:")
        for key, value in resp_verify.headers.items():
            if key.lower() in ['set-cookie', 'content-type']:
                print(f"      {key}: {value[:80]}...")

        verify_data = resp_verify.json()
        print(f"\n   完整响应JSON:")
        print(json.dumps(verify_data, indent=2, ensure_ascii=False))

        errno = verify_data.get('errno', -1)
        print(f"\n   errno值: {errno}")

        if errno == 0:
            randsk = verify_data.get('randsk')
            if randsk:
                print(f"   ✅✅✅ 提取码验证成功!")
                print(f"      randsk: {randsk[:40]}...")

                # 6. 更新BDCLND（参照updateBdclnd）
                print(f"\n[步骤5] 更新Cookie中的BDCLND (参照 BaiduWork::updateBdclnd)...")
                new_cookie = update_bdclnd_in_cookie(randsk, cookie)
                print(f"   ✅ BDCLND已更新")

                # 更新session的headers
                session.headers.update({'Cookie': new_cookie})
                print(f"   ✅ Session headers已更新")

            else:
                print(f"   ⚠️ errno=0 但缺少randsk")
        elif errno == -9 or errno == -12:
            print(f"\n   ❌❌❌ 提取码错误!")
            print(f"   错误类型: {'链接不存在或提取码错误' if errno == -9 else '提取码错误'}")
            print(f"\n   可能的原因:")
            print(f"   1. 百度检测到自动化行为（反爬虫）")
            print(f"   2. Cookie中的某些关键字段已过期")
            print(f"   3. 需要先访问分享页面建立会话")
            print(f"   4. IP被临时限制")
        elif errno == -62:
            print(f"\n   ⚠️ 需要验证码 (errno=-62)")
            print(f"   建议: 稍后再试或手动转存")
        else:
            print(f"\n   ❌ 其他错误 (errno={errno})")

    except Exception as e:
        print(f"\n   ❌ 验证请求异常: {e}")
        import traceback
        traceback.print_exc()


def update_bdclnd_in_cookie(randsk: str, cookie: str) -> str:
    """
    参照 BaiduWork::updateCookie() 方法
    将randsk写入cookie的BDCLND字段
    """
    # 拆分cookie
    cookie_pairs = [p.strip() for p in cookie.split(';') if p.strip()]
    cookies_dict = {}

    for pair in cookie_pairs:
        if '=' in pair:
            parts = pair.split('=', 1)
            cookies_dict[parts[0].strip()] = parts[1].strip()

    # 更新BDCLND
    old_value = cookies_dict.get('BDCLND', '')
    cookies_dict['BDCLND'] = randsk

    # 重新构建cookie
    new_cookie_parts = [f"{k}={v}" for k, v in cookies_dict.items()]
    new_cookie = '; '.join(new_cookie_parts)

    print(f"   BDCLND旧值: {old_value[:20] if old_value else '(空)'}...")
    print(f"   BDCLND新值: {randsk[:20]}...")

    return new_cookie


if __name__ == '__main__':
    test_baidu_like_xinyue()
