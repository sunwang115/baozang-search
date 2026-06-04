#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
初始化默认网盘凭证 - 只需运行一次
将凭证保存到数据库，重启服务后自动加载
"""

import sys
import os

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from src.db.cookie_config_dao import save_cookie
from src.db.system_config_dao import set_config_value, get_system_config, update_system_config
import json


def init_default_credentials():
    """初始化默认网盘凭证"""

    print("=" * 60)
    print("开始初始化默认网盘凭证...")
    print("=" * 60)

    # 1. 夸克网盘 Cookie
    quark_cookie = """b-user-id=0af3cff3-e84b-3c8f-ba09-bd5fab7cb80a; b-user-id=0af3cff3-e84b-3c8f-ba09-bd5fab7cb80a; _UP_A4A_11_=wb9c816922c042ed8b267e75237cc7a; _qk_bx_ck_v1=eyJkZXZpY2VJZCI6ImVDeSNBQU5Wb3Qybm1JTWdxYjNhNFpWZldWN0UranlqQXZWLzFzWnFYRUFjQnY0NktqVjRuMkFVNFZzdlQyNkZ2SzFMNGVjPSIsImRldmljZUZpbmdlcnByaW50IjoiYjNiNzM3NjM2NDc3YmVhYjhhODhkYTUxZWJmYzc2NjgifQ==; __wpkreporterwid_=30fae3e6-3f61-41b2-ab25-098203f89f90; isg=BOzse61Sqfl83byF5TvwD1xCvcoepZBPaTf_g0YsHxc6UY1bbrYi3iipdRlpWcin; tfstk=g7LIctYcEJ2CsihKeJlaCuK6rw_WrfuVJ71JiQUUwwQpwa91Q6rExgkWfLpNpy7Ly__ONseLpkBd6z15E9QyY95JCQpKt_lHPh4WiQYEtalh-BblyxkquUOHta2WQZN9R5BOiCU8vznNWauanRHquqRKv6by6x-EwhUCZ_QR9gBd6f1hB6CLJLBOXsC4paQJef_OZ6wLeaU8W5CABTQRyLdt1_XO9aQJeCh1ZAXoC1mCpBG4ToURZSoKHOU8yF1CXcRdBOBia6ICHBBsHxL_dM6v9Oa-peXFsT6MkAo6sK-pL1vSlA_vmdT5DagQn6t9GNBFk2NhHe5Wg3Ojh85MvpTOVFloxCT5diLdfWGpOaCJegtihr5C8hsXRHcuBBpVdnQHaSMe1it1m1ITNkQe0I8lDe3QnOScNds2AxaBHgWQuti2euN1mz113fG_qu2kPKlqrCoh2MCG_Els1JZlv1f13fG_qujds1Sq1fwQq; ctoken=7fqY_mz1p8lbJUN4Nc2KdW2m; grey-id=5be1b5a2-900d-787f-589f-8e62fc307090; grey-id.sig=eF5imx6XDicGDWDW0qBUyA353AxuFcIBaE-oa2yYeBQ; isQuark=true; isQuark.sig=hUgqObykqFom5Y09bll94T1sS9abT1X-4Df_lzgl8nM; _UP_F7E_8D_=iN3APNXwvEUG6F5itR%2FMgUPwKLOVbxJPcg0RzQPI6KmBtV6ZMgPh38l93pgubgHDQqhaZ2Sfc0qv%2BRantbfg1mWGAUpRMP4RqXP78Wvu%2FCfvkWWGc5NhCTV71tGOIGgDBR3%2Bu6%2Fjj47JRCxwKwP6RmtElYpAcMk%2FdjkhOclrgipqYAbrjqRo9YuUE9%2Fs5crDEn21dZLBeV8KDgX3rZm5ynXFp0eWhNFr9QQ6CCd7Fv6A1Bd%2BujS5RSU1VZu4DtwRoAg3J36dS9aj1m9P204NQdNf5Nyo3ldtw6TWtrcg0yJducQVbH%2BT5yM6TQ0ySWQ88mFyMhj2VouQ%2B%2BFKM%2B0tL1ggY93VJqD%2BguZ2Gmw5X%2FVXG5%2BATr9eEKxIvk7CLNVTZPG%2BMXyVR0GjxobkrXAZ3eIMTE7RyZru; _UP_D_=pc; __pus=2ba2735abc0d57d6e06616c005c6cb9bAAT9lBt4MVqrip7J+/AJgslxYrkoW+ScHFdilM4cmOhq2l4hNau8orKaBUQ5ku1vJpOV5BRTZ45Z30aRcY7c6g7J; __kp=cf042800-16af-11f1-b7bc-cb112264df22; __kps=AAQRbIhO3EiNSJOV9JTk/Gde; __ktd=qAhblNG60jw5YHE40mNRBQ==; __uid=AAQRbIhO3EiNSJOV9JTk/Gde; web-grey-id=6121e1d5-0b7f-24a1-7ce2-b19d68b00bc7; web-grey-id.sig=SHhnzDKh666sv9iPbWSCNV4mg4z-RmQxQ11MaxlYjZ8; __puus=5ea0954fe828c10ba2747fd3cf0dc992AASXZVN8M5tn8slQWIn4KF0Ua7uEEH/bbT26ivIilWQ3VtH/0mdtVEKZHmCbmrFYzuRI7efXbG2F0AVMcMdGr4mM9wbH/8VhfBoVUdeiOQKBVh9RH3OtI4M7svLaD6EVbw85PhMyM2qhVubFc6RIw3hk3c/6tDCL9XEJxhBOHWJnHeBeOuPKY1mTqATFkwrrNP4rn8vEl22ksZnfeYPxCp/h"""

    success, message = save_cookie("夸克网盘", quark_cookie)
    print(f"[{'OK' if success else 'FAIL'}] 夸克网盘: {message}")

    # 2. 百度网盘 Cookie
    baidu_cookie = """XFI=6ed72cde-f6a0-e932-e2e0-08f58c0e2f30; XFCS=C4F5EC2A1E7FEACA1B358105EE9B98EF68E04DE8C844A5C246A19B284691A2B0; XFT=Wxl3bjjQWrOox1oMxnGK0jQjhj/7NloGUuqNlwetHos=; BAIDUID=72BF523A47A3FC9344C577AEEEF0A6D5:FG=1; PANWEB=1; BIDUPSID=72BF523A47A3FC9344C577AEEEF0A6D5; PSTM=1746363719; __bid_n=196a4d391247472aa64a79; Hm_lvt_f5f83a6d8b15775a02760dc5f490bc47=1746951167; BAIDUID_BFESS=72BF523A47A3FC9344C577AEEEF0A6D5:FG=1; ZFY=lCT9jAvidDPahRQIhgY9EhY95uV3pCSX7H1Hb0OB9SM:C; Hm_lvt_d5bdc9eee733100f7b952fc44f7e53e4=1758112105; scholar_new_detail=1; H_WISE_SIDS=63144_65245_65313_65361_65616_65759_65789_65787_65916_65930_65941_65962_65966_65986_65995_66075_66121_65866_66146_66028_66026_66017_66025_66209_66224_66180_66242_66163_66021; H_PS_PSSID=63144_65313_66224_66242_66384_66278_66393_66529_66571_66585_66594_66604_66654_66679_66666_66692_66688_66625_66784_66792_66800_66804_66846_66859_66599_66606; H_WISE_SIDS_BFESS=63144_65245_65313_65616_65759_65789_65787_65916_65930_65941_65962_65966_65986_65995_66075_66121_65866_66146_66028_66026_66017_66025_66209_66224_66180_66242_66163_66021; ploganondeg=1; BDUSS=VlTUY2VXF6cGZpQnA0SmFFRy1IQzZ6NHk0bmNMVUI3bDNtREVlM2FvSFR2bWhwSVFBQUFBJCQAAAAAAQAAAAEAAABOrI4~TXK3ubeyAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANMxQWnTMUFpT1; BDUSS_BFESS=VlTUY2VXF6cGZpQnA0SmFFRy1IQzZ6NHk0bmNMVUI3bDNtREVlM2FvSFR2bWhwSVFBQUFBJCQAAAAAAQAAAAEAAABOrI4~TXK3ubeyAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANMxQWnTMUFpT1; BDCLND=Lfw2%2Buy1iJOzckL0tfLyevFL7WHkSnnySe4xgRmfYX4%3D; Hm_lvt_7a3960b6f067eb0085b7f96ff5e660b0=1765774250,1765879843,1766733656,1767528622; csrfToken=Qp81TSuCzlWtUA2VfEEiTQQQ; STOKEN=b3879e1c34c4523950038f089e11d8941ddd6297dc3cbe2006123dd99f25b09e; newlogin=1; Hm_lvt_182d6d59474cf78db37e0b2248640ea5=1768616828; PANPSC=2658090461304739962%3Au9Rut0jYI4p1Lc1PWfEuflcS2d9ns3O5C61tf8CKQkivckc4dgvOGiA9YKyMd6JEz81ttRoL0tCck0T9AttkQeJEKVZg82vZhCZcpYfg%2FmKm9nIjXkgSmNnzWX47O8AW9o%2BE1b88CJDsGg%2BXSX44rXOL0XXkgcvM%2BwocAWIasjJmIVNcupn0qbtbT0VT6%2BsulR186M70GuG8xj1HgqefBj8wiMwJwiZ6tow0MobT%2FrQBn8hls6JMqUPoL2UZQcsBgGvs%2BMTL2OKnHB5Bo0NTScTuA0RlVF53krFWWqsgPEw%3D; Hm_lpvt_182d6d59474cf78db37e0b2248640ea5=1768616830; ndut_fmt=EB31B5F9E524CC97BE60FBC9A36C9190EBCA73B19623FA161420D12703CC826E; ab_sr=1.0.1_YTY3MDc5YzgzZGFhYjk5ZTNlMWFhYWM1MDg4MWM0MTMwYTdlNWNjY2QzZDk5OWEzZGU1MDQ1MzNhZWVmZDFhYzZmZjkwYWViMDgwNGRhMzYxNzcxN2ZlY2E3ODQxYmI3NTM4ZTA1ZjIzOGMwM2ZhZDhlMjE5NWUxNjVjMGMyYzYzMGIyYTQ0NjUwZjcxMmJjOWJmYmVmOGU0ZDIyYjVmNDI5ZjI4MmVlODNkMDM5N2UyYWRjZTgzZDJlMjZjM2I1"""

    success, message = save_cookie("百度网盘", baidu_cookie)
    print(f"[{'OK' if success else 'FAIL'}] 百度网盘: {message}")

    # 3. UC网盘 Cookie
    uc_cookie = """UDRIVE_TRANSFER_SESS=uAvENYdZt664_QuYMp9S7p36MVSKWtaaa3eT1Xa61Sny8lS9YrgPjp4nRxBmY-BswJzZIh-R_GWfyfCSHA_3leSXXJL-zhSjZXbQiAgoALB8M49AYWSveJwCOJ1RhShyZCgeI1htutxBuiSASPtAlj5-xopYK7DZLWLIslCf5xge54Z17ytcZ_Np22uOrKa6; b-user-id=c2e7263b-efeb-df8e-bbaa-4a608df07ac7; ctoken=kBkY1z6wa4X_21dn-Q_VwoY7; __itrace_wid=10a09b8e-2e69-4bfc-baf0-1dde267d48d2; Hm_lvt_d2853e18bbb01bff13374d73c9fd1e3d=1778920077; HMACCOUNT=E37EAEE46BCF56B6; __pus=9468a1575188cf9830d0c82ad75095e5AATqK6hT9o5jGpAxqMJP47S4/UmHGBepmiublB71De7YEcUpdbDkZtix9+Xq+lDPwMLiM5ITq5FaCbBKU79QB1/G; __kp=2b21ab40-5101-11f1-a7bc-9379d2318daa; __kps=AASfQ9yGVzBjWT8FWp1xbHDn; __ktd=/S0XgMpiNPB4Eqa3bWWgdA==; __uid=AASfQ9yGVzBjWT8FWp1xbHDn; Hm_lpvt_d2853e18bbb01bff13374d73c9fd1e3d=1778920089; __puus=9a8ef55c84c56e6cae29c96ff2abcb12AAQFdnJWRjW3/r2iYmmF+ewJ0Z8JqmZMToQEl0abs1IhwUhxkpFHs2vsEVznx2SRAd/YYDRW7r7FkS0F+ca7dC1GBUgF0LXc71XETFyKYW60aiCNW0E2V82CClr9cR5uNemTeW1P8w8z08uhsCmHtDtOT7kKjkjkmq4wjTtckZu4/KPO1ct7OJYijrccFJkDTeY="""

    success, message = save_cookie("UC网盘", uc_cookie)
    print(f"[{'OK' if success else 'FAIL'}] UC网盘: {message}")

    # 4. 迅雷云盘 Refresh Token (只需要refresh_token)
    xunlei_refresh_token = "a1.3RxJlJVMQGoILDwNqjKf2aNZIm2GWRHD9AJPz1i4qgLJvMKJ"
    
    # 构建JSON格式（包含默认的captcha_sign和user_id）
    xunlei_credential = json.dumps({
        "refresh_token": xunlei_refresh_token,
        "captcha_sign": "1.fe2108ad808a74c9ac0243309242726c",  # 默认值
        "user_id": "0"  # 默认值
    }, ensure_ascii=False)

    success, message = save_cookie("迅雷网盘", xunlei_credential)
    print(f"[{'OK' if success else 'FAIL'}] 迅雷云盘: {message}")

    # 5. 设置默认目录配置
    default_dirs = {
        'baidu_default_dir': '/影视',
        'baidu_temp_dir': '/影视',
        'quark_default_dir': '',
        'quark_temp_dir': '',
        'aliyun_default_dir': '',
        'aliyun_temp_dir': '',
        'uc_default_dir': '',
        'uc_temp_dir': '',
        'xunlei_default_dir': '',
        'xunlei_temp_dir': '',
    }

    for key, value in default_dirs.items():
        update_system_config(key, value)
        print(f"[OK] 设置默认目录: {key} = {value or '(根目录)'}")

    print("=" * 60)
    print("✅ 默认凭证初始化完成！")
    print("=" * 60)
    print("\n提示：")
    print("- 重启服务后，这些凭证会自动加载")
    print("- 你可以在前端界面修改这些凭证")
    print("- 迅雷云盘只需要 refresh_token，其他字段使用默认值")


if __name__ == '__main__':
    init_default_credentials()
