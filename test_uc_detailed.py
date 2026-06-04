#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
详细测试UC网盘转存
"""

import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from src.clients.uc_client import UcDrive
from src.db.cookie_config_dao import get_cookie_by_cloud_name
import logging

logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

def test_uc_transfer():
    """详细测试UC网盘转存"""

    print("\n" + "=" * 70)
    print("UC网盘转存详细测试")
    print("=" * 70)

    # 1. 获取Cookie
    cookie = get_cookie_by_cloud_name("UC网盘")
    if not cookie:
        print("❌ 未配置UC网盘Cookie")
        return False

    print(f"\n[步骤1] Cookie长度: {len(cookie)}")

    # 2. 初始化客户端
    print(f"\n[步骤2] 初始化UC网盘客户端...")
    uc = UcDrive(cookie)

    # 3. 测试链接（从截图获取的）
    test_url = "https://drive.uc.cn/s/ce0c650982e64?public=1"
    target_dir = "0"

    print(f"\n[步骤3] 开始转存测试:")
    print(f"   分享链接: {test_url}")
    print(f"   目标目录: {target_dir}")

    try:
        # 4. 执行转存
        print(f"\n[DEBUG] 调用 store()...")
        file_id, file_name, share_url = uc.store(test_url, target_dir)

        print(f"\n{'=' * 70}")
        print(f"📊 转存结果:")
        print(f"{'=' * 70}")
        print(f"   file_id: {file_id}")
        print(f"   file_name: {file_name}")
        print(f"   share_url: {share_url}")

        if file_id and share_url:
            print(f"\n✅✅✅ 转存成功！")
            return True
        else:
            print(f"\n❌❌❌ 转存失败!")
            return False

    except Exception as e:
        print(f"\n❌ 转存过程异常: {e}")
        import traceback
        traceback.print_exc()
        return False

if __name__ == '__main__':
    success = test_uc_transfer()
    sys.exit(0 if success else 1)
