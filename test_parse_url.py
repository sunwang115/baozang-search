#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
测试链接解析逻辑
"""

import re

test_url = "https://pan.baidu.com/s/1-Ymb_ziMlMAMs0N-3d4mtA?pwd=9527"

print("=" * 70)
print("链接解析测试")
print("=" * 70)
print(f"测试链接: {test_url}")
print()

# 当前实现（错误）
print("【当前实现 - 错误】")
match1 = re.search(r"/s/1([a-zA-Z0-9_-]+)", test_url)
if match1:
    surl1 = match1.group(1)
    print(f"   正则: /s/1([a-zA-Z0-9_-]+)")
    print(f"   surl: {surl1}")
    print(f"   ❌ 问题: 去掉了开头的 1")

pwd_match = re.search(r"[?&]pwd=([a-zA-Z0-9]{4})", test_url)
if pwd_match:
    pwd = pwd_match.group(1)
    print(f"   pwd:  {pwd}")

print()

# 心悦盘搜的实现
print("【心悦盘搜实现 - Transfer.php L61】")
substring = strstr = test_url.split('/s/')[1] if '/s/' in test_url else ''
pwd_id = substring.split('#')[0] if '#' in substring else substring
print(f"   substr($url, 25, 23) 方式")
print(f"   surl (应该包含开头的1): {pwd_id}")
print(f"   ✅ 正确: surl 应该是 '1-Ymb_ziMlMAMs0N-3d4mtA'")

print()

# 正确的正则
print("【正确的正则表达式】")
match2 = re.search(r"/s/([a-zA-Z0-9_-]+)", test_url)
if match2:
    surl2 = match2.group(1)
    print(f"   正则: /s/([a-zA-Z0-9_-]+)")
    print(f"   surl: {surl2}")
    print(f"   ✅ 正确: 包含完整的 surl")

print()
print("=" * 70)
print("结论:")
print("=" * 70)
print("❌ 当前错误: surl = '-Ymb_ziMlMAMs0N-3d4mtA' (缺少开头的1)")
print("✅ 应该改为: surl = '1-Ymb_ziMlMAMs0N-3d4mtA' (包含完整的)")
print()

def strstr(s, delim):
    """模拟 PHP 的 strstr 函数"""
    parts = s.split(delim, 1)
    return parts[1] if len(parts) > 1 else ''

# 验证心悦的 surl 截取方式
link_url = "https://pan.baidu.com/s/1-Ymb_ziMlMAMs0N-3d4mtA"
print("心悦 BaiduWork.php verifyPassCode() L120:")
print(f"   'surl' => substr($linkUrl, 25, 23)")
print(f"   linkUrl 前30个字符: '{link_url[:30]}'")
print(f"   从第25位截取: '{link_url[25:48]}'")
