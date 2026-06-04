import json
import requests
import urllib3

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

CLIENT_ID = "Xqp0kJBXWhwaTpB6"
DEVICE_ID = "925b7631473a13716b791d7f28289cad"

session = requests.Session()
session.verify = False
session.headers.update({
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36",
    "Accept": "application/json, text/plain, */*",
    "Accept-Language": "zh-CN,zh;q=0.9",
    "Origin": "https://pan.xunlei.com",
    "Referer": "https://pan.xunlei.com/",
    "Content-Type": "application/json",
})

print("=" * 60)
print("测试1: 获取二维码")
print("=" * 60)

try:
    resp = session.post(
        "https://pan.xunlei.com/api/v1/login/qrcode",
        json={
            "client_id": CLIENT_ID,
            "device_id": DEVICE_ID,
        },
        timeout=20,
    )
    print(f"Status: {resp.status_code}")
    print(f"Headers: {dict(resp.headers)}")
    print(f"Content-Type: {resp.headers.get('Content-Type', 'N/A')}")
    print(f"Response (前500字符): {resp.text[:500]}")
    
    # 尝试解析JSON
    try:
        data = resp.json()
        print(f"\nJSON解析成功: {json.dumps(data, ensure_ascii=False, indent=2)[:800]}")
    except Exception as e:
        print(f"\nJSON解析失败: {e}")
        print(f"原始响应: {resp.text[:1000]}")
        
except Exception as e:
    print(f"请求失败: {e}")

print("\n" + "=" * 60)
print("测试2: 使用xluser-ssl端点获取二维码")
print("=" * 60)

try:
    resp2 = session.post(
        "https://xluser-ssl.xunlei.com/v1/auth/qrcode",
        json={
            "client_id": CLIENT_ID,
            "device_id": DEVICE_ID,
        },
        timeout=20,
    )
    print(f"Status: {resp2.status_code}")
    print(f"Content-Type: {resp2.headers.get('Content-Type', 'N/A')}")
    print(f"Response (前500字符): {resp2.text[:500]}")
    
    try:
        data2 = resp2.json()
        print(f"\nJSON解析成功: {json.dumps(data2, ensure_ascii=False, indent=2)[:800]}")
    except Exception as e:
        print(f"\nJSON解析失败: {e}")
        
except Exception as e:
    print(f"请求失败: {e}")

print("\n" + "=" * 60)
print("测试3: 尝试访问迅雷云盘首页获取Cookie")
print("=" * 60)

try:
    resp3 = session.get(
        "https://pan.xunlei.com/",
        timeout=20,
    )
    print(f"Status: {resp3.status_code}")
    print(f"Set-Cookie: {resp3.headers.get('Set-Cookie', 'N/A')[:200]}")
    
    # 再试一次获取二维码
    resp4 = session.post(
        "https://pan.xunlei.com/api/v1/login/qrcode",
        json={
            "client_id": CLIENT_ID,
            "device_id": DEVICE_ID,
        },
        timeout=20,
    )
    print(f"\n第二次尝试 Status: {resp4.status_code}")
    print(f"Response (前500字符): {resp4.text[:500]}")
    
except Exception as e:
    print(f"请求失败: {e}")
