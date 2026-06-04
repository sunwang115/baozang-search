import requests
import json
import urllib3

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# 用户提供的token
refresh_token = "a1.p1kRvM8CtWoKkr4N9JQiiUAcAsPJN6PbSbhn55_CqgNMQN2q"

client_id = "Xqp0kJBXWhwaTpB6"
device_id = "925b7631473a13716b791d7f28289cad"

print("=" * 60)
print("测试迅雷token验证")
print("=" * 60)

# 方法1：使用当前代码的请求头
print("\n方法1：当前代码的请求头（带x-client-id/x-device-id）")
try:
    resp = requests.post(
        'https://xluser-ssl.xunlei.com/v1/auth/token',
        json={
            "client_id": client_id,
            "grant_type": "refresh_token",
            "refresh_token": refresh_token,
        },
        headers={
            "Content-Type": "application/json",
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36",
            "x-client-id": client_id,
            "x-device-id": device_id,
        },
        timeout=15,
        verify=False
    )
    print(f"Status: {resp.status_code}")
    print(f"Response: {json.dumps(resp.json(), ensure_ascii=False, indent=2)[:500]}")
except Exception as e:
    print(f"Error: {e}")

# 方法2：参照心悦盘搜，不带x-client-id/x-device-id
print("\n方法2：不带x-client-id/x-device-id（参照心悦盘搜）")
try:
    resp = requests.post(
        'https://xluser-ssl.xunlei.com/v1/auth/token',
        json={
            "client_id": client_id,
            "grant_type": "refresh_token",
            "refresh_token": refresh_token,
        },
        headers={
            "Content-Type": "application/json",
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36",
        },
        timeout=15,
        verify=False
    )
    print(f"Status: {resp.status_code}")
    print(f"Response: {json.dumps(resp.json(), ensure_ascii=False, indent=2)[:500]}")
except Exception as e:
    print(f"Error: {e}")

# 方法3：使用完整的headers（参照心悦盘搜urlHeader）
print("\n方法3：使用完整的headers列表（参照心悦盘搜）")
try:
    headers = [
        'Accept: */*',
        'Accept-Encoding: gzip, deflate',
        'Accept-Language: zh-CN,zh;q=0.9',
        'Cache-Control: no-cache',
        'Content-Type: application/json',
        'Origin: https://pan.xunlei.com',
        'Pragma: no-cache',
        'Referer: https://pan.xunlei.com/',
        'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36',
    ]
    
    resp = requests.post(
        'https://xluser-ssl.xunlei.com/v1/auth/token',
        json={
            "client_id": client_id,
            "grant_type": "refresh_token",
            "refresh_token": refresh_token,
        },
        headers={h.split(':')[0].strip(): h.split(':', 1)[1].strip() for h in headers},
        timeout=15,
        verify=False
    )
    print(f"Status: {resp.status_code}")
    print(f"Response: {json.dumps(resp.json(), ensure_ascii=False, indent=2)[:500]}")
except Exception as e:
    print(f"Error: {e}")
