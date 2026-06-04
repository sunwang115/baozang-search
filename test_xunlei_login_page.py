import requests
import urllib3
import json

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

session = requests.Session()
session.verify = False

# 先访问登录页面获取必要的Cookie和页面内容
print("=" * 60)
print("步骤1: 访问迅雷云盘登录页面")
print("=" * 60)

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
    "Accept-Language": "zh-CN,zh;q=0.9",
}

try:
    resp = session.get("https://pan.xunlei.com/login", headers=headers, timeout=20, allow_redirects=True)
    print(f"Status: {resp.status_code}")
    print(f"URL: {resp.url}")
    print(f"Cookies: {session.cookies.get_dict()}")
    
    # 检查页面内容中是否有二维码相关API
    if "qrcode" in resp.text.lower() or "qr_code" in resp.text.lower():
        print("\n页面中包含二维码相关代码")
        # 提取可能的API地址
        import re
        api_patterns = re.findall(r'https?://[^\s"\'<>]+api[^\s"\'<>]*', resp.text)
        if api_patterns:
            print(f"找到的可能API地址: {list(set(api_patterns))[:10]}")
    
except Exception as e:
    print(f"请求失败: {e}")

# 尝试访问首页
print("\n" + "=" * 60)
print("步骤2: 访问迅雷云盘首页")
print("=" * 60)

try:
    resp2 = session.get("https://pan.xunlei.com/", headers=headers, timeout=20)
    print(f"Status: {resp2.status_code}")
    print(f"Cookies: {session.cookies.get_dict()}")
except Exception as e:
    print(f"请求失败: {e}")

# 尝试不同的API端点
print("\n" + "=" * 60)
print("步骤3: 尝试不同的二维码API端点")
print("=" * 60)

endpoints = [
    "https://pan.xunlei.com/api/v1/auth/qrcode",
    "https://pan.xunlei.com/api/auth/qrcode",
    "https://pan.xunlei.com/v1/auth/qrcode",
    "https://api-pan.xunlei.com/v1/auth/qrcode",
    "https://xluser-ssl.xunlei.com/v1/auth/qrcode",
    "https://pan.xunlei.com/api/qrcode",
]

for endpoint in endpoints:
    try:
        resp = session.post(
            endpoint,
            json={"client_id": "Xqp0kJBXWhwaTpB6", "device_id": "925b7631473a13716b791d7f28289cad"},
            headers={
                "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36",
                "Content-Type": "application/json",
                "Origin": "https://pan.xunlei.com",
                "Referer": "https://pan.xunlei.com/",
            },
            timeout=10,
        )
        print(f"\n{endpoint}")
        print(f"  Status: {resp.status_code}")
        print(f"  Response: {resp.text[:200]}")
    except Exception as e:
        print(f"\n{endpoint}")
        print(f"  Error: {e}")
