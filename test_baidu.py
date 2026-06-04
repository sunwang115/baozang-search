#!/usr/bin/env python3
"""
百度网盘API测试脚本
用于调试目录获取问题 - 使用新的重写版本
"""

import sys
import os

# 添加项目根目录到路径
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from src.clients.baidu_client import Baidu

def test_baidu_api():
    """测试百度网盘API"""

    # 测试Cookie（请替换为您的实际Cookie）
    test_cookie = """
    ndut_fmt=EB31B5F9E524CC97BE60FEBC9A36C9190EEBCA73B19623FA161420D12703CC826E;
    ab_sr=1.0.1._YTY3MDc5YzgzZGFhYjk5ZTNlMWFhYW1MDg4MWM0MTMwYTdlNWNjY2QzZDk5OWEzZGU1MDQ1MzNhZWVmZDHYZmZmjkwYWIvMDgwNGRhMzYxNzcxN2ZlY2E3ODQxYmI3NTM4ZTA1NjJkN2U5NWUXNjVjMGMyYzYzMGIyYTQ0NjUwODNyYTM4NzM8NzUwZfjc1MmMjOWJmVmOGU0ZDIyYjVmNDI5ZjI4MmVI
    """

    print("\n" + "="*70)
    print("🧪 百度网盘API测试 (新版本 - 参照心悦盘搜)")
    print("="*70 + "\n")

    try:
        print("📦 步骤1: 初始化百度网盘客户端...")
        print("   注意: 构造函数不获取bdstoken（与心悦盘搜一致）\n")
        client = Baidu(cookie=test_cookie.strip())
        print()

        print("📂 步骤2: 直接调用 get_dir_list('/') 获取根目录...")
        print("   （不先获取bdstoken，与心悦盘搜BaiduPan.php一致）\n")
        folders = client.get_dir_list('/')

        print(f"\n📊 获取结果:")
        print(f"   文件夹数量: {len(folders)}")

        if folders:
            print(f"\n✅ 成功获取文件夹列表:")
            for i, folder in enumerate(folders[:10], 1):
                name = folder.get('server_filename', folder.get('filename', '未知'))
                path = folder.get('path', '')
                isdir = folder.get('isdir')
                print(f"   [{i:2d}] {name}")
                print(f"       路径: {path}")
                print(f"       isdir: {isdir}")
                print()
        else:
            print(f"\n⚠️ 未获取到任何文件夹!")
            print(f"可能原因:")
            print(f"  1. Cookie无效或已过期")
            print(f"  2. 网络连接问题")
            print(f"  3. 百度网盘风控限制")

        print("="*70 + "\n")
        return len(folders) > 0

    except Exception as e:
        import traceback
        print(f"\n❌ 测试失败!")
        print(f"错误类型: {type(e).__name__}")
        print(f"错误信息: {str(e)}")
        print(f"\n完整堆栈信息:")
        traceback.print_exc()
        print("="*70 + "\n")
        return False

if __name__ == "__main__":
    success = test_baidu_api()
    sys.exit(0 if success else 1)
