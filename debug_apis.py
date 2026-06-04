#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
调试脚本：测试各网盘API调用
用于快速定位问题原因
"""

import sys
import os
import json
import requests

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

def test_xunlei_api():
    """测试迅雷云盘API - 完全按照心悦盘搜实现"""
    print("\n" + "=" * 60)
    print("🔍 测试迅雷云盘API")
    print("=" * 60)

    refresh_token = "a1.3RxJlJVMQGoILDwNqjKf2aNZIm2GWRHD9AJPz1i4qgLJvMKJ"
    client_id = "Xqp0kJBXWhwaTpB6"
    device_id = "925b7631473a13716b791d7f28289cad"

    # 第一步：获取access_token
    print(f"\n[1] 调用 Token API...")
    print(f"    URL: https://xluser-ssl.xunlei.com/v1/auth/token")
    print(f"    refresh_token: {refresh_token[:30]}...")

    try:
        response = requests.post(
            'https://xluser-ssl.xunlei.com/v1/auth/token',
            json={
                "client_id": client_id,
                "grant_type": "refresh_token",
                "refresh_token": refresh_token,
            },
            headers={
                "Content-Type": "application/json",
                "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
                "x-client-id": client_id,
                "x-device-id": device_id,
            },
            timeout=15
        )

        print(f"\n[2] HTTP状态码: {response.status_code}")
        data = response.json()
        print(f"[3] 完整响应:")
        print(json.dumps(data, indent=2, ensure_ascii=False))

        # 按照心悦盘搜方式解析
        if data.get('code', -1) == 0:
            res_data = data.get('data', {})
            access_token = res_data.get('access_token', '')
            new_refresh_token = res_data.get('refresh_token', '')
            expires_in = res_data.get('expires_in', 0)

            if access_token:
                print(f"\n✅ [OK] 成功获取Access Token!")
                print(f"    Access Token: {access_token[:30]}...")
                print(f"    新Refresh Token: {new_refresh_token[:30] if new_refresh_token else '无'}...")
                print(f"    有效期: {expires_in}秒")
                return True, access_token
            else:
                print(f"\n❌ [ERROR] 响应中缺少access_token")
                return False, None
        else:
            error_msg = data.get('error_message', data.get('message', '未知错误'))
            print(f"\n❌ [ERROR] API返回错误码: {data.get('code')}")
            print(f"    错误信息: {error_msg}")
            return False, None

    except Exception as e:
        print(f"\n❌ [EXCEPTION] 请求异常: {e}")
        import traceback
        traceback.print_exc()
        return False, None


def test_baidu_credential():
    """测试百度网盘凭证是否有效"""
    print("\n" + "=" * 60)
    print("🔍 测试百度网盘凭证")
    print("=" * 60)

    from src.db.cookie_config_dao import get_cookie_by_cloud_name
    cookie = get_cookie_by_cloud_name("百度网盘")

    if not cookie:
        print("❌ 未配置百度网盘Cookie")
        return False

    print(f"\n[INFO] Cookie长度: {len(cookie)} 字符")
    print(f"[INFO] Cookie前50字符: {cookie[:50]}...")

    # 检查关键字段
    if 'BDUSS=' in cookie:
        print("✅ 包含 BDUSS 字段")
    else:
        print("❌ 缺少 BDUSS 字段")

    if 'STOKEN=' in cookie:
        print("✅ 包含 STOKEN 字段")
    else:
        print("⚠️ 缺少 STOKEN 字段（可能导致转存失败）")

    return len(cookie) > 50


def test_quark_credential():
    """测试夸克网盘凭证是否有效"""
    print("\n" + "=" * 60)
    print("🔍 测试夸克网盘凭证")
    print("=" * 60)

    from src.db.cookie_config_dao import get_cookie_by_cloud_name
    cookie = get_cookie_by_cloud_name("夸克网盘")

    if not cookie:
        print("❌ 未配置夸克网盘Cookie")
        return False

    print(f"\n[INFO] Cookie长度: {len(cookie)} 字符")
    print(f"[INFO] Cookie前50字符: {cookie[:50]}...")

    # 检查关键字段
    if 'b-user-id=' in cookie:
        print("✅ 包含 b-user-id 字段")
    else:
        print("❌ 缺少 b-user-id 字段")

    return len(cookie) > 50


if __name__ == '__main__':
    print("\n" + "🚀" * 30)
    print("🔧 网盘API调试工具")
    print("🚀" * 30)

    # 测试迅雷
    xunlei_success, xunlei_token = test_xunlei_api()

    # 测试百度
    baidu_ok = test_baidu_credential()

    # 测试夸克
    quark_ok = test_quark_credential()

    # 总结
    print("\n" + "=" * 60)
    print("📊 测试结果总结")
    print("=" * 60)
    print(f"迅雷云盘: {'✅ 正常' if xunlei_success else '❌ 异常'}")
    print(f"百度网盘: {'✅ 凭证有效' if baidu_ok else '❌ 凭证无效'}")
    print(f"夸克网盘: {'✅ 凭证有效' if quark_ok else '❌ 凭证无效'}")
    print("=" * 60)
