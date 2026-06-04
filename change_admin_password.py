#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
快捷修改后台管理员密码工具
使用方法:
    1. 直接运行脚本，按提示输入新密码
    2. 或通过命令行传参: python change_admin_password.py "新密码"
"""

import os
import sys
from dotenv import load_dotenv

def change_admin_password(new_password: str, new_username: str = None):
    """
    修改后台管理员密码
    
    Args:
        new_password: 新密码
        new_username: 新用户名（可选，默认保持不变）
    """
    env_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), '.env')
    
    if not os.path.exists(env_path):
        print(f"❌ 错误: 找不到 .env 文件！路径: {env_path}")
        return False
    
    # 读取当前.env文件
    with open(env_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 修改密码
    import re
    # 替换密码
    content = re.sub(
        r'ADMIN_PASSWORD\s*=\s*.+', 
        f'ADMIN_PASSWORD = {new_password}',
        content
    )
    
    # 如果提供了新用户名，也修改用户名
    if new_username:
        content = re.sub(
            r'ADMIN_USERNAME\s*=\s*.+',
            f'ADMIN_USERNAME = {new_username}',
            content
        )
    
    # 写回文件
    with open(env_path, 'w', encoding='utf-8') as f:
        f.write(content)
    
    # 验证修改
    load_dotenv(override=True)
    check_password = os.getenv('ADMIN_PASSWORD')
    
    if check_password == new_password:
        print(f"\n✅ 密码修改成功！")
        username = new_username or os.getenv('ADMIN_USERNAME', 'admin')
        print(f"   用户名: {username}")
        print(f"   新密码: {new_password}")
        print(f"\n⚠️  重要提示:")
        print(f"   1. 请重启应用以使更改生效")
        print(f"   2. 请牢记新密码！")
        return True
    else:
        print(f"❌ 密码修改失败！")
        return False

if __name__ == '__main__':
    print("=" * 60)
    print("宝藏盘搜 - 管理员密码修改工具")
    print("=" * 60)
    
    # 查看当前用户名密码
    env_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), '.env')
    load_dotenv(env_path, override=True)
    current_username = os.getenv('ADMIN_USERNAME', 'admin')
    current_password = os.getenv('ADMIN_PASSWORD', 'admin123')
    
    print(f"\n当前账户信息:")
    print(f"  用户名: {current_username}")
    print(f"  密码: {current_password}")
    
    # 检查是否通过命令行传参
    new_password = None
    new_username = None
    
    if len(sys.argv) > 1:
        new_password = sys.argv[1]
    
    if not new_password:
        print("\n请输入新密码（至少6个字符）:")
        new_password = input("新密码: ").strip()
        
        if not new_password:
            print("❌ 密码不能为空！")
            sys.exit(1)
        
        if len(new_password) < 6:
            print("⚠️  提示: 密码长度过短，建议使用至少6个字符")
            confirm = input("是否继续使用此密码？(y/n): ").lower()
            if confirm != 'y':
                print("已取消操作")
                sys.exit(0)
    
    # 询问是否修改用户名
    print(f"\n是否修改用户名？(当前用户名: {current_username})")
    choice = input("是否修改？(y/n，默认n): ").lower()
    if choice == 'y':
        new_username = input("请输入新用户名: ").strip()
        if not new_username:
            print("❌ 用户名不能为空！")
            sys.exit(1)
    
    # 执行修改
    change_admin_password(new_password, new_username)
