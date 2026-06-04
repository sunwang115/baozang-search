#!/usr/bin/env python3
import json
import sys
sys.path.insert(0, '.')

from src.clients.xunlei_client import XunleiDrive

# 测试凭证 - 使用用户提供的凭证（每次测试都需要重新获取）
test_credential = {
    "refresh_token": "a1.0gj1PBH2SWoLx3IP7o9_5b7v_ekFiwwX2DNzedNXpu029bIb",
    "captcha_sign": "1.fe2108ad808a74c9ac0243309242726c",
    "user_id": "864705994"
}

def test_xunlei():
    print("=" * 60)
    print("测试迅雷云盘客户端")
    print("=" * 60)
    
    # 使用原始 refresh_token 创建客户端
    client = XunleiDrive(test_credential)
    
    print(f"\n1. 测试获取access_token...")
    access_token = client._get_access_token()
    if access_token:
        print(f"   ✓ 成功获取access_token: {access_token[:30]}...")
    else:
        print(f"   ✗ 获取access_token失败")
        return
    
    print(f"\n2. 测试获取captcha_token...")
    captcha_token = client._get_captcha_token("get:/drive/v1/user/info")
    if captcha_token:
        print(f"   ✓ 成功获取captcha_token: {captcha_token[:30]}...")
    else:
        print(f"   ✗ 获取captcha_token失败")
        return
    
    print(f"\n3. 测试获取用户信息...")
    user_info = client.get_user_info()
    if user_info.get("success"):
        info = user_info.get("user_info", {})
        print(f"   ✓ 成功获取用户信息")
        print(f"     昵称: {info.get('nickname')}")
        print(f"     用户名: {info.get('username')}")
        print(f"     已用空间: {info.get('space_used')}")
        print(f"     总空间: {info.get('space_total')}")
    else:
        print(f"   ✗ 获取用户信息失败: {user_info.get('error')}")
    
    print(f"\n4. 测试获取文件列表...")
    files = client.list_files()
    if files:
        print(f"   ✓ 成功获取文件列表, 共 {len(files)} 个文件夹")
        for f in files[:5]:
            print(f"     - {f.get('name')} (id: {f.get('id')[:10]}...)")
    else:
        print(f"   ✗ 获取文件列表失败或没有文件夹")
    
    print("\n" + "=" * 60)
    print("测试完成")
    print("=" * 60)
    print("\n提示: refresh_token 每次使用后会被服务器刷新，下次测试需要使用新的refresh_token")

if __name__ == "__main__":
    test_xunlei()