-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- 主机： 127.0.0.1
-- 生成日期： 2026-06-04 07:31:15
-- 服务器版本： 10.4.32-MariaDB
-- PHP 版本： 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 数据库： `baozangsearch`
--

-- --------------------------------------------------------

--
-- 表的结构 `api_config`
--

CREATE TABLE `api_config` (
  `id` int(11) NOT NULL COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT 'API 名称',
  `url` varchar(255) NOT NULL COMMENT 'API URL',
  `method` varchar(10) NOT NULL COMMENT '请求方法 (GET/POST)',
  `request` text DEFAULT NULL COMMENT '原始请求参数 (JSON 字符串)',
  `response` varchar(255) DEFAULT NULL COMMENT '响应数据解析路径',
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'API 状态 (1=true, 0=false)',
  `response_time_ms` int(11) DEFAULT 0 COMMENT '最近一次测试响应时间（毫秒）',
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '启用状态：1为启用，0为禁用',
  `created_at` datetime DEFAULT current_timestamp() COMMENT '创建时间',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='API 配置信息表';

--
-- 转存表中的数据 `api_config`
--

INSERT INTO `api_config` (`id`, `name`, `url`, `method`, `request`, `response`, `status`, `response_time_ms`, `is_enabled`, `created_at`, `updated_at`) VALUES
(17, '官方接口', 'http://47.113.216.40:5004/api?keyword=[[keyword]]', 'get', '', 'results[*].[name, share_link]', 1, 4998, 1, '2026-05-28 18:27:39', '2026-06-04 08:26:55');

-- --------------------------------------------------------

--
-- 表的结构 `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '分类名称',
  `icon` varchar(100) DEFAULT NULL COMMENT '分类图标 (Font Awesome 类名)',
  `sort_order` int(11) NOT NULL DEFAULT 0 COMMENT '排序权重，越大越靠前',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '更新时间',
  `data_source` varchar(50) DEFAULT NULL COMMENT '外部数据源标识(如dianying/dianshiju等)，为空则只显示本地资源',
  `external_limit` int(11) DEFAULT 20 COMMENT '外部数据源获取数量，默认20条'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='资源分类管理表';

--
-- 转存表中的数据 `categories`
--

INSERT INTO `categories` (`id`, `name`, `icon`, `sort_order`, `created_at`, `updated_at`, `data_source`, `external_limit`) VALUES
(1, '电视剧', 'fas fa-tv', 2, '2026-05-14 11:05:34', '2026-05-16 03:25:34', 'dianshiju', 20),
(2, '电影', 'fas fa-film', 90, '2026-05-14 11:05:34', '2026-05-20 11:11:21', 'dianying', 19),
(3, '综艺', 'fas fa-star', 80, '2026-05-14 11:05:34', '2026-05-25 03:03:20', 'zongyi', 29),
(4, '动漫', 'fas fa-dragon', 70, '2026-05-14 11:05:34', '2026-05-16 03:25:28', 'dongman', 20),
(5, '音乐', 'fas fa-music', 60, '2026-05-14 11:05:34', '2026-05-14 11:05:34', NULL, 20),
(6, '软件', 'fas fa-laptop-code', 50, '2026-05-14 11:05:34', '2026-05-14 11:05:34', NULL, 20),
(7, '文档', 'fas fa-file-alt', 40, '2026-05-14 11:05:34', '2026-05-14 11:05:34', NULL, 20),
(8, '5662', '', 0, '2026-05-14 11:26:42', '2026-05-14 11:26:42', NULL, 20);

-- --------------------------------------------------------

--
-- 表的结构 `cookie_config`
--

CREATE TABLE `cookie_config` (
  `id` int(11) NOT NULL COMMENT '主键',
  `cloud_name` varchar(100) NOT NULL COMMENT '云盘名称',
  `cookie` text NOT NULL COMMENT 'Cookie内容',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='云盘Cookie配置表';

--
-- 转存表中的数据 `cookie_config`
--

INSERT INTO `cookie_config` (`id`, `cloud_name`, `cookie`, `created_at`, `updated_at`) VALUES
(45, '迅雷网盘', 'a1.FzzuG3nz7WoNdxkP082RM9hJEf3TFgzl9ZGyNn9z71fp8o8O', '2026-05-20 08:56:42', '2026-05-20 08:56:42'),
(49, '百度网盘', 'XFI=6ed72cde-f6a0-e932-e2e0-08f58c0e2f30; XFCS=C4F5EC2A1E7FEACA1B358105EE9B98EF68E04DE8C844A5C246A19B284691A2B0; XFT=Wxl3bjjQWrOox1oMxnGK0jQjhj/7NloGUuqNlwetHos=; BAIDUID=72BF523A47A3FC9344C577AEEEF0A6D5:FG=1; PANWEB=1; BIDUPSID=72BF523A47A3FC9344C577AEEEF0A6D5; PSTM=1746363719; __bid_n=196a4d391247472aa64a79; Hm_lvt_f5f83a6d8b15775a02760dc5f490bc47=1746951167; BAIDUID_BFESS=72BF523A47A3FC9344C577AEEEF0A6D5:FG=1; ZFY=lCT9jAvidDPahRQIhgY9EhY95uV3pCSX7H1Hb0OB9SM:C; Hm_lvt_d5bdc9eee733100f7b952fc44f7e53e4=1758112105; scholar_new_detail=1; H_WISE_SIDS=63144_65245_65313_65361_65616_65759_65789_65787_65916_65930_65941_65962_65966_65986_65995_66075_66121_65866_66146_66028_66026_66017_66025_66209_66224_66180_66242_66163_66021; H_PS_PSSID=63144_65313_66224_66242_66384_66278_66393_66529_66571_66585_66594_66604_66654_66679_66666_66692_66688_66625_66784_66792_66800_66804_66846_66859_66599_66606; H_WISE_SIDS_BFESS=63144_65245_65313_65361_65616_65759_65789_65787_65916_65930_65941_65962_65966_65986_65995_66075_66121_65866_66146_66028_66026_66017_66025_66209_66224_66180_66242_66163_66021; ploganondeg=1; BDUSS=VlTUY2VXF6cGZpQnA0SmFFRy1IQzZ6NHk0bmNMVUI3bDNtREVlM2FvSFR2bWhwSVFBQUFBJCQAAAAAAQAAAAEAAABOrI4~TXK3ubeyAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANMxQWnTMUFpT1; BDUSS_BFESS=VlTUY2VXF6cGZpQnA0SmFFRy1IQzZ6NHk0bmNMVUI3bDNtREVlM2FvSFR2bWhwSVFBQUFBJCQAAAAAAQAAAAEAAABOrI4~TXK3ubeyAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAANMxQWnTMUFpT1; BDCLND=Lfw2%2Buy1iJOzckL0tfLyevFL7WHkSnnySe4xgRmfYX4%3D; Hm_lvt_7a3960b6f067eb0085b7f96ff5e660b0=1765774250,1765879843,1766733656,1767528622; csrfToken=Qp81TSuCzlWtUA2VfEEiTQQQ; STOKEN=b3879e1c34c4523950038f089e11d8941ddd6297dc3cbe2006123dd99f25b09e; newlogin=1; Hm_lvt_182d6d59474cf78db37e0b2248640ea5=1768616828; PANPSC=2658090461304739962%3Au9Rut0jYI4p1Lc1PWfEuflcS2d9ns3O5C61tf8CKQkivckc4dgvOGiA9YKyMd6JEz81ttRoL0tCck0T9AttkQeJEKVZg82vZhCZcpYfg%2FmKm9nIjXkgSmNnzWX47O8AW9o%2BE1b88CJDsGg%2BXSX44rXOL0XXkgcvM%2BwocAWIasjJmIVNcupn0qbtbT0VT6%2BsulR186M70GuG8xj1HgqefBj8wiMwJwiZ6tow0MobT%2FrQBn8hls6JMqUPoL2UZQcsBgGvs%2BMTL2OKnHB5Bo0NTScTuA0RlVF53krFWWqsgPEw%3D; Hm_lpvt_182d6d59474cf78db37e0b2248640ea5=1768616830; ndut_fmt=EB31B5F9E524CC97BE60FBC9A36C9190EBCA73B19623FA161420D12703CC826E; ab_sr=1.0.1_YTY3MDc5YzgzZGFhYjk5ZTNlMWFhYWM1MDg4MWM0MTMwYTdlNWNjY2QzZDk5OWEzZGU1MDQ1MzNhZWVmZDFhYzZmZjkwYWViMDgwNGRhMzYxNzcxN2ZlY2E3ODQxYmI3NTM4ZTA1ZjIzOGMwM2ZhZDhlMjE5NWUxNjVjMGMyYzYzMGIyYTQ0NjUwZjcxMmJjOWJmYmVmOGU0ZDIyYjVmNDI5ZjI4MmVlODNkMDM5N2UyYWRjZTgzZDJlMjZjM2I1', '2026-05-20 09:19:31', '2026-05-20 09:19:31'),
(50, '夸克网盘', 'b-user-id=0af3cff3-e84b-3c8f-ba09-bd5fab7cb80a; b-user-id=0af3cff3-e84b-3c8f-ba09-bd5fab7cb80a; _UP_A4A_11_=wb9c816922c042ed8b267e75237cc7a3; _qk_bx_ck_v1=eyJkZXZpY2VJZCI6ImVDeSNBQU5Wb3Qybm1JTWdxYjNhNFpWZldWN0UranlqQXZWLzFzWnFYRUFjQnY0NktqVjRuMkFVNFZzdlQyNkZ2SzFMNGVjPSIsImRldmljZUZpbmdlcnByaW50IjoiYjNiNzM3NjM2NDc3YmVhYjhhODhkYTUxZWJmYzc2NjgifQ==; __wpkreporterwid_=30fae3e6-3f61-41b2-ab25-098203f89f90; isg=BOzse61Sqfl83byF5TvwD1xCvcoepZBPaTf_g0YsHxc6UY1bbrYi3iipdRlpWcin; tfstk=g7LIctYcEJ2CsihKeJlaCuK6rw_WrfuVJ71JiQUUwwQpwa91Q6rExgkWfLpNpy7Ly__ONseLpkBd6z15E9QyY95JCQpKt_lHPh4WiQYEtalh-BblyxkquUOHta2WQZN9R5BOiCU8vznNWauanRHquqRKv6by6x-EwhUCZ_QR9gBd6f1hB6CLJLBOXsC4paQJef_OZ6wLeaU8W5CABTQRyLdt1_XO9aQJeCh1ZAXoC1mCpBG4ToURZSoKHOU8yF1CXcRdBOBia6ICHBBsHxL_dM6v9Oa-peXFsT6MkAo6sK-pL1vSlA_vmdT5DagQn6t9GNBFk2NhHe5Wg3Ojh85MvpTOVFloxCT5diLdfWGpOaCJegtihr5C8hsXRHcuBBpVdnQHaSMe1it1m1ITNkQe0I8lDe3QnOScNds2AxaBHgWQuti2euN1mz113fG_qu2kPKlqrCoh2MCG_Els1JZlv1f13fG_qujds1Sq1fwQq; ctoken=7fqY_mz1p8lbJUN4Nc2KdW2m; grey-id=5be1b5a2-900d-787f-589f-8e62fc307090; grey-id.sig=eF5imx6XDicGDWDW0qBUyA353AxuFcIBaE-oa2yYeBQ; isQuark=true; isQuark.sig=hUgqObykqFom5Y09bll94T1sS9abT1X-4Df_lzgl8nM; _UP_F7E_8D_=iN3APNXwvEUG6F5itR%2FMgUPwKLOVbxJPcg0RzQPI6KmBtV6ZMgPh38l93pgubgHDQqhaZ2Sfc0qv%2BRantbfg1mWGAUpRMP4RqXP78Wvu%2FCfvkWWGc5NhCTV71tGOIGgDBR3%2Bu6%2Fjj47JRCxwKwP6RmtElYpAcMk%2FdjkhOclrgipqYAbrjqRo9YuUE9%2Fs5crDEn21dZLBeV8KDgX3rZm5ynXFp0eWhNFr9QQ6CCd7Fv6A1Bd%2BujS5RSU1VZu4DtwRoAg3J36dS9aj1m9P204NQdNf5Nyo3ldtw6TWtrcg0yJducQVbH%2BT5yM6TQ0ySWQ88mFyMhj2VouQ%2B%2BFKM%2B0tL1ggY93VJqD%2BguZ2Gmw5X%2FVXG5%2BATr9eEKxIvk7CLNVTZPG%2BMXyVR0GjxobkrXAZ3eIMTE7RyZru; _UP_D_=pc; __pus=2ba2735abc0d57d6e06616c005c6cb9bAAT9lBt4MVqrip7J+/AJgslxYrkoW+ScHFdilM4cmOhq2l4hNau8orKaBUQ5ku1vJpOV5BRTZ45Z30aRcY7c6g7J; __kp=cf042800-16af-11f1-b7bc-cb112264df22; __kps=AAQRbIhO3EiNSJOV9JTk/Gde; __ktd=qAhblNG60jw5YHE40mNRBQ==; __uid=AAQRbIhO3EiNSJOV9JTk/Gde; web-grey-id=6121e1d5-0b7f-24a1-7ce2-b19d68b00bc7; web-grey-id.sig=SHhnzDKh666sv9iPbWSCNV4mg4z-RmQxQ11MaxlYjZ8; __puus=5ea0954fe828c10ba2747fd3cf0dc992AASXZVN8M5tn8slQWIn4KF0Ua7uEEH/bbT26ivIilWQ3VtH/0mdtVEKZHmCbmrFYzuRI7efXbG2F0AVMcMdGr4mM9wbH/8VhfBoVUdeiOQKBVh9RH3OtI4M7svLaD6EVbw85PhMyM2qhVubFc6RIw3hk3c/6tDCL9XEJxhBOHWJnHeBeOuPKY1mTqATFkwrrNP4rn8vEl22ksZnfeYPxCp/h', '2026-05-20 09:19:31', '2026-05-20 09:19:31'),
(51, '阿里云盘', '7597e4da4fe845a390e51017f6eb5587', '2026-05-20 09:19:31', '2026-05-20 09:19:31'),
(52, 'UC网盘', 'UDRIVE_TRANSFER_SESS=uAvENYdZt664_QuYMp9S7p36MVSKWtaaa3eT1Xa61Sny8lS9YrgPjp4nRxBmY-BswJzZIh-R_GWfyfCSHA_3leSXXJL-zhSjZXbQiAgoALB8M49AYWSveJwCOJ1RhShyZCgeI1htutxBuiSASPtAlj5-xopYK7DZLWLIslCf5xge54Z17ytcZ_Np22uOrKa6; b-user-id=c2e7263b-efeb-df8e-bbaa-4a608df07ac7; ctoken=kBkY1z6wa4X_21dn-Q_VwoY7; __itrace_wid=10a09b8e-2e69-4bfc-baf0-1dde267d48d2; Hm_lvt_d2853e18bbb01bff13374d73c9fd1e3d=1778920077; HMACCOUNT=E37EAEE46BCF56B6; __pus=9468a1575188cf9830d0c82ad75095e5AATqK6hT9o5jGpAxqMJP47S4/UmHGBepmiublB71De7YEcUpdbDkZtix9+Xq+lDPwMLiM5ITq5FaCbBKU79QB1/G; __kp=2b21ab40-5101-11f1-a7bc-9379d2318daa; __kps=AASfQ9yGVzBjWT8FWp1xbHDn; __ktd=/S0XgMpiNPB4Eqa3bWWgdA==; __uid=AASfQ9yGVzBjWT8FWp1xbHDn; Hm_lpvt_d2853e18bbb01bff13374d73c9fd1e3d=1778920089; __puus=9a8ef55c84c56e6cae29c96ff2abcb12AAQFdnJWRjW3/r2iYmmF+ewJ0Z8JqmZMToQEl0abs1IhwUhxkpFHs2vsEVznx2SRAd/YYDRW7r7FkS0F+ca7dC1GBUgF0LXc71XETFyKYW60aiCNW0E2V82CClr9cR5uNemTeW1P8w8z08uhsCmHtDtOT7kKjkjkmq4wjTtckZu4/KPO1ct7OJYijrccFJkDTeY=', '2026-05-20 09:19:31', '2026-05-20 09:19:31');

-- --------------------------------------------------------

--
-- 表的结构 `resources`
--

CREATE TABLE `resources` (
  `id` int(11) NOT NULL,
  `file_id` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `share_link` text NOT NULL,
  `cloud_name` varchar(100) NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `remarks` text DEFAULT NULL,
  `is_replaced` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `category_id` int(11) DEFAULT NULL COMMENT '所属分类ID',
  `cover_url` varchar(500) DEFAULT NULL COMMENT '封面图片链接',
  `sort_order` int(11) NOT NULL DEFAULT 0 COMMENT '排序权重，越大越靠前'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `resources`
--

INSERT INTO `resources` (`id`, `file_id`, `name`, `share_link`, `cloud_name`, `type`, `remarks`, `is_replaced`, `created_at`, `updated_at`, `category_id`, `cover_url`, `sort_order`) VALUES
(154, NULL, '光阴之外', 'https://pan.baidu.com/s/1cdjByz5F08VeoPw3KGy8NA?pwd=6666', '百度网盘', '', '用户获取 - 百度网盘', 0, '2026-06-01 12:01:08', '2026-06-01 12:01:08', NULL, '', 0),
(155, NULL, '光阴之外 (2025)4K HQ 高码率 S01E01-E24', 'https://pan.baidu.com/s/1bV8HAg3ZU9yuFEcP9nDtwQ?pwd=6666', '百度网盘', '', '用户获取 - 百度网盘', 0, '2026-06-01 12:01:52', '2026-06-01 12:01:52', NULL, '', 0),
(156, NULL, '光阴之外 (2025) WEB-4K-高码率【第24集】', 'https://pan.baidu.com/s/1Qa0t8-1MLkOdJsZX5iYVUA?pwd=4ogI', '百度网盘', '', '用户获取 - 百度网盘', 0, '2026-06-01 12:02:14', '2026-06-01 12:02:14', NULL, '', 0),
(157, NULL, '📺 电视剧：光阴之外 (2025) S01E23', 'https://115.com/s/swfuj4y3wov?password=mc15', '115网盘', '', '用户获取 - 115网盘', 0, '2026-06-01 12:02:22', '2026-06-01 12:02:22', NULL, '', 0),
(158, NULL, '光阴之外 4K高码率 [SDR&DV][更新至24集]', 'https://pan.quark.cn/s/b7bb86fde4d0', '夸克网盘', '', '用户获取 - 夸克网盘', 0, '2026-06-01 12:02:36', '2026-06-01 12:02:36', NULL, '', 0),
(159, NULL, '我们的爸爸 第二季 (2026) 更至5.26期 [综艺/家庭]', 'https://pan.baidu.com/s/1hW3a6zfGqjbda5qamc6Xuw?pwd=6666', '百度网盘', '', '用户获取 - 百度网盘', 0, '2026-06-01 12:03:53', '2026-06-01 12:03:53', NULL, '', 0),
(160, NULL, 'W我们的爸爸第二季2026', 'https://pan.quark.cn/s/fb324bba5e2c', '夸克网盘', '', '用户获取 - 夸克网盘', 0, '2026-06-01 12:04:04', '2026-06-01 12:04:04', NULL, '', 0),
(161, NULL, '我们的爸爸 第二季 (2026) 更至5.26期 [综艺]', 'https://pan.quark.cn/s/4f802c16baf8', '夸克网盘', '', '用户获取 - 夸克网盘', 0, '2026-06-01 12:04:12', '2026-06-01 12:04:12', NULL, '', 0),
(162, NULL, '我们的爸爸 第二季.1080P更 5.31期', 'https://pan.quark.cn/s/fede6e7dc20b', '夸克网盘', '', '用户获取 - 夸克网盘', 0, '2026-06-01 12:06:16', '2026-06-01 12:06:16', NULL, '', 0),
(163, NULL, 'D大风杀2025', 'https://pan.quark.cn/s/81096445624a', '夸克网盘', '', '用户获取 - 夸克网盘', 0, '2026-06-01 12:07:34', '2026-06-01 12:07:34', NULL, '', 0),
(164, NULL, '黄金苹果 황금사과 (2005)', 'https://pan.baidu.com/s/1dOIHvffPqP1qP7hQ8OgLlg?pwd=6666', '百度网盘', '', '用户获取 - 百度网盘', 0, '2026-06-01 12:18:39', '2026-06-01 12:18:39', NULL, '', 0),
(165, NULL, '仙逆剧场版 神临之战', 'https://pan.baidu.com/s/1NskMdPFoefWmEG3Ms3xzVA?pwd=6666', '百度网盘', '', '用户获取 - 百度网盘', 0, '2026-06-01 13:28:50', '2026-06-01 13:28:50', NULL, '', 0),
(166, NULL, 'X仙逆剧场版神临之战2025', 'https://pan.quark.cn/s/b5936150254a', '夸克网盘', '', '用户获取 - 夸克网盘', 0, '2026-06-01 13:29:21', '2026-06-01 13:29:21', NULL, '', 0),
(167, NULL, '名称：《仙逆剧场版 神临之战》2025 [4K画质更新] 内嵌中字 [7.4G]️亮点：该剧场版动画结合动作、奇幻和古装元素，提供4K高清画质和内嵌中文字幕，带给观众震撼的视觉体验，适合喜欢仙侠题材的影迷。标签：#仙逆 #剧场版 #4K画质 #动作动画 #奇幻古装', 'https://pan.quark.cn/s/34c119fa0d6c', '夸克网盘', '', '用户获取 - 夸克网盘', 0, '2026-06-01 13:29:27', '2026-06-01 13:29:27', NULL, '', 0),
(168, NULL, '初入职场·金融季.1080P更 6.3期', 'https://pan.quark.cn/s/fdcaba548723', '夸克网盘', '', '用户获取 - 夸克网盘', 0, '2026-06-03 08:59:37', '2026-06-03 08:59:37', NULL, '', 0),
(169, NULL, '6342-一人之下修仙归来&凡人修仙传仙帝归来 80集', 'https://pan.quark.cn/s/b1846968107b', '夸克网盘', '', '用户获取 - 夸克网盘', 0, '2026-06-04 00:29:43', '2026-06-04 00:29:43', NULL, '', 0),
(170, NULL, '一人之下修仙归来|凡人修仙传仙帝归来 80集', 'https://pan.quark.cn/s/fa3b6b2f7faf', '夸克网盘', '', '用户获取 - 夸克网盘', 0, '2026-06-04 00:30:11', '2026-06-04 00:30:11', NULL, '', 0),
(171, NULL, '凡人修仙传（80集）', 'https://pan.quark.cn/s/b32ee7152d27', '夸克网盘', '', '用户获取 - 夸克网盘', 0, '2026-06-04 00:31:31', '2026-06-04 00:31:31', NULL, '', 0),
(172, NULL, '一人之下修仙归来&凡人修仙传仙帝归来（80集）', 'https://pan.quark.cn/s/0b248d47a087', '夸克网盘', '', '用户获取 - 夸克网盘', 0, '2026-06-04 00:31:56', '2026-06-04 00:31:56', NULL, '', 0),
(173, NULL, '给阿嬷的情书(2026)', 'https://pan.quark.cn/s/4f8b2b53cfcc', '夸克网盘', '', '用户获取 - 夸克网盘', 0, '2026-06-04 04:47:15', '2026-06-04 04:47:15', NULL, '', 0);

-- --------------------------------------------------------

--
-- 表的结构 `system_config`
--

CREATE TABLE `system_config` (
  `config_key` varchar(100) NOT NULL COMMENT '配置键',
  `config_value` text DEFAULT NULL COMMENT '配置值(JSON字符串)',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '创建时间',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置表';

--
-- 转存表中的数据 `system_config`
--

INSERT INTO `system_config` (`config_key`, `config_value`, `created_at`, `updated_at`) VALUES
('aliyun_default_dir', '', '2026-05-16 12:17:40', '2026-05-20 09:19:31'),
('aliyun_temp_dir', '', '2026-05-16 12:17:41', '2026-05-20 09:19:31'),
('baidu_default_dir', '/影视', '2026-05-16 06:52:24', '2026-05-20 09:19:31'),
('baidu_temp_dir', '/影视', '2026-05-16 06:52:24', '2026-05-20 09:19:31'),
('frontend_display_netdisks', '{\"enabled_netdisks\": [\"\\u767e\\u5ea6\\u7f51\\u76d8\", \"\\u5938\\u514b\\u7f51\\u76d8\", \"\\u8fc5\\u96f7\\u7f51\\u76d8\", \"UC\\u7f51\\u76d8\", \"\\u609f\\u7a7a\\u7f51\\u76d8\", \"\\u5feb\\u5154\\u7f51\\u76d8\", \"115\\u7f51\\u76d8\", \"\\u963f\\u91cc\\u4e91\\u76d8\", \"\\u5929\\u7ffc\\u4e91\\u76d8\", \"\\u79fb\\u52a8\\u4e91\\u76d8\", \"\\u8054\\u901a\\u4e91\\u76d8\", \"123\\u4e91\\u76d8\", \"PikPak\", \"\\u78c1\\u529b\\u94fe\\u63a5\", \"\\u8fc5\\u96f7\\u94fe\\u63a5\", \"\\u7535\\u9a74\\u94fe\\u63a5\", \"\\u5176\\u4ed6\"]}', '2026-05-16 00:44:22', '2026-05-16 00:44:22'),
('frontend_link_mode', '{\"mode\": \"view\"}', '2026-05-15 07:40:28', '2026-05-30 09:29:31'),
('public_search_api', '{\"enabled\": true}', '2026-05-20 08:58:31', '2026-05-20 08:58:34'),
('quark_default_dir', '9c8fd77ad5d54cb08c9312e94dbd3ba0', '2026-05-16 07:33:02', '2026-05-20 09:19:31'),
('quark_temp_dir', '9c8fd77ad5d54cb08c9312e94dbd3ba0', '2026-05-16 07:33:02', '2026-05-20 09:19:31'),
('uc_default_dir', 'a0afcd9deb014462bd6f271cd96b3dc8', '2026-05-16 12:17:41', '2026-05-20 09:19:31'),
('uc_temp_dir', 'a0afcd9deb014462bd6f271cd96b3dc8', '2026-05-16 12:17:41', '2026-05-20 09:19:31'),
('xunlei_default_dir', 'VOcJZiueFev8B1mtkoFiCXRBA1', '2026-05-16 12:17:41', '2026-05-20 09:19:31'),
('xunlei_temp_dir', 'VOcJZiueFev8B1mtkoFiCXRBA1', '2026-05-16 12:17:41', '2026-05-20 09:19:31');

-- --------------------------------------------------------

--
-- 表的结构 `temp_share`
--

CREATE TABLE `temp_share` (
  `id` int(11) NOT NULL COMMENT '主键',
  `original_url` text NOT NULL COMMENT '原始分享链接',
  `title` varchar(255) DEFAULT NULL COMMENT '资源标题',
  `cloud_name` varchar(100) NOT NULL COMMENT '网盘名称',
  `temp_share_url` text NOT NULL COMMENT '临时分享链接',
  `file_id` varchar(255) NOT NULL COMMENT '转存后的文件ID或路径',
  `status` varchar(20) NOT NULL DEFAULT 'active' COMMENT '状态: active/deleted/failed',
  `expires_at` datetime NOT NULL COMMENT '过期时间',
  `last_accessed_at` datetime NOT NULL DEFAULT current_timestamp() COMMENT '最后访问时间',
  `created_at` datetime NOT NULL DEFAULT current_timestamp() COMMENT '创建时间',
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '更新时间',
  `deleted_at` datetime DEFAULT NULL COMMENT '删除时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='搜索页动态转存临时分享表';

--
-- 转存表中的数据 `temp_share`
--

INSERT INTO `temp_share` (`id`, `original_url`, `title`, `cloud_name`, `temp_share_url`, `file_id`, `status`, `expires_at`, `last_accessed_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'https://pan.quark.cn/s/44f94c0bf05c', 'N哪吒之魔童闹海幕后纪录片《不破不立》2025', '夸克网盘', 'https://pan.quark.cn/s/7c5bf84077c6', '2fa5d8e742674a03bd1c1541dd61f653', 'deleted', '2026-05-16 18:52:52', '2026-05-16 16:07:57', '2026-05-16 12:52:52', '2026-05-16 20:17:50', '2026-05-16 20:17:50'),
(2, 'https://pan.quark.cn/s/c63d0e1bd2f6', 'N哪吒之魔童闹海2025', '夸克网盘', 'https://pan.quark.cn/s/098a39ef8db7', '5fd528b8b01b42de9f87771cef2355c4', 'deleted', '2026-05-16 19:15:48', '2026-05-16 13:15:48', '2026-05-16 13:15:48', '2026-05-16 20:17:50', '2026-05-16 20:17:50'),
(3, 'https://pan.quark.cn/s/9304e71cdeb0', '哪吒之魔童闹海', '夸克网盘', 'https://pan.quark.cn/s/734481c1d569', 'f5d0f612b02742a0a8fbd7a373664a16', 'deleted', '2026-05-16 19:24:03', '2026-05-16 16:08:24', '2026-05-16 13:24:03', '2026-05-16 20:17:51', '2026-05-16 20:17:51'),
(4, 'https://pan.quark.cn/s/0f3b8cdc0a2f', '哪吒之魔童闹海 / 哪吒2‎ (2025) 4K纯净 SDR HDR 杜比视界 高码率 120FPS 杜比全景声+杜比环绕声+DTS环绕声+臻悦全景声 简中 【36GB】哪吒2', '夸克网盘', 'https://pan.quark.cn/s/1a3fa3c89f26', '2e3dd99774934ecea3caf02b4b8941b2', 'deleted', '2026-05-16 19:26:19', '2026-05-16 13:26:19', '2026-05-16 13:26:19', '2026-05-16 20:17:52', '2026-05-16 20:17:52'),
(5, 'https://pan.quark.cn/s/d13871360493', 'W伪钞重案2026', '夸克网盘', 'https://pan.quark.cn/s/0f9e774bf819', '929eee64022a410ba0323786f2e8bbe4', 'deleted', '2026-05-16 19:29:04', '2026-05-16 13:29:04', '2026-05-16 13:29:04', '2026-05-16 20:17:52', '2026-05-16 20:17:52'),
(6, 'https://pan.quark.cn/s/da1be65f8a2b', '乘风破浪的婚姻(90集)', '夸克网盘', 'https://pan.quark.cn/s/54b2ddde986a', '2325677bd8654ed385c2bae8f510b4f9', 'deleted', '2026-05-16 21:51:38', '2026-05-16 15:51:38', '2026-05-16 15:51:38', '2026-05-16 22:09:38', '2026-05-16 22:09:38'),
(7, 'https://pan.quark.cn/s/3c9c3eec0911', '不破不立——哪吒之魔童闹海幕后纪录片', '夸克网盘', 'https://pan.quark.cn/s/a3edafe5e47b', '57a3b7b20f1342688cc8eaef74931a6c', 'deleted', '2026-05-16 22:08:08', '2026-05-16 16:08:08', '2026-05-16 16:08:08', '2026-05-16 22:09:38', '2026-05-16 22:09:38'),
(8, 'https://pan.quark.cn/s/c63d0e1bd2f6', 'N哪吒之魔童闹海2025', '夸克网盘', 'https://pan.quark.cn/s/5ea18e498633', '5fd528b8b01b42de9f87771cef2355c4', 'active', '2026-05-17 01:32:10', '2026-05-16 19:32:10', '2026-05-16 19:32:10', '2026-05-16 19:32:10', NULL),
(9, 'https://pan.quark.cn/s/d17372d8bbc4', '头像：哪吒之魔童闹海系列头像', '夸克网盘', 'https://pan.quark.cn/s/cad42e0def60', 'a376b67efbcc4284b45854fe0bbf5088', 'deleted', '2026-05-17 01:33:52', '2026-05-16 19:33:52', '2026-05-16 19:33:52', '2026-05-17 01:39:38', '2026-05-17 01:39:38'),
(10, 'https://pan.quark.cn/s/0f3b8cdc0a2f', '哪吒之魔童闹海 / 哪吒2‎ (2025) 4K纯净 SDR HDR 杜比视界 高码率 120FPS 杜比全景声+杜比环绕声+DTS环绕声+臻悦全景声 简中 【36GB】哪吒2', '夸克网盘', 'https://pan.quark.cn/s/1567d21ffa69', '2e3dd99774934ecea3caf02b4b8941b2', 'active', '2026-05-17 01:52:25', '2026-05-16 19:52:25', '2026-05-16 19:52:25', '2026-05-16 19:52:25', NULL),
(11, 'https://pan.quark.cn/s/98a03a62870a', '🗄 哪吒2 / 哪吒之魔童闹海 (2025) 4K 高码率 [HQ.DV.60fps] [杜比全景声&DTS环绕声]', '夸克网盘', 'https://pan.quark.cn/s/eb15a204dca7', '02f8804b36284ff4a2bca2f08b7e7990', 'deleted', '2026-05-17 01:53:59', '2026-05-16 19:53:59', '2026-05-16 19:53:59', '2026-05-17 02:09:38', '2026-05-17 02:09:38'),
(12, 'https://drive.uc.cn/s/c909f48292cb4', '#电影🗄 禁果 Forbidden Fruits (2026) 4K高码.外挂中英双语字幕.2160p.AMZN.WEB-DL.DDP5.1.H.265.Atmos.mkv ( 11.3G )📜', 'UC网盘', 'https://drive.uc.cn/s/5d783eb74d7a4', '[\"e1fcc8ca34fe4dc9a05556dc9b3c908f\"]', 'deleted', '2026-05-17 03:03:01', '2026-05-16 21:03:01', '2026-05-16 21:03:01', '2026-05-17 03:09:38', '2026-05-17 03:09:38'),
(13, 'https://pan.quark.cn/s/def44d21b819', '[图灵程序设计丛书].奔跑吧，程序员：从零开始打造产品、技术和团队.pdf', '夸克网盘', 'https://pan.quark.cn/s/c43fb738952b', 'b5d683aeb3144868bec9acbd033b40ba', 'deleted', '2026-05-17 03:18:33', '2026-05-16 21:18:33', '2026-05-16 21:18:33', '2026-05-17 03:39:38', '2026-05-17 03:39:38'),
(14, 'https://pan.quark.cn/s/7a4f7549b35d', 'S扫恶2026', '夸克网盘', 'https://pan.quark.cn/s/74614a3d77c1', 'e0fa79a03adb46f39997c32058c99928', 'deleted', '2026-05-17 17:58:44', '2026-05-17 12:33:04', '2026-05-17 11:58:44', '2026-05-17 18:31:14', '2026-05-17 18:31:14'),
(15, 'https://drive.uc.cn/s/825f30b1c2254', '扫恶', 'UC网盘', 'https://drive.uc.cn/s/0a7f368d61c74', '[\"10d5f9ce962f4c06af5062ad9eb3912e\"]', 'deleted', '2026-05-17 17:59:01', '2026-05-17 12:49:10', '2026-05-17 11:59:01', '2026-05-17 18:31:14', '2026-05-17 18:31:14'),
(16, 'https://pan.baidu.com/s/1dEB08dYficos2baYq2Z9YQ?pwd=9527', '扫恶[4K版高码十杜比视界版本][国语配音+中文字幕].2026.2160p.4k高码版本', '百度网盘', 'https://pan.baidu.com/s/1dEB08dYficos2baYq2Z9YQ', '348839322701377', 'active', '2026-05-17 18:30:00', '2026-05-17 12:30:00', '2026-05-17 12:30:00', '2026-05-17 12:30:00', NULL),
(17, 'https://pan.baidu.com/s/1CKg0rVkyX31sbayt6KRj4A?pwd=8888', '扫恶', '百度网盘', 'https://pan.baidu.com/s/1CKg0rVkyX31sbayt6KRj4A', '256206977524805', 'active', '2026-05-17 18:49:58', '2026-05-17 12:49:58', '2026-05-17 12:49:58', '2026-05-17 12:49:58', NULL),
(18, 'https://pan.baidu.com/s/1CKg0rVkyX31sbayt6KRj4A?pwd=8888', '扫恶', '百度网盘', 'https://pan.baidu.com/s/1CKg0rVkyX31sbayt6KRj4A', '256206977524805', 'active', '2026-05-17 18:49:58', '2026-05-17 12:49:58', '2026-05-17 12:49:58', '2026-05-17 12:49:58', NULL),
(19, 'https://pan.baidu.com/s/1eBDbjgauAyUZbYUPYPtL1w?pwd=wogg', '扫恶（2026）4K 臻彩MAX+ 60FPS DTS环绕声&杜比全景声', '百度网盘', 'https://pan.baidu.com/s/1eBDbjgauAyUZbYUPYPtL1w', '542294933716309', 'active', '2026-05-17 19:10:20', '2026-05-17 13:10:20', '2026-05-17 13:10:20', '2026-05-17 13:10:20', NULL),
(20, 'https://pan.baidu.com/s/1eBDbjgauAyUZbYUPYPtL1w?pwd=wogg', '扫恶（2026）4K 臻彩MAX+ 60FPS DTS环绕声&杜比全景声', '百度网盘', 'https://pan.baidu.com/s/1eBDbjgauAyUZbYUPYPtL1w', '542294933716309', 'active', '2026-05-17 19:10:20', '2026-05-17 13:10:20', '2026-05-17 13:10:20', '2026-05-17 13:10:20', NULL),
(21, 'https://pan.baidu.com/s/1GGjcH_dfifgkyOHL8oLrBA?pwd=8888', '追恶', '百度网盘', 'https://pan.baidu.com/s/1GGjcH_dfifgkyOHL8oLrBA', '448996430221301', 'active', '2026-05-17 19:11:06', '2026-05-17 13:11:06', '2026-05-17 13:11:06', '2026-05-17 13:11:06', NULL),
(22, 'https://pan.baidu.com/s/1Dz-91ZRU2oonQiR6e1TDug?pwd=8888', '择天记3D版', '百度网盘', 'https://pan.baidu.com/s/1Dz-91ZRU2oonQiR6e1TDug', '313500504632052', 'active', '2026-05-17 19:13:24', '2026-05-17 13:13:24', '2026-05-17 13:13:24', '2026-05-17 13:13:24', NULL),
(23, 'https://pan.baidu.com/s/1YEAbMTLn79pOWXJ1g_1-Fg?pwd=yyds', '择天记（2026） 4K 高码 更新至18集', '百度网盘', 'https://pan.baidu.com/s/1YEAbMTLn79pOWXJ1g_1-Fg', '657614617061670', 'active', '2026-05-17 19:24:14', '2026-05-17 13:24:14', '2026-05-17 13:24:14', '2026-05-17 13:24:14', NULL),
(24, 'https://pan.baidu.com/s/1L--KziULgoLCWYRn1rjROg?pwd=8888', '沧元图2', '百度网盘', 'https://pan.baidu.com/s/1L--KziULgoLCWYRn1rjROg', '361989765864070', 'active', '2026-05-17 19:25:25', '2026-05-17 17:25:28', '2026-05-17 13:25:25', '2026-05-17 17:25:28', NULL),
(25, 'https://pan.baidu.com/s/1DPPJs9U5TbyB-uJB3UrqSw?pwd=kwc8', '云深不知梦 更新至21集 4K SDR 高码率', '百度网盘', 'https://pan.baidu.com/s/1DPPJs9U5TbyB-uJB3UrqSw', '165841072032661', 'active', '2026-05-17 19:45:39', '2026-05-17 13:45:39', '2026-05-17 13:45:39', '2026-05-17 13:45:39', NULL),
(26, 'https://pan.quark.cn/s/d600f8996d28', '光阴之外.1080P更 22 【6点】', '夸克网盘', 'https://pan.quark.cn/s/2fb8c5041bb8', '55ad82ffefb544919538ef729768349b', 'deleted', '2026-05-17 21:26:58', '2026-05-17 15:26:58', '2026-05-17 15:26:58', '2026-05-17 21:57:20', '2026-05-17 21:57:20'),
(27, 'https://pan.baidu.com/s/1q2N4xrkFroAV-YorKkm0OA?pwd=b9u5', '奔跑吧 第十季 更新至20260424期 4K SDR 60帧 高码率', '百度网盘', 'https://pan.baidu.com/s/1q2N4xrkFroAV-YorKkm0OA', '411591162409432', 'active', '2026-05-17 22:46:50', '2026-05-17 16:46:50', '2026-05-17 16:46:50', '2026-05-17 16:46:50', NULL),
(28, 'https://pan.baidu.com/s/1dg_2kd212QOOpf9cZ9NkVQ?pwd=1234', '【国产剧】罪案痕迹 (2026)更最新集百度:', '百度网盘', 'https://pan.baidu.com/s/1dg_2kd212QOOpf9cZ9NkVQ', '952192012874601', 'active', '2026-05-17 23:04:28', '2026-05-17 17:04:28', '2026-05-17 17:04:28', '2026-05-17 17:04:28', NULL),
(29, 'https://pan.baidu.com/s/1i_wRufS9LGZzMKvBc7zPzA?pwd=ia4Z', '罪案痕迹 (2026)', '百度网盘', 'https://pan.baidu.com/s/1i_wRufS9LGZzMKvBc7zPzA', '657811691039397', 'active', '2026-05-17 23:08:28', '2026-05-17 17:08:28', '2026-05-17 17:08:28', '2026-05-17 17:08:28', NULL),
(30, 'https://pan.baidu.com/s/1pn94_T-WUoy1aa87usvWLg?pwd=n6a4', '亲爱的客栈2026 (2026) 沈月 王鹤棣 秦岚 真人秀 0516期', '百度网盘', 'https://pan.baidu.com/s/1pn94_T-WUoy1aa87usvWLg', '787062779766947', 'active', '2026-05-17 23:31:59', '2026-05-17 17:31:59', '2026-05-17 17:31:59', '2026-05-17 17:31:59', NULL),
(31, 'https://pan.baidu.com/s/1z03cZ2AI_TE2UycM_q-67A?pwd=0424', '乘风2026 /更至5.16期 [综艺/音乐竞演][乘风/乘风破浪/乘风破浪的姐姐]', '百度网盘', 'https://pan.baidu.com/s/1z03cZ2AI_TE2UycM_q-67A', '1069133627621592', 'active', '2026-05-17 23:39:25', '2026-05-17 17:39:25', '2026-05-17 17:39:25', '2026-05-17 17:39:25', NULL),
(32, 'https://pan.baidu.com/s/1lMqFunLsT9DKGbMM61apBg?pwd=0425', '无限超越班 第四季 (2026) 更至5.16期 [综艺/演技研习]', '百度网盘', 'https://pan.baidu.com/s/1lMqFunLsT9DKGbMM61apBg', '170787982399555', 'active', '2026-05-17 23:45:28', '2026-05-17 17:45:28', '2026-05-17 17:45:28', '2026-05-17 17:45:28', NULL),
(33, 'https://pan.baidu.com/s/1I81hxuzTPHF5ZR9B9vIrBA?pwd=1234', '【综艺】大侦探 第十一季（2026）百度：', '百度网盘', 'https://pan.baidu.com/s/1ZSDqCD_28J1ZSbGmGDzrww?pwd=6666', '769135949270552', 'active', '2026-05-18 01:11:38', '2026-05-17 19:11:38', '2026-05-17 19:11:38', '2026-05-17 19:11:38', NULL),
(34, 'https://pan.quark.cn/s/b5637419e7bc', '我，许可', '夸克网盘', 'https://pan.quark.cn/s/067af6c89e71', 'f0f545b597f3448f86d0550b614f6020', 'deleted', '2026-05-18 01:43:09', '2026-05-17 19:43:09', '2026-05-17 19:43:09', '2026-05-18 01:57:20', '2026-05-18 01:57:20'),
(35, 'https://pan.baidu.com/s/1tglKz3O01nfpxnh2wqKW5g?pwd=8888', '我，许可', '百度网盘', 'https://pan.baidu.com/s/1lg-jcfummHjqKnDQdhxEAA?pwd=6666', '151525343792895', 'active', '2026-05-19 00:31:07', '2026-05-18 18:31:07', '2026-05-18 18:31:07', '2026-05-18 18:31:07', NULL),
(36, 'https://pan.quark.cn/s/7a4f7549b35d', 'S扫恶2026', '夸克网盘', 'https://pan.quark.cn/s/f6c127f47783', '1f04f00e43d7439f8607e3bfd7095abc', 'deleted', '2026-05-20 00:57:26', '2026-05-19 18:57:26', '2026-05-19 18:57:26', '2026-05-20 14:51:36', '2026-05-20 14:51:36'),
(37, 'https://pan.baidu.com/s/10xjJ9Nf8zPbsmYUvLvKeFA?pwd=dubp', '综艺：这是我的西游 (2025) 更新至0512期/ 综艺', '百度网盘', 'https://pan.baidu.com/s/1bwOGJwjOZfibjuiTYm_zIA?pwd=6666', '515433229788254', 'active', '2026-05-20 20:06:00', '2026-05-20 14:06:00', '2026-05-20 14:06:00', '2026-05-20 14:06:00', NULL),
(38, 'https://drive.uc.cn/s/59a3610032d04', '光阴之外', 'UC网盘', 'https://drive.uc.cn/s/10b849ba109c4', '[\"455fc844d29d437188f8131365a167cc\"]', 'deleted', '2026-05-20 20:10:24', '2026-05-20 14:10:24', '2026-05-20 14:10:24', '2026-05-20 20:24:19', '2026-05-20 20:24:19'),
(39, 'https://pan.quark.cn/s/d600f8996d28', '光阴之外.1080P更 22 【6点】', '夸克网盘', 'https://pan.quark.cn/s/63e2dbedd5ee', '009dba5d2ba9408fa099d8552d1fdbdc', 'deleted', '2026-05-20 20:11:19', '2026-05-20 14:11:33', '2026-05-20 14:11:19', '2026-05-20 20:24:19', '2026-05-20 20:24:19'),
(40, 'https://pan.baidu.com/s/13on53FECBI9r4mb-H7ducg?pwd=8888', '光阴之外', '百度网盘', 'https://pan.baidu.com/s/1rp1iOy8cxTOedAuY8EmSfQ?pwd=6666', '937226798610116', 'active', '2026-05-20 21:24:32', '2026-05-20 15:24:32', '2026-05-20 15:24:32', '2026-05-20 15:24:32', NULL),
(41, 'https://pan.baidu.com/s/1gwUkj6MOcMLQK3lJo7ALoQ?pwd=7yr5', '奔跑吧 第十季 /奔跑吧兄弟 (2026) 郑恺 沙溢 白鹿 范丞丞 真人秀 0515期', '百度网盘', 'https://pan.baidu.com/s/1xv4PSP84M7JGXy-E-Ysd6Q?pwd=6666', '157044516529436', 'active', '2026-05-20 21:25:16', '2026-05-20 15:25:16', '2026-05-20 15:25:16', '2026-05-20 15:25:16', NULL),
(42, 'https://pan.quark.cn/s/8f85dbef517c', 'P怦然心动20岁：冬季2026', '夸克网盘', 'https://pan.quark.cn/s/ed4de50ef50f', 'd78d73483a89453ab7a14eed182453d8', 'deleted', '2026-05-20 22:59:10', '2026-05-20 16:59:10', '2026-05-20 16:59:10', '2026-05-21 10:23:52', '2026-05-21 10:23:52'),
(43, 'https://pan.quark.cn/s/94d699dbd450', '[图灵程序设计丛书].挑战编程技能：57道程序员功力测试题.pdf', '夸克网盘', 'https://pan.quark.cn/s/63acd7d74fc7', '265292a10cb44ff0a558940c40fc75af', 'deleted', '2026-05-21 02:45:39', '2026-05-20 20:45:39', '2026-05-20 20:45:39', '2026-05-21 10:23:53', '2026-05-21 10:23:53'),
(44, 'https://pan.quark.cn/s/ff0aa9c893d7', '[图灵程序设计丛书].精通Metasploit渗透测试.第2版.pdf', '夸克网盘', 'https://pan.quark.cn/s/efa642c4b2b8', '35d9ef069b304a01ab323acfe89ef524', 'deleted', '2026-05-21 02:45:39', '2026-05-20 20:45:39', '2026-05-20 20:45:39', '2026-05-21 10:23:53', '2026-05-21 10:23:53'),
(45, 'https://pan.quark.cn/s/df37c947f4b3', '[图灵程序设计丛书].Python Web开发：测试驱动方法.pdf', '夸克网盘', 'https://pan.quark.cn/s/aeff26d30b19', '751ae5dc9d65423bb72f4715fccfa1ab', 'deleted', '2026-05-21 02:45:39', '2026-05-20 20:45:39', '2026-05-20 20:45:39', '2026-05-21 10:23:54', '2026-05-21 10:23:54'),
(46, 'https://pan.quark.cn/s/5765af93a03a', '[图灵程序设计丛书].Java测试驱动开发.pdf', '夸克网盘', 'https://pan.quark.cn/s/ce20fdc08f49', 'a064d1f8ac904bc6800398a7afbfd94b', 'deleted', '2026-05-21 02:45:39', '2026-05-20 20:45:39', '2026-05-20 20:45:39', '2026-05-21 10:23:54', '2026-05-21 10:23:54'),
(47, 'https://pan.quark.cn/s/56526a2f87f5', '[图灵程序设计丛书].Python测试驱动开发：使用Django、Selenium和JavaScript进行Web编程.第2版.pdf', '夸克网盘', 'https://pan.quark.cn/s/cb917da5ce41', '0f2b5080c1aa4a0ab95908b697f595b8', 'deleted', '2026-05-21 02:45:40', '2026-05-20 20:45:40', '2026-05-20 20:45:40', '2026-05-21 10:23:55', '2026-05-21 10:23:55'),
(48, 'https://pan.quark.cn/s/493fad5cd6ac', '妻子的致命测试（60集）林元元&白龙', '夸克网盘', 'https://pan.quark.cn/s/b79fe55b6b1a', '70f9a31e584b449c925f3cdb9e1a96b9', 'deleted', '2026-05-21 02:45:42', '2026-05-20 20:45:42', '2026-05-20 20:45:42', '2026-05-21 10:23:55', '2026-05-21 10:23:55'),
(49, 'https://pan.quark.cn/s/9f8247bdafe2', '玫瑰带刺华丽归来＆婚前测试他不配（83集）', '夸克网盘', 'https://pan.quark.cn/s/c5fdf5b1b349', '646547eda84846ee873d684d104e5225', 'deleted', '2026-05-21 02:45:42', '2026-05-20 20:45:42', '2026-05-20 20:45:42', '2026-05-21 10:23:56', '2026-05-21 10:23:56'),
(50, 'https://pan.quark.cn/s/387717062ba0', '真爱测试报告（66集）黄波|张溪桐', '夸克网盘', 'https://pan.quark.cn/s/a32f78388204', '57d78ef31f624f5d87865e873d96413b', 'deleted', '2026-05-21 02:45:42', '2026-05-20 20:45:42', '2026-05-20 20:45:42', '2026-05-21 10:23:56', '2026-05-21 10:23:56'),
(51, 'https://pan.baidu.com/s/1KGK6lju-oaz1n2k0ic48hQ?pwd=dt72', '1、Kali渗透测试入门教程', '百度网盘', 'https://pan.baidu.com/s/1aaGx-HJr_H0qvN-57kRAIA?pwd=6666', '150604975336353', 'active', '2026-05-21 02:45:49', '2026-05-20 20:45:49', '2026-05-20 20:45:49', '2026-05-20 20:45:49', NULL),
(52, 'https://pan.quark.cn/s/e9b65b536329', '真爱测试报告', '夸克网盘', 'https://pan.quark.cn/s/79b6a89bd46a', '7953022064fc4ba7b294d19bd09308f0', 'deleted', '2026-05-21 02:45:49', '2026-05-20 20:45:49', '2026-05-20 20:45:49', '2026-05-21 10:23:57', '2026-05-21 10:23:57'),
(53, 'https://pan.quark.cn/s/52215f1d3327', '街头测试，我的女儿你不该惹', '夸克网盘', 'https://pan.quark.cn/s/bb8c6408b26f', '10fa69e640194db4b487a37b8b359a85', 'deleted', '2026-05-21 02:45:49', '2026-05-20 20:45:49', '2026-05-20 20:45:49', '2026-05-21 10:23:57', '2026-05-21 10:23:57'),
(54, 'https://pan.quark.cn/s/4ef33f6edcb6', '哥本哈根测试', '夸克网盘', 'https://pan.quark.cn/s/6dbac63e2c8b', '042d3ccb716b4d97b399939aa9ddc69a', 'deleted', '2026-05-21 02:45:49', '2026-05-20 20:45:49', '2026-05-20 20:45:49', '2026-05-21 10:23:58', '2026-05-21 10:23:58'),
(55, 'https://pan.baidu.com/s/1zJ1boqV0FR3qUcwPUhEIsw?pwd=47qu', '1、测试', '百度网盘', 'https://pan.baidu.com/s/13FI80Tauf-VVqIfyLOxlcg?pwd=6666', '719158154291559', 'active', '2026-05-21 02:45:49', '2026-05-20 20:45:49', '2026-05-20 20:45:49', '2026-05-20 20:45:49', NULL),
(56, 'https://pan.quark.cn/s/e5a26351c532', '【电脑软件】火绒全新工具 强力卸载 测试版（1.00.3）', '夸克网盘', 'https://pan.quark.cn/s/49a4700501a5', 'c792b76affa240baa8de2af67284f2e4', 'deleted', '2026-05-21 02:45:52', '2026-05-20 20:45:52', '2026-05-20 20:45:52', '2026-05-21 10:23:58', '2026-05-21 10:23:58'),
(57, 'https://pan.quark.cn/s/828f4e089567', '#综艺🗄 試真D（2026）TVB翡翠台标.粤语繁体中字.720p.WEB-DL.H.264.AAC2.0.mp4 (更新至 15 集)📜', '夸克网盘', 'https://pan.quark.cn/s/7f841c914ad6', '59affd491bdf4ef8accd97351e89b96b', 'deleted', '2026-05-21 02:45:52', '2026-05-20 20:45:52', '2026-05-20 20:45:52', '2026-05-21 10:23:59', '2026-05-21 10:23:59'),
(58, 'https://pan.quark.cn/s/65d3edacee56', '金色大厅音箱测试壹号wav+cue 低速原抓', '夸克网盘', 'https://pan.quark.cn/s/12ea9ce632ec', 'd3f25629b3e04bfeac09117e942cc34e', 'deleted', '2026-05-21 02:45:52', '2026-05-20 20:45:52', '2026-05-20 20:45:52', '2026-05-21 10:23:59', '2026-05-21 10:23:59'),
(59, 'https://pan.quark.cn/s/94e5dfc39b9b', '指数测试玩法', '夸克网盘', 'https://pan.quark.cn/s/a0127558575c', '1ad0d875a5714226b04107b6d63c3983', 'deleted', '2026-05-21 02:45:52', '2026-05-20 20:45:52', '2026-05-20 20:45:52', '2026-05-21 10:24:00', '2026-05-21 10:24:00'),
(60, 'https://pan.quark.cn/s/f152598ebee4', '老虎鱼 发烧精选测试碟1 dsd dsf', '夸克网盘', 'https://pan.quark.cn/s/7d72f73d89f2', '1d237075b1504a99b05addba952d3bab', 'deleted', '2026-05-21 02:45:52', '2026-05-20 20:45:52', '2026-05-20 20:45:52', '2026-05-21 10:24:00', '2026-05-21 10:24:00'),
(61, 'https://pan.quark.cn/s/1503fc53caa0', '老虎鱼 发烧精选测试碟2 dsd dsf', '夸克网盘', 'https://pan.quark.cn/s/b3c51b3bcc79', 'f433a50b6dca4cc283eb90351a55a132', 'deleted', '2026-05-21 02:45:55', '2026-05-20 20:45:55', '2026-05-20 20:45:55', '2026-05-21 10:24:01', '2026-05-21 10:24:01'),
(62, 'https://pan.quark.cn/s/c4d006cc2632', '美国专业测试第一天碟《典范录音三十周年精选》WAV 分轨', '夸克网盘', 'https://pan.quark.cn/s/4078cf274e74', '8e5a61a404034529980a25f13a371e9c', 'deleted', '2026-05-21 02:45:55', '2026-05-20 20:45:55', '2026-05-20 20:45:55', '2026-05-21 10:24:01', '2026-05-21 10:24:01'),
(63, 'https://pan.quark.cn/s/2c7923188648', 'SBTI人格测试源码，html源码，可本地使用，也可服务器部署', '夸克网盘', 'https://pan.quark.cn/s/840fc48fecac', '02c37196ec7448a18de6f095d62b2c22', 'deleted', '2026-05-21 02:45:55', '2026-05-20 20:45:55', '2026-05-20 20:45:55', '2026-05-21 10:24:02', '2026-05-21 10:24:02'),
(64, 'https://pan.quark.cn/s/8f01b73b083d', '#电影🗄 【电影】银翼杀手 中英双字 1982 4K📜', '夸克网盘', 'https://pan.quark.cn/s/183e0367ba50', 'b24baf9ddc5c46eab1b0b2fa7b259cd7', 'deleted', '2026-05-21 02:45:55', '2026-05-20 20:45:55', '2026-05-20 20:45:55', '2026-05-21 10:24:02', '2026-05-21 10:24:02'),
(65, 'https://pan.quark.cn/s/acef2944b42a', '测试', '夸克网盘', 'https://pan.quark.cn/s/c1044b0d147a', '18dffafbcfd7446793aeb64f649f02ce', 'deleted', '2026-05-21 02:45:55', '2026-05-20 20:45:55', '2026-05-20 20:45:55', '2026-05-21 10:24:03', '2026-05-21 10:24:03'),
(66, 'https://pan.quark.cn/s/1d7dbab430f9', '【安卓软件】DIY主题组件(1.00.3435)(无测试实图，该软件限制截屏)', '夸克网盘', 'https://pan.quark.cn/s/df851de0e818', '10b593e83c73457088c46b2536301034', 'deleted', '2026-05-21 02:45:58', '2026-05-20 20:45:58', '2026-05-20 20:45:58', '2026-05-21 10:24:03', '2026-05-21 10:24:03'),
(67, 'https://pan.quark.cn/s/8834db0dd41b', '剧名-街头测试，我的女儿你不该惹（60集）刘林&卢鑫晨', '夸克网盘', 'https://pan.quark.cn/s/9db246b74ac7', '3b5a90426fd3455e8310d21ea09b597d', 'deleted', '2026-05-21 02:45:58', '2026-05-20 20:45:58', '2026-05-20 20:45:58', '2026-05-21 10:24:04', '2026-05-21 10:24:04'),
(68, 'https://pan.quark.cn/s/ecffec9b8ade', '#短剧名称：玫瑰带刺华丽归来&婚前测试他不配 (83集) 李昕梦&陈七七 | 短剧·', '夸克网盘', 'https://pan.quark.cn/s/123dca251fb0', 'd586a405e96d462ea2a600ad6155d4ef', 'deleted', '2026-05-21 02:45:58', '2026-05-20 20:45:58', '2026-05-20 20:45:58', '2026-05-21 10:24:04', '2026-05-21 10:24:04'),
(69, 'https://pan.quark.cn/s/32243e796335', '【短剧】街头测试，我的女儿你不该惹（60集）刘林&卢鑫晨', '夸克网盘', 'https://pan.quark.cn/s/1b79d90d288a', 'f38a5ba897ff49b7847131c64dd05b49', 'deleted', '2026-05-21 02:45:58', '2026-05-20 20:45:58', '2026-05-20 20:45:58', '2026-05-21 10:56:24', '2026-05-21 10:56:24'),
(70, 'https://pan.quark.cn/s/5e278f3f5399', '【56集超清短剧】《退出他的爱情测试》孙航＆戚羽佳', '夸克网盘', 'https://pan.quark.cn/s/608acc849ed2', '08f88691147741cd8fb5e5eb6c2578ff', 'deleted', '2026-05-21 02:45:59', '2026-05-20 20:45:59', '2026-05-20 20:45:59', '2026-05-21 10:56:24', '2026-05-21 10:56:24'),
(71, 'https://pan.quark.cn/s/fa6a0da5303a', '剧名-退出他的爱情测试（56集）孙航＆戚羽佳', '夸克网盘', 'https://pan.quark.cn/s/a74931d29ce6', '326ab3f757404a6192a7697919d3a607', 'deleted', '2026-05-21 02:46:01', '2026-05-20 20:46:01', '2026-05-20 20:46:01', '2026-05-21 10:56:25', '2026-05-21 10:56:25'),
(72, 'https://pan.quark.cn/s/acc7c6362eac', '【短剧】退出他的爱情测试（56集）孙航＆戚羽佳', '夸克网盘', 'https://pan.quark.cn/s/0bdddd04ae28', '1b44be478f1c44808d22115bd68dd335', 'deleted', '2026-05-21 02:46:01', '2026-05-20 20:46:01', '2026-05-20 20:46:01', '2026-05-21 10:56:25', '2026-05-21 10:56:25'),
(73, 'https://pan.quark.cn/s/a223074f681e', '妻子的致命测试 (60集) 林元元&白龙 | 短剧', '夸克网盘', 'https://pan.quark.cn/s/e9e28209bc79', '8ed2bfd36bae4642a1c1af6c0070bf0f', 'deleted', '2026-05-21 02:46:01', '2026-05-20 20:46:01', '2026-05-20 20:46:01', '2026-05-21 10:56:26', '2026-05-21 10:56:26'),
(74, 'https://pan.quark.cn/s/172559291fcf', '姜振宇《微表情心理应用课》，堪称人际交往的“透视镜”！作为中国心理应激微反应测试研究第一人，姜振宇老师将十年微表情研究成果浓缩于课程中。课程仅10期，短小精悍，却涵盖丰富知识。通过大量影视和热点案例，如分析川普表情、郑爽情绪崩溃等，生动阐述微表情知识。从惊讶、厌恶到愤怒、恐惧等情绪解读，到职场、恋爱、社交等多场景应用，助你7天洞察人心。无论你是想在职场识破老板画饼，还是在恋爱中判断对方真心，亦或是在社交中分辨真假朋友，这门课都能让你精准识破谎言与情绪秘密，轻松掌握微表情奥秘，提升人际交往能力。', '夸克网盘', 'https://pan.quark.cn/s/413b1b4799ff', '33cc07a7ad5b40db9f7faa2f10ffdabf', 'deleted', '2026-05-21 02:46:01', '2026-05-20 20:46:01', '2026-05-20 20:46:01', '2026-05-21 10:56:27', '2026-05-21 10:56:27'),
(75, 'https://pan.quark.cn/s/cde573a0d952', '短剧-妻子的致命测试（60集）林元元&白龙', '夸克网盘', 'https://pan.quark.cn/s/ebe4a466b707', '8db393ee4b7847d1b3c12eeaa09ebb4f', 'deleted', '2026-05-21 02:46:02', '2026-05-20 20:46:02', '2026-05-20 20:46:02', '2026-05-21 10:56:27', '2026-05-21 10:56:27'),
(76, 'https://pan.quark.cn/s/e81ae336aadd', '📚名称：慕课网-Python自动化测试开发实战，能帮你就业的测试课', '夸克网盘', 'https://pan.quark.cn/s/14aca5c0e3c1', 'b2d8b8093d574f158abbce586ce277b6', 'deleted', '2026-05-21 02:46:03', '2026-05-20 20:46:03', '2026-05-20 20:46:03', '2026-05-21 10:56:28', '2026-05-21 10:56:28'),
(77, 'https://pan.quark.cn/s/819ae408a205', '【短剧】妻子的致命测试（60集）林元元&白龙', '夸克网盘', 'https://pan.quark.cn/s/f44409ce1a3e', 'e39e1db1aa214e90bdcdbf189726f01e', 'deleted', '2026-05-21 02:46:04', '2026-05-20 20:46:04', '2026-05-20 20:46:04', '2026-05-21 10:56:28', '2026-05-21 10:56:28'),
(78, 'https://pan.quark.cn/s/fece44a1e3a6', '📚名称：《咕泡-P4软件测试零基础入门（就业班）》', '夸克网盘', 'https://pan.quark.cn/s/58e45c3da7fd', 'ddc0c01ecdab4a12af37fd0b94c89da7', 'deleted', '2026-05-21 02:46:04', '2026-05-20 20:46:04', '2026-05-20 20:46:04', '2026-05-21 10:56:29', '2026-05-21 10:56:29'),
(79, 'https://pan.quark.cn/s/987e65413f0b', '📚名称：虫师测试开发班（1-3期）', '夸克网盘', 'https://pan.quark.cn/s/5c532670d992', 'e4de8f703b5c4c939477202758fe7cd6', 'deleted', '2026-05-21 02:46:04', '2026-05-20 20:46:04', '2026-05-20 20:46:04', '2026-05-21 10:56:29', '2026-05-21 10:56:29'),
(80, 'https://pan.quark.cn/s/0b21527919b3', '《真爱测试报告（66集）黄波&张溪桐》', '夸克网盘', 'https://pan.quark.cn/s/5abbd479fc9c', 'b079818956fc47679b06c544f8462c49', 'deleted', '2026-05-21 02:46:05', '2026-05-20 20:46:05', '2026-05-20 20:46:05', '2026-05-21 10:56:30', '2026-05-21 10:56:30'),
(81, 'https://pan.quark.cn/s/e1216342873b', '剧名-真爱测试报告（66集）黄波&张溪桐', '夸克网盘', 'https://pan.quark.cn/s/28f211602bba', 'a097e4a2e02b4d13a61998de9a6540fe', 'deleted', '2026-05-21 02:46:07', '2026-05-20 20:46:07', '2026-05-20 20:46:07', '2026-05-21 10:56:30', '2026-05-21 10:56:30'),
(82, 'https://pan.quark.cn/s/05eba64b486e', '短剧：真爱测试报告（66集）黄波&张溪桐', '夸克网盘', 'https://pan.quark.cn/s/7528878b160e', '1bbe2b06dfde485eafce58843947e6e1', 'deleted', '2026-05-21 02:46:07', '2026-05-20 20:46:07', '2026-05-20 20:46:07', '2026-05-21 10:56:31', '2026-05-21 10:56:31'),
(83, 'https://pan.quark.cn/s/e5948b8fb071', '《不测的秘密:精准测试之路 (实战)》（epub）', '夸克网盘', 'https://pan.quark.cn/s/a261578c3ed2', '72a277944fb14ea0a62aa7fffa6f8975', 'deleted', '2026-05-21 02:46:07', '2026-05-20 20:46:07', '2026-05-20 20:46:07', '2026-05-21 10:56:31', '2026-05-21 10:56:31'),
(84, 'https://pan.quark.cn/s/a95cd50af1a6', '📚名称：【霍格沃兹】Python测试开发班 - 12期 - 带源码课件', '夸克网盘', 'https://pan.quark.cn/s/9bcd92dad083', '56fb0738ed4e46858cdb38884d619896', 'deleted', '2026-05-21 02:46:08', '2026-05-20 20:46:08', '2026-05-20 20:46:08', '2026-05-21 10:56:32', '2026-05-21 10:56:32'),
(85, 'https://pan.quark.cn/s/1a02e3031200', '📚名称：蚁景-渗透测试10期', '夸克网盘', 'https://pan.quark.cn/s/2f90e179fc77', 'af41df3de1564a9bb5f6d9a6b96e64ba', 'deleted', '2026-05-21 02:46:08', '2026-05-20 20:46:08', '2026-05-20 20:46:08', '2026-05-21 10:56:32', '2026-05-21 10:56:32'),
(86, 'https://pan.quark.cn/s/89df9015b4f0', '发烧低音测试曲-低频霸主 WAV', '夸克网盘', 'https://pan.quark.cn/s/6c7478c14c5c', 'ebeaf6e2acdc4cc0acefd366de387aa7', 'deleted', '2026-05-21 02:46:09', '2026-05-20 20:46:09', '2026-05-20 20:46:09', '2026-05-21 10:56:33', '2026-05-21 10:56:33'),
(87, 'https://pan.quark.cn/s/3221cc481a84', '#短剧名称：玫瑰带刺华丽归来&婚前测试他不配（83集）李昕梦&陈七七', '夸克网盘', 'https://pan.quark.cn/s/09547630b0a4', '5f9fec7e227444a7a555f0f7f2aa6b65', 'deleted', '2026-05-21 02:46:10', '2026-05-20 20:46:10', '2026-05-20 20:46:10', '2026-05-21 10:56:33', '2026-05-21 10:56:33'),
(88, 'https://pan.quark.cn/s/4386bf51604a', '美剧：哥本哈根测试 [2025]', '夸克网盘', 'https://pan.quark.cn/s/92bdb55f5a7b', '029f76356a8e47e6be5b5bad5cb65a50', 'deleted', '2026-05-21 02:46:10', '2026-05-20 20:46:10', '2026-05-20 20:46:10', '2026-05-21 10:56:34', '2026-05-21 10:56:34'),
(89, 'https://pan.quark.cn/s/15cfe93e2942', '短剧-玫瑰带刺华丽归来＆婚前测试他不配（83集）李昕梦＆陈七七', '夸克网盘', 'https://pan.quark.cn/s/61571598bc62', '25f505f4ca2f4b45b44fb51c2a5dff9d', 'deleted', '2026-05-21 02:46:11', '2026-05-20 20:46:11', '2026-05-20 20:46:11', '2026-05-21 10:56:34', '2026-05-21 10:56:34'),
(90, 'https://pan.quark.cn/s/4b6171b57a35', '短剧：玫瑰带刺华丽归来＆婚前测试他不配（83集）李昕梦＆陈七七', '夸克网盘', 'https://pan.quark.cn/s/17478db94d2c', 'ce756ac7d81d46149cb47fe98f2a08a7', 'deleted', '2026-05-21 02:46:12', '2026-05-20 20:46:12', '2026-05-20 20:46:12', '2026-05-21 10:56:35', '2026-05-21 10:56:35'),
(91, 'https://pan.quark.cn/s/46f8c09ea76d', '电影： 《测试.2022 美国惊悚.mkv》', '夸克网盘', 'https://pan.quark.cn/s/f83a2a91b54b', 'c23d09faf40047819c122f09ed79a4bd', 'deleted', '2026-05-21 02:46:12', '2026-05-20 20:46:12', '2026-05-20 20:46:12', '2026-05-21 10:56:35', '2026-05-21 10:56:35'),
(92, 'https://pan.quark.cn/s/4e1a206d4850', '【标题】：幸运测试器 – 每天一卦让你开心一整天 好运满满', '夸克网盘', 'https://pan.quark.cn/s/a8ca71162c3b', 'cf4cb8dbb00b4a829fa590e3e702c45c', 'deleted', '2026-05-21 02:46:13', '2026-05-20 20:46:13', '2026-05-20 20:46:13', '2026-05-21 10:56:36', '2026-05-21 10:56:36'),
(93, 'https://pan.quark.cn/s/1207e3f54afe', '【标题】：WiFi和路由器管理测速工具 – 路由器管理员设置控制和速度测试', '夸克网盘', 'https://pan.quark.cn/s/7883408d410f', '03f3392902024f4fa4f30c382b644a16', 'deleted', '2026-05-21 02:46:13', '2026-05-20 20:46:13', '2026-05-20 20:46:13', '2026-05-21 10:56:37', '2026-05-21 10:56:37'),
(94, 'https://pan.baidu.com/s/1hDPEGtAqBMTcyPO-OKK_RA?pwd=8888', '哥本哈根测试', '百度网盘', 'https://pan.baidu.com/s/1OgfjwHLFTD6U1r98gl7PRA?pwd=6666', '13976856878459', 'active', '2026-05-21 02:46:16', '2026-05-20 20:46:16', '2026-05-20 20:46:16', '2026-05-20 20:46:16', NULL),
(95, 'https://pan.baidu.com/s/1q9Pj_Vd9hC0IODik-CTLQg?pwd=xtn5', '#综艺🗄 試真D（2026）TVB翡翠台标.粤语繁体中字.720p.WEB-DL.H.264.AAC2.0.mp4 (更新至 15 集)📜', '百度网盘', 'https://pan.baidu.com/s/1ZlvdSlCYR1tGEoMv2ScRDg?pwd=6666', '1021303755805017', 'active', '2026-05-21 02:46:16', '2026-05-20 20:46:16', '2026-05-20 20:46:16', '2026-05-20 20:46:16', NULL),
(96, 'https://pan.baidu.com/s/1EHS93LRoGVHkuBljMmahrg?pwd=5ui7', '【电脑软件】火绒全新工具 强力卸载 测试版（1.00.3）', '百度网盘', 'https://pan.baidu.com/s/11wcXOTeIFxoFz1SEI2L_HA?pwd=6666', '145895870992934', 'active', '2026-05-21 02:46:16', '2026-05-20 20:46:16', '2026-05-20 20:46:16', '2026-05-20 20:46:16', NULL),
(97, 'https://pan.baidu.com/s/1qUUzSaowNWYB_0lw6fif7Q?pwd=kick', '金色大厅音箱测试壹号wav+cue 低速原抓', '百度网盘', 'https://pan.baidu.com/s/1kTPqXRaCPDM9Y0qMHJh_8g?pwd=6666', '603716272202765', 'active', '2026-05-21 02:46:17', '2026-05-20 20:46:17', '2026-05-20 20:46:17', '2026-05-20 20:46:17', NULL),
(98, 'https://pan.baidu.com/s/178e7_4xonqR200RU_a-qpw?pwd=cedp', '【安卓软件】DIY主题组件(1.00.3435)(无测试实图，该软件限制截屏)', '百度网盘', 'https://pan.baidu.com/s/1KcGXkiGL9aQ-ksp9XPb-jQ?pwd=6666', '527410792663478', 'active', '2026-05-21 02:46:17', '2026-05-20 20:46:17', '2026-05-20 20:46:17', '2026-05-20 20:46:17', NULL),
(99, 'https://pan.baidu.com/s/1R1fqDs6W0jwLhpSpas45Hg?pwd=8888', '【短剧】街头测试，我的女儿你不该惹（60集）刘林&卢鑫晨', '百度网盘', 'https://pan.baidu.com/s/1jLKvCX6MH1Vmrx22mKi_Bg?pwd=6666', '164628425144862', 'active', '2026-05-21 02:46:20', '2026-05-20 20:46:20', '2026-05-20 20:46:20', '2026-05-20 20:46:20', NULL),
(100, 'https://pan.baidu.com/s/10MfoYcOCE_uLqhydfmgo1Q?pwd=8888', '【短剧】退出他的爱情测试（56集）孙航＆戚羽佳', '百度网盘', 'https://pan.baidu.com/s/1yIagBatIRBNmySOprwqh4g?pwd=6666', '368921055964701', 'active', '2026-05-21 02:46:21', '2026-05-20 20:46:21', '2026-05-20 20:46:21', '2026-05-20 20:46:21', NULL),
(101, 'https://pan.baidu.com/s/1bc_b58SUGkGx48OpET6u-g?pwd=anbb', '剧名-街头测试，我的女儿你不该惹（60集）刘林&卢鑫晨', '百度网盘', 'https://pan.baidu.com/s/1MUTY5KofNO8sMp0eIebP3Q?pwd=6666', '923083261432016', 'active', '2026-05-21 02:46:22', '2026-05-20 20:46:22', '2026-05-20 20:46:22', '2026-05-20 20:46:22', NULL),
(102, 'https://pan.baidu.com/s/1cqS3KKF78aUc8MgtLzpIyg?pwd=8888', '【短剧】妻子的致命测试（60集）林元元&白龙', '百度网盘', 'https://pan.baidu.com/s/1AiiI8gfmYFl7bYPdPTnxtQ?pwd=6666', '786786302527288', 'active', '2026-05-21 02:46:23', '2026-05-20 20:46:23', '2026-05-20 20:46:23', '2026-05-20 20:46:23', NULL),
(103, 'https://pan.baidu.com/s/143f9XWgrh1Pt9tnrrFt7Hw?pwd=8888', '【短剧】真爱测试报告（66集）黄波&张溪桐', '百度网盘', 'https://pan.baidu.com/s/1TjsJUwOyCUtKHzMzRc5KTw?pwd=6666', '1037033983650118', 'active', '2026-05-21 02:46:25', '2026-05-20 20:46:25', '2026-05-20 20:46:25', '2026-05-20 20:46:25', NULL),
(104, 'https://pan.baidu.com/s/1NlkvA0BAy_HdsFtZllwSVw?pwd=vryv', '短剧：真爱测试报告（66集）黄波&张溪桐', '百度网盘', 'https://pan.baidu.com/s/1ctkGHCDHOYG7Z6kkRoI77A?pwd=6666', '363984630976810', 'active', '2026-05-21 02:46:25', '2026-05-20 20:46:25', '2026-05-20 20:46:25', '2026-05-20 20:46:25', NULL),
(105, 'https://pan.baidu.com/s/1im3u7IK7aUTI39SFuS4Tqg?pwd=3cgx', '《不测的秘密:精准测试之路 (实战)》（epub）', '百度网盘', 'https://pan.baidu.com/s/1lRhpIhNQKYZFSqepujfTCQ?pwd=6666', '428323967394274', 'active', '2026-05-21 02:46:26', '2026-05-20 20:46:26', '2026-05-20 20:46:26', '2026-05-20 20:46:26', NULL),
(106, 'https://pan.baidu.com/s/15XyDEQQS4eXEPkf7VRuslg?pwd=jb9i', '#短剧名称：玫瑰带刺华丽归来&婚前测试他不配（83集）李昕梦&陈七七', '百度网盘', 'https://pan.baidu.com/s/1E4JbMMfk1YOk36T6Ys77gw?pwd=6666', '306607365131418', 'active', '2026-05-21 02:46:28', '2026-05-20 20:46:28', '2026-05-20 20:46:28', '2026-05-20 20:46:28', NULL),
(107, 'https://drive.uc.cn/s/c5ba6206521e4', '#综艺🗄 試真D（2026）TVB翡翠台标.粤语繁体中字.720p.WEB-DL.H.264.AAC2.0.mp4 (更新至 15 集)📜', 'UC网盘', 'https://drive.uc.cn/s/480a3288c4f74', '[\"7a928a25c1a74d6ebf9e40639250f9d4\"]', 'deleted', '2026-05-21 02:46:28', '2026-05-20 20:46:28', '2026-05-20 20:46:28', '2026-05-21 19:43:57', '2026-05-21 19:43:57'),
(108, 'https://pan.baidu.com/s/1nBk2O2G2v6pnfNZzLVK0uA?pwd=8888', '短剧：玫瑰带刺华丽归来＆婚前测试他不配（83集）李昕梦＆陈七七', '百度网盘', 'https://pan.baidu.com/s/1j3VXoROf7aSXjTKijk4hKA?pwd=6666', '120559155488909', 'active', '2026-05-21 02:46:29', '2026-05-20 20:46:29', '2026-05-20 20:46:29', '2026-05-20 20:46:29', NULL),
(109, 'https://drive.uc.cn/s/c4a940b65f494', '【电脑软件】火绒全新工具 强力卸载 测试版（1.00.3）', 'UC网盘', 'https://drive.uc.cn/s/35ad8b28ca104', '[\"c6a86c418d094deb80dee195617f8e0a\"]', 'deleted', '2026-05-21 02:46:30', '2026-05-20 20:46:30', '2026-05-20 20:46:30', '2026-05-21 19:43:58', '2026-05-21 19:43:58'),
(110, 'https://drive.uc.cn/s/4a28830277824', '【电脑软件】图形化网络测试工具', 'UC网盘', 'https://drive.uc.cn/s/94de7931b3954', '[\"ff3a8fa06d6943d6abe91bb2b111136f\"]', 'deleted', '2026-05-21 02:46:30', '2026-05-20 20:46:30', '2026-05-20 20:46:30', '2026-05-21 19:43:58', '2026-05-21 19:43:58'),
(111, 'https://pan.baidu.com/s/15LnSFNZYKkxp51-vXfI6EA?pwd=swx8', '比利·林恩的中场战事 (2016) 4K原盘REMUX HDR 国英双音 内封字幕 推荐做为高端播放设备及家庭影院设备的对比测试片使用', '百度网盘', 'https://pan.baidu.com/s/1BidttlD_LqxhG_-WzQTSmQ?pwd=6666', '335960348218225', 'active', '2026-05-21 02:46:31', '2026-05-20 20:46:31', '2026-05-20 20:46:31', '2026-05-20 20:46:31', NULL),
(112, 'https://drive.uc.cn/s/aedba960d9934', '【安卓软件】DIY主题组件(1.00.3435)(无测试实图，该软件限制截屏)', 'UC网盘', 'https://drive.uc.cn/s/58fb8b0589674', '[\"3b8b5d79c1f94c4395dccfc6926b308c\"]', 'deleted', '2026-05-21 02:46:31', '2026-05-20 20:46:31', '2026-05-20 20:46:31', '2026-05-21 19:43:58', '2026-05-21 19:43:58'),
(113, 'https://drive.uc.cn/s/5930c396dc874?public=1', '🔥【美剧】哥本哈根测试 The Copenhagen Test (2025) 1080P高清 动作/科幻/奇幻 英语中字', 'UC网盘', 'https://drive.uc.cn/s/64b272da209a4', '[\"0f757d6037b64f699af20a13f69afe1e\"]', 'deleted', '2026-05-21 02:46:32', '2026-05-20 20:46:32', '2026-05-20 20:46:32', '2026-05-21 19:43:59', '2026-05-21 19:43:59'),
(114, 'https://pan.baidu.com/s/1qaEsnRkhQvdHgbDyd8GMyQ?pwd=kick', '50首Jazz 爵士经典曲目 音响测试 Hi-Res 音频 FLAC', '百度网盘', 'https://pan.baidu.com/s/1ZQX-Jsk_wLydGWMibvl_1Q?pwd=6666', '1011268649902232', 'active', '2026-05-21 02:46:32', '2026-05-20 20:46:32', '2026-05-20 20:46:32', '2026-05-20 20:46:32', NULL),
(115, 'https://drive.uc.cn/s/19a05879fb074', '《不测的秘密:精准测试之路 (实战)》（epub）', 'UC网盘', 'https://drive.uc.cn/s/53a1b535ffef4', '[\"0679765d27f44f01be393c23474de046\"]', 'deleted', '2026-05-21 02:46:32', '2026-05-20 20:46:32', '2026-05-20 20:46:32', '2026-05-21 19:43:59', '2026-05-21 19:43:59'),
(116, 'https://drive.uc.cn/s/e671e22a1d164?public=1', '#短剧名称：玫瑰带刺华丽归来&婚前测试他不配（83集）李昕梦&陈七七', 'UC网盘', 'https://drive.uc.cn/s/590bbd092d2a4', '[\"baf8ddc36b534e0088aacdeb6cb4afac\"]', 'deleted', '2026-05-21 02:46:33', '2026-05-20 20:46:33', '2026-05-20 20:46:33', '2026-05-21 19:44:00', '2026-05-21 19:44:00'),
(117, 'https://pan.quark.cn/s/0e03506aaa96', '📚名称：【极客时间-test】测试开发进阶训练营', '夸克网盘', 'https://pan.quark.cn/s/7fcb06f747eb', 'de5d2f3900bf4231917d80713f7270fa', 'deleted', '2026-05-21 02:47:26', '2026-05-20 20:47:45', '2026-05-20 20:47:26', '2026-05-21 19:44:00', '2026-05-21 19:44:00'),
(118, 'https://pan.quark.cn/s/8ad695dd494c', '马戏之王 The Greatest Showman (2017)', '夸克网盘', 'https://pan.quark.cn/s/00a4de8a3a81', '405c404421a843d5bad67f304403acf4', 'deleted', '2026-05-21 02:47:47', '2026-05-20 20:47:47', '2026-05-20 20:47:47', '2026-05-21 19:44:01', '2026-05-21 19:44:01'),
(119, 'https://pan.quark.cn/s/bc9f2545299e', '最强壮的 The Fittest (2020)', '夸克网盘', 'https://pan.quark.cn/s/c3410e4cf32b', 'a2e8728efe84498a81e22a3fb4277ef2', 'deleted', '2026-05-21 02:47:47', '2026-05-20 20:47:47', '2026-05-20 20:47:47', '2026-05-21 20:13:58', '2026-05-21 20:13:58'),
(120, 'https://pan.quark.cn/s/c2b883ebdc0c', '革命往事 Giù la testa (1971)', '夸克网盘', 'https://pan.quark.cn/s/ab1dff1046cb', '6c66a31311e74b0ea1c2c4538ecfe713', 'deleted', '2026-05-21 02:47:47', '2026-05-20 20:47:47', '2026-05-20 20:47:47', '2026-05-21 20:13:58', '2026-05-21 20:13:58'),
(121, 'https://pan.quark.cn/s/0bb1d65cf4de', '有史以来最棒的啤酒运送 The Greatest Beer Run Ever (2022)', '夸克网盘', 'https://pan.quark.cn/s/9f9c62267518', '19eb2e2b85584ce3a50c486ca58c90f7', 'deleted', '2026-05-21 02:47:47', '2026-05-20 20:47:47', '2026-05-20 20:47:47', '2026-05-21 20:13:59', '2026-05-21 20:13:59'),
(122, 'https://pan.quark.cn/s/bfc4468c145a', '庆余年之大赵逍遥王（88集）', '夸克网盘', 'https://pan.quark.cn/s/22681bed6656', 'a94e5e7fce4b4463a99a295925eab8b1', 'deleted', '2026-05-21 03:25:09', '2026-05-20 21:25:15', '2026-05-20 21:25:09', '2026-05-21 20:13:59', '2026-05-21 20:13:59'),
(123, 'https://pan.quark.cn/s/80974b368a90', '庆余年，全世界都以为我是废物太子$庆余年之大凉太子爷（81集）', '夸克网盘', 'https://pan.quark.cn/s/ba411b79dd6c', '377cfb46f9a344e5a1b0f460b6e94955', 'deleted', '2026-05-21 03:25:10', '2026-05-20 21:25:15', '2026-05-20 21:25:10', '2026-05-21 20:14:00', '2026-05-21 20:14:00'),
(124, 'https://pan.quark.cn/s/c581574a86f3', '庆余年之风起沧州（74集）范琪 尚雨茜 侍宣如', '夸克网盘', 'https://pan.quark.cn/s/bcf7730d3bae', 'df850d59ed434ff2b60a51f036c3f7e2', 'deleted', '2026-05-21 03:25:11', '2026-05-20 21:25:19', '2026-05-20 21:25:11', '2026-05-21 20:14:00', '2026-05-21 20:14:00'),
(125, 'https://pan.quark.cn/s/c4b8cd62e8a9', '庆余年之少年风流（75集）', '夸克网盘', 'https://pan.quark.cn/s/ac0121de3e1a', 'dacc2754932d4023a4ec084114c84878', 'deleted', '2026-05-21 03:25:11', '2026-05-20 21:25:19', '2026-05-20 21:25:11', '2026-05-21 20:14:01', '2026-05-21 20:14:01'),
(126, 'https://pan.quark.cn/s/d065c4e9180f', '6134-庆余年之大赵逍遥王（88集）', '夸克网盘', 'https://pan.quark.cn/s/ee472193fb01', '4b926c5267e344c7979b2efb1cc7fbe3', 'deleted', '2026-05-21 03:25:14', '2026-05-20 21:25:19', '2026-05-20 21:25:14', '2026-05-21 20:14:01', '2026-05-21 20:14:01'),
(127, 'https://pan.quark.cn/s/f6780b112d8f', '庆余年之少年风流', '夸克网盘', 'https://pan.quark.cn/s/baf019e0dc57', '64c0092bf32f4efaaeb768764815c76b', 'deleted', '2026-05-21 03:25:14', '2026-05-20 21:25:14', '2026-05-20 21:25:14', '2026-05-21 20:14:02', '2026-05-21 20:14:02'),
(128, 'https://pan.quark.cn/s/8af6997d9dae', '庆余年 第二季', '夸克网盘', 'https://pan.quark.cn/s/99ddf541244b', '73a29507d0584c1c83a2ef5658f3111a', 'deleted', '2026-05-21 03:25:15', '2026-05-20 21:25:15', '2026-05-20 21:25:15', '2026-05-21 20:43:57', '2026-05-21 20:43:57'),
(129, 'https://pan.quark.cn/s/75fac4c1cd31', '庆余年第二季', '夸克网盘', 'https://pan.quark.cn/s/28d269b22b94', 'f489e35dba924146b96325a5fa33fd94', 'deleted', '2026-05-21 03:25:15', '2026-05-20 21:25:15', '2026-05-20 21:25:15', '2026-05-21 20:43:58', '2026-05-21 20:43:58'),
(130, 'https://pan.quark.cn/s/be413d9c83f3', '庆余年之帝王业', '夸克网盘', 'https://pan.quark.cn/s/04f6cc0478d1', '806c62b492074c36af61a28863141157', 'deleted', '2026-05-21 03:25:15', '2026-05-20 21:25:15', '2026-05-20 21:25:15', '2026-05-21 20:43:58', '2026-05-21 20:43:58'),
(131, 'https://pan.quark.cn/s/3b852d9ca5fb', '庆余年之风起沧州', '夸克网盘', 'https://pan.quark.cn/s/0a24633f4ddc', 'e2ce79ef11714088aa328b869d3d229c', 'deleted', '2026-05-21 03:25:18', '2026-05-20 21:25:18', '2026-05-20 21:25:18', '2026-05-21 20:43:59', '2026-05-21 20:43:59'),
(132, 'https://pan.quark.cn/s/2fccde84424c', '庆余年 第一季', '夸克网盘', 'https://pan.quark.cn/s/c7527c614be5', 'a29391ad5cb0457eab4e62a4e49df021', 'deleted', '2026-05-21 03:25:19', '2026-05-20 21:25:19', '2026-05-20 21:25:19', '2026-05-21 20:43:59', '2026-05-21 20:43:59'),
(133, 'https://pan.quark.cn/s/8bac14569a6a', '庆余年第一季 特别版', '夸克网盘', 'https://pan.quark.cn/s/d7f7aff0af9c', '3323fc79524d4dab9afdf6d8814d2db5', 'deleted', '2026-05-21 03:25:19', '2026-05-20 21:25:19', '2026-05-20 21:25:19', '2026-05-21 20:44:00', '2026-05-21 20:44:00'),
(134, 'https://pan.quark.cn/s/d9f590af667e', '庆余年第二季 4K[臻彩]', '夸克网盘', 'https://pan.quark.cn/s/5a1c0b5d3573', '6bb8915ccf0e46309057b87d7919b0e6', 'deleted', '2026-05-21 03:25:20', '2026-05-20 21:25:20', '2026-05-20 21:25:20', '2026-05-21 20:44:00', '2026-05-21 20:44:00'),
(135, 'https://pan.quark.cn/s/6b37c6aa9a63', '《张若昀影视合集》', '夸克网盘', 'https://pan.quark.cn/s/865d0f4ea75a', '55220869b0414116abd8ca6d23fe224d', 'deleted', '2026-05-21 03:25:21', '2026-05-20 21:25:21', '2026-05-20 21:25:21', '2026-05-21 20:44:01', '2026-05-21 20:44:01'),
(136, 'https://pan.quark.cn/s/884648586e4d', '🗄 【国剧】庆余年 全2季 国语中字 2019-2024 4K', '夸克网盘', 'https://pan.quark.cn/s/5270369060f8', '8b3cf0e0d0a449f1b56f4dd7397030f4', 'deleted', '2026-05-21 03:25:22', '2026-05-20 21:25:22', '2026-05-20 21:25:22', '2026-05-21 20:44:01', '2026-05-21 20:44:01'),
(137, 'https://pan.quark.cn/s/d5256540c9d1', '《【国产剧】庆.余.年.全2季.国语中字.2024.4K》权谋智斗与江湖热血交织，范闲的传奇人生再掀高潮，4K画质沉浸体验️ #权谋 #庆余年 #腾讯视频 2025-06-25 13:44:21', '夸克网盘', 'https://pan.quark.cn/s/361d8d2d53b5', '6ca4a717997541019e9c7d9401fdf861', 'deleted', '2026-05-21 03:25:23', '2026-05-20 21:25:23', '2026-05-20 21:25:23', '2026-05-21 21:13:59', '2026-05-21 21:13:59'),
(138, 'https://pan.quark.cn/s/05f3ee518833', '《庆余年 全3季无删》权谋智斗反转不断，范闲逆袭成长史，老戏骨飙戏张力十足，剧情烧脑又爽感爆棚。#权谋爽剧 #庆余年 #腾讯视频独播2025-09-18 03:40:01', '夸克网盘', 'https://pan.quark.cn/s/39207e2dc352', '4027154500734184acd728bafbf424f3', 'deleted', '2026-05-21 03:25:23', '2026-05-20 21:25:23', '2026-05-20 21:25:23', '2026-05-21 21:13:59', '2026-05-21 21:13:59'),
(139, 'https://pan.quark.cn/s/8f8e776919a3', '【标题】：庆余年2 (2024) 4K 全集【描述】：该剧改编自猫腻同名畅销小说，承接上季，范闲（张若昀 饰）率领使团回归途中，二皇子以费介、范思辙以及滕家遗孤的安危来威胁范闲，逼他向自己俯首称臣，二人的矛盾就此激发。范闲所面对的抱月楼迷局，以及接踵而至的春闱危机，都是二皇子精心给范闲布下的陷阱。下载地址', '夸克网盘', 'https://pan.quark.cn/s/0e20437cb4f0', '9390fa41c80c44bc8afe073d5780aa82', 'deleted', '2026-05-21 03:25:24', '2026-05-20 21:25:24', '2026-05-20 21:25:24', '2026-05-21 21:14:00', '2026-05-21 21:14:00'),
(140, 'https://pan.quark.cn/s/4343af733b22', '《庆余年[全36集]》权谋智斗与江湖热血交织，范闲的逆袭之路充满悬念与感动，剧情紧凑扣人心弦。️ #权谋 #庆余年 #腾讯视频 2025-06-28 23:04:20', '夸克网盘', 'https://pan.quark.cn/s/8fc2c44cd323', 'e8a2149735a244b4bcdd47cca9eff7ac', 'deleted', '2026-05-21 03:25:24', '2026-05-20 21:25:24', '2026-05-20 21:25:24', '2026-05-21 21:14:00', '2026-05-21 21:14:00'),
(141, 'https://pan.quark.cn/s/0b867f78679e', '《庆余年 全 4k + 小说 》', '夸克网盘', 'https://pan.quark.cn/s/5a7fe5677739', 'd48315b6eaad4b7c8f389b0aff587acb', 'deleted', '2026-05-21 03:25:25', '2026-05-20 21:25:25', '2026-05-20 21:25:25', '2026-05-21 21:14:01', '2026-05-21 21:14:01'),
(142, 'https://pan.quark.cn/s/c9c30274ad21', '《庆余年2 全集 高清》', '夸克网盘', 'https://pan.quark.cn/s/af45f241ddd2', '2ffe3a288bba46d682034b098533e137', 'deleted', '2026-05-21 03:25:26', '2026-05-20 21:25:26', '2026-05-20 21:25:26', '2026-05-21 21:14:02', '2026-05-21 21:14:02'),
(143, 'https://pan.quark.cn/s/396eaa4b0890', '🎬 《【国产剧】庆余年.全2季.国语中字.2024.4K》', '夸克网盘', 'https://pan.quark.cn/s/4f9c93031f1c', 'fb0253905f17490bb19d9fe9c5a1b053', 'deleted', '2026-05-21 03:25:26', '2026-05-20 21:25:26', '2026-05-20 21:25:26', '2026-05-21 21:14:02', '2026-05-21 21:14:02'),
(144, 'https://pan.quark.cn/s/8c62edcde4bd', '【标题】：庆余年-有声书 梁小渔版 CV全明星配音【描述】：庆余年有声电子书 全集，电视剧第二季内容请从321集起听下载地址', '夸克网盘', 'https://pan.quark.cn/s/9f049c74b897', 'ad6c74915e684baa8ad1669cc262fb67', 'deleted', '2026-05-21 03:25:27', '2026-05-20 21:25:27', '2026-05-20 21:25:27', '2026-05-21 21:14:03', '2026-05-21 21:14:03'),
(145, 'https://pan.quark.cn/s/49623054c53a', '庆余年1-2季全集 4K 中文字幕', '夸克网盘', 'https://pan.quark.cn/s/b74f63e8c983', '3a030627a46a45efb62a4c0b7471851f', 'deleted', '2026-05-21 03:25:28', '2026-05-20 21:25:28', '2026-05-20 21:25:28', '2026-05-21 21:14:04', '2026-05-21 21:14:04'),
(146, 'https://pan.quark.cn/s/9a1f47006456', '【电影】庆余年（2019）全46集 4K|电视剧|', '夸克网盘', 'https://pan.quark.cn/s/65df0c1662a7', '4d09cefd79dd4579aa2fa9aeae54719b', 'deleted', '2026-05-21 03:25:28', '2026-05-20 21:25:28', '2026-05-20 21:25:28', '2026-05-21 21:43:57', '2026-05-21 21:43:57'),
(147, 'https://pan.quark.cn/s/7114a5c940a4', '【短剧】庆余年，全世界都以为我是废物太子$庆余年之大凉太子爷（81集）', '夸克网盘', 'https://pan.quark.cn/s/9654feb13956', 'c2fddf53f9cc4e25afead12d0000c87c', 'deleted', '2026-05-21 03:25:29', '2026-05-20 21:25:29', '2026-05-20 21:25:29', '2026-05-21 21:43:58', '2026-05-21 21:43:58'),
(148, 'https://pan.quark.cn/s/0a492f96ecca', '庆余年 第二季 [2024]【36集全】 4K 杜比国语', '夸克网盘', 'https://pan.quark.cn/s/652cbecc1e48', '276a38e167274d65bec351426d6f2a48', 'deleted', '2026-05-21 03:25:29', '2026-05-20 21:25:29', '2026-05-20 21:25:29', '2026-05-21 21:43:59', '2026-05-21 21:43:59'),
(149, 'https://pan.quark.cn/s/027cecefa4ba', '庆余年 4K杜比国语 【36 集完结】', '夸克网盘', 'https://pan.quark.cn/s/4e68a5d5a52d', '49e650d8f2184287984601720f38db84', 'deleted', '2026-05-21 03:25:30', '2026-05-20 21:25:30', '2026-05-20 21:25:30', '2026-05-21 21:43:59', '2026-05-21 21:43:59'),
(150, 'https://pan.quark.cn/s/63d9e565217e', '【标题】：庆余年 第二季 (2024) 4K/1080P 国语中字 超前点映 36集完结 张若昀 / 李沁 / 陈道明【描述】：“该剧改编自猫腻同名畅销电子书，承接上季，范闲（张若昀 饰）率领使团回归途中，二皇子以费介、范思辙以及滕家遗孤的安危来威胁范闲，逼他向自己俯首称臣，二人的矛盾就此激发。范闲所面对的抱月楼迷局，以及接踵而至的春闱危机，都是二皇子精心给范闲布下的陷阱。范闲与林婉儿如愿大婚，紧接着，范闲接手内库，却发现内库负债累累。 范闲拒绝了庆余堂大掌柜的相助，决定靠自己的力量解决内库危机，范闲相约', '夸克网盘', 'https://pan.quark.cn/s/0c54e42e0c91', 'c23a001ce98640099f20f6e1e405c101', 'deleted', '2026-05-21 03:25:30', '2026-05-20 21:25:30', '2026-05-20 21:25:30', '2026-05-21 21:44:00', '2026-05-21 21:44:00'),
(151, 'https://pan.quark.cn/s/1397a2b07151', '【标题】：庆余年第一季 特别版 (2024) 4K/1080P 国语中字 25集完结【描述】：“该剧改编自猫腻同名畅销电子书，承接上季，范闲（张若昀 饰）率领使团回归途中，二皇子以费介、范思辙以及滕家遗孤的安危来威胁范闲，逼他向自己俯首称臣，二人的矛盾就此激发。范闲所面对的抱月楼迷局，以及接踵而至的春闱危机，都是二皇子精心给范闲布下的陷阱。范闲与林婉儿如愿大婚，紧接着，范闲接手内库，却发现内库负债累累。 范闲拒绝了庆余堂大掌柜的相助，决定靠自己的力量解决内库危机，范闲相约城中众商贾相聚苍山，以售卖“库债”', '夸克网盘', 'https://pan.quark.cn/s/66328814f30d', '00e9c129f0224cada76790af7e34d85f', 'deleted', '2026-05-21 03:25:31', '2026-05-20 21:25:31', '2026-05-20 21:25:31', '2026-05-21 21:44:00', '2026-05-21 21:44:00'),
(152, 'https://pan.quark.cn/s/d9b907a7734e', '庆余年 2部 完结 +特别版 ​​​', '夸克网盘', 'https://pan.quark.cn/s/260551e3f850', '8a0050e2c1ef44429e4e9926269dc99c', 'deleted', '2026-05-21 03:25:32', '2026-05-20 21:25:32', '2026-05-20 21:25:32', '2026-05-21 21:44:01', '2026-05-21 21:44:01'),
(153, 'https://pan.quark.cn/s/d7ecfb878266', '【标题】：庆余年2 (2024) 4K 纯净版 超前点映 36集完结 高码杜比+迪士尼版 猫腻电子书改编剧【描述】：“该剧改编自猫腻同名畅销电子书，承接上季，范闲（张若昀 饰）率领使团回归途中，二皇子以费介、范思辙以及滕家遗孤的安危来威胁范闲，逼他向自己俯首称臣，二人的矛盾就此激发。范闲所面对的抱月楼迷局，以及接踵而至的春闱危机，都是二皇子精心给范闲布下的陷阱。范闲与林婉儿如愿大婚，紧接着，范闲接手内库，却发现内库负债累累。 范闲拒绝了庆余堂大掌柜的相助，决定靠自己的力量解决内库危机，范闲相约城中众商贾相', '夸克网盘', 'https://pan.quark.cn/s/3a5394d8bb3d', 'd947c8c0d42643e8a27e54e2096f05d5', 'deleted', '2026-05-21 03:25:33', '2026-05-20 21:25:33', '2026-05-20 21:25:33', '2026-05-21 21:44:02', '2026-05-21 21:44:02'),
(154, 'https://pan.quark.cn/s/2ec8abe65383', '《庆余年 (2019) 4K 高码》权谋智斗与江湖热血交织，范闲的逆袭之路震撼人心，4K高码画质尽享视觉盛宴。#权谋江湖 #庆余年 #4K高码2025-07-22 17:08:45', '夸克网盘', 'https://pan.quark.cn/s/3f50e2a478f1', 'b47b3cb542694b82bd71abe3e4cdab81', 'deleted', '2026-05-21 03:25:34', '2026-05-20 21:25:34', '2026-05-20 21:25:34', '2026-05-21 21:44:02', '2026-05-21 21:44:02'),
(155, 'https://pan.quark.cn/s/e4de306efa22', '【标题】：庆余年 第二季 (2024) 4K1080P 国语中字 超前点映 36集完结 张若昀 李沁 陈道明【描述】：“该剧改编自猫腻同名畅销电子书，承接上季，范闲（张若昀 饰）率领使团回归途中，二皇子以费介、范思辙以及滕家遗孤的安危来威胁范闲，逼他向自己俯首称臣，二人的矛盾就此激发。范闲所面对的抱月楼迷局，以及接踵而至的春闱危机，都是二皇子精心给范闲布下的陷阱。范闲与林婉儿如愿大婚，紧接着，范闲接手内库，却发现内库负债累累。 范闲拒绝了庆余堂大掌柜的相助，决定靠自己的力量解决内库危机，范闲相约城中众商贾', '夸克网盘', 'https://pan.quark.cn/s/07939ffdadd5', '6300872f56674c739f7261930aa2f76d', 'deleted', '2026-05-21 03:25:34', '2026-05-20 21:25:34', '2026-05-20 21:25:34', '2026-05-21 22:13:58', '2026-05-21 22:13:58'),
(156, 'https://pan.quark.cn/s/667294e4c485', '《庆余年(2019)》权谋与热血交织，范闲的逆袭之路充满智慧与勇气，剧情紧凑扣人心弦。#权谋 #庆余年 #腾讯视频2025-07-14 00:20:35', '夸克网盘', 'https://pan.quark.cn/s/9e5a95bfed3c', '67979668d7ae4235b8bdf146cfba886e', 'deleted', '2026-05-21 03:25:34', '2026-05-20 21:25:34', '2026-05-20 21:25:34', '2026-05-21 22:13:58', '2026-05-21 22:13:58'),
(157, 'https://pan.quark.cn/s/f25eb63d2a72', '《庆余年第2季》范闲归来，智斗权谋再升级！新老角色碰撞火花，剧情反转不断，带来更震撼的视觉盛宴与深度思考。#权谋 #庆余年第二季 #腾讯视频2025-09-18 16:29:32', '夸克网盘', 'https://pan.quark.cn/s/56301635640d', 'f7420b09732143f1931b7a2088885008', 'deleted', '2026-05-21 03:25:36', '2026-05-20 21:25:36', '2026-05-20 21:25:36', '2026-05-21 22:13:59', '2026-05-21 22:13:59'),
(158, 'https://pan.quark.cn/s/ad5446a8e948', '《庆余年 第一季 特别版》剧情更紧凑，新剪辑带来全新观感，未曝光片段首次公开，深度挖掘角色内心世界。#权谋江湖 #庆余年 #特别剪辑版 #腾讯视频独播2025-09-19 01:52:19', '夸克网盘', 'https://pan.quark.cn/s/687434b42a57', 'f1caa23bbc3e4deb90e02492db40cafc', 'deleted', '2026-05-21 03:25:36', '2026-05-20 21:25:36', '2026-05-20 21:25:36', '2026-05-21 22:13:59', '2026-05-21 22:13:59'),
(159, 'https://pan.quark.cn/s/5ed455e2f5b9', '【短剧】庆余年之少年风流（75集）', '夸克网盘', 'https://pan.quark.cn/s/c1501652e250', 'a6d46c631c4a4ab8acc09e6ff7ce9423', 'deleted', '2026-05-21 03:25:36', '2026-05-20 21:25:36', '2026-05-20 21:25:36', '2026-05-21 22:14:00', '2026-05-21 22:14:00'),
(160, 'https://pan.quark.cn/s/fba3babe592c', '【短剧】庆余年之帝王业（52集）舒童 李子峰', '夸克网盘', 'https://pan.quark.cn/s/704a79cdf23f', 'ad245b5409434e65b21b1ab233f7445a', 'deleted', '2026-05-21 03:25:37', '2026-05-20 21:25:37', '2026-05-20 21:25:37', '2026-05-21 22:14:00', '2026-05-21 22:14:00'),
(161, 'https://pan.quark.cn/s/12f2fb13f45a', '【有声书】庆余年', '夸克网盘', 'https://pan.quark.cn/s/a8d92be3a669', '3a1b78c870364aa9980129f61064ac6b', 'deleted', '2026-05-21 03:25:37', '2026-05-20 21:25:37', '2026-05-20 21:25:37', '2026-05-21 22:14:01', '2026-05-21 22:14:01'),
(162, 'https://pan.quark.cn/s/3cdaa062a5f2', '【短剧】庆余年之帝王业（52集）舒童&李子峰', '夸克网盘', 'https://pan.quark.cn/s/aca0e4a538a2', '7d3132a843494063a84d7a53ad60abf7', 'deleted', '2026-05-21 03:25:39', '2026-05-20 21:25:39', '2026-05-20 21:25:39', '2026-05-21 22:14:01', '2026-05-21 22:14:01'),
(163, 'https://pan.quark.cn/s/bd1bdda2fd9a', '【短剧】庆余年之风起沧州（74集）范琪&尚雨茜&侍宣如|', '夸克网盘', 'https://pan.quark.cn/s/ba90d07e09aa', 'ebd7a1cfe57d469a9959cc5025594710', 'deleted', '2026-05-21 03:25:39', '2026-05-20 21:25:39', '2026-05-20 21:25:39', '2026-05-21 22:14:02', '2026-05-21 22:14:02'),
(164, 'https://pan.quark.cn/s/7ddeed28d2e3', '【短剧】庆余年之风起沧州（74集）范琪 尚雨茜 侍宣如|', '夸克网盘', 'https://pan.quark.cn/s/5978364b84b2', '998b9e2bf48c48c08f43ef58e1c7d947', 'deleted', '2026-05-21 03:25:40', '2026-05-20 21:25:40', '2026-05-20 21:25:40', '2026-05-21 22:43:58', '2026-05-21 22:43:58'),
(165, 'https://pan.quark.cn/s/122cf9d2895f', '【电影】庆余年 第一季 特别版（2024）|电视剧|', '夸克网盘', 'https://pan.quark.cn/s/3aa548e4718d', '91376014d6b547169e3501f3a1b4f08f', 'deleted', '2026-05-21 03:25:41', '2026-05-20 21:25:41', '2026-05-20 21:25:41', '2026-05-21 22:43:58', '2026-05-21 22:43:58'),
(166, 'https://pan.quark.cn/s/469ae42eb04e', '醉唐烟云丨重生穿越古风丨唐朝版庆余年丨多人有声剧', '夸克网盘', 'https://pan.quark.cn/s/15331f2e61c9', '6c3a8c6e5bf747ec88dea83edc483429', 'deleted', '2026-05-21 03:25:41', '2026-05-20 21:25:41', '2026-05-20 21:25:41', '2026-05-21 22:43:59', '2026-05-21 22:43:59'),
(167, 'https://pan.quark.cn/s/b27c20e35dc6', '《庆余年之帝王业（2024）52集合1集》', '夸克网盘', 'https://pan.quark.cn/s/cc72db25e8fa', '22a01cdb9b7c48e68e5435c2d3991ecb', 'deleted', '2026-05-21 03:25:42', '2026-05-20 21:25:42', '2026-05-20 21:25:42', '2026-05-21 22:43:59', '2026-05-21 22:43:59'),
(168, 'https://pan.quark.cn/s/8157d6e9448b', '【短剧】庆余年之大赵逍遥王（88集）', '夸克网盘', 'https://pan.quark.cn/s/235f0a56c61a', '179eac3e63974153830866f657d0c5d9', 'deleted', '2026-05-21 03:25:43', '2026-05-20 21:25:43', '2026-05-20 21:25:43', '2026-05-21 22:44:00', '2026-05-21 22:44:00'),
(169, 'https://pan.quark.cn/s/3e0f0cfd9db1', '《庆余年 第二季(2024)》', '夸克网盘', 'https://pan.quark.cn/s/b11c5249cd3c', '7ae8b8efbcfa4793acf27011c5111062', 'deleted', '2026-05-21 03:25:43', '2026-05-20 21:25:43', '2026-05-20 21:25:43', '2026-05-21 22:44:00', '2026-05-21 22:44:00'),
(170, 'https://pan.quark.cn/s/e4843b314c40', '名称：《庆余生（32集）罗豪宇&陈墁柯》亮点：罗豪宇与陈墁柯的精彩对手戏，剧情紧凑扣人心弦，情感交织引人深思️标签：#庆余年 #庆余生 #罗豪宇 #陈墁柯 #腾讯视频 更新日期：2025-05-11 07:06:11', '夸克网盘', 'https://pan.quark.cn/s/73d07b9753c4', 'f69cff53c22e4934803fd06391b2cba4', 'deleted', '2026-05-21 03:25:43', '2026-05-20 21:25:43', '2026-05-20 21:25:43', '2026-05-21 22:44:01', '2026-05-21 22:44:01');
INSERT INTO `temp_share` (`id`, `original_url`, `title`, `cloud_name`, `temp_share_url`, `file_id`, `status`, `expires_at`, `last_accessed_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(171, 'https://drive.uc.cn/s/43b82dd972a64?public=1', '庆余年 第一季 全45集 4K+1080P', 'UC网盘', 'https://drive.uc.cn/s/0ccb6a47f44c4', '[\"46ea0a461b57417083bdc551ff4a40f2\"]', 'deleted', '2026-05-21 03:25:44', '2026-05-20 21:25:44', '2026-05-20 21:25:44', '2026-05-21 22:44:01', '2026-05-21 22:44:01'),
(172, 'https://drive.uc.cn/s/b37622addbf04?public=1', '庆余年 第一季 特别版 全25集 4K', 'UC网盘', 'https://drive.uc.cn/s/95d3a4e772a74', '[\"037df06c1edf42e79adaa437f9d04e9b\"]', 'deleted', '2026-05-21 03:25:44', '2026-05-20 21:25:44', '2026-05-20 21:25:44', '2026-05-21 22:44:02', '2026-05-21 22:44:02'),
(173, 'https://pan.baidu.com/s/10jy_e_qZ17wddBhmVnHtjA?pwd=8888', '庆余年 第二季', '百度网盘', 'https://pan.baidu.com/s/1YLI-qaZ6e34Hh1tFnUHBYw?pwd=6666', '555081126678831', 'active', '2026-05-21 03:25:47', '2026-05-20 21:25:47', '2026-05-20 21:25:47', '2026-05-20 21:25:47', NULL),
(174, 'https://pan.baidu.com/s/1WTXgg4VZrGM6PfSGC3Xhdw?pwd=8888', '庆余年 第一季', '百度网盘', 'https://pan.baidu.com/s/1PVuTczjYSYX9mVPyZIJmbA?pwd=6666', '1116234621457673', 'active', '2026-05-21 03:25:47', '2026-05-20 21:25:47', '2026-05-20 21:25:47', '2026-05-20 21:25:47', NULL),
(175, 'https://pan.baidu.com/s/1rKNqWA9en-L4DesJksXMMQ?pwd=6666', '【国剧】庆余年 全2季 国语中字 2019- 2024 4K', '百度网盘', 'https://pan.baidu.com/s/1eKnwvHlVJdMAMkuualRogQ?pwd=6666', '323594535987713', 'active', '2026-05-21 03:25:51', '2026-05-20 21:25:51', '2026-05-20 21:25:51', '2026-05-20 21:25:51', NULL),
(176, 'https://pan.baidu.com/s/1BlThQEC95qXWQt4-GLfdww?pwd=2wct', '庆余年 (两季全)✨【4K】【杜比音效】', '百度网盘', 'https://pan.baidu.com/s/115g1BdaVIEjppUi8FAi7Yg?pwd=6666', '410887745844350', 'active', '2026-05-21 03:25:52', '2026-05-20 21:25:52', '2026-05-20 21:25:52', '2026-05-20 21:25:52', NULL),
(177, 'https://pan.baidu.com/s/1dpEA5IrShgh0UkYCPYm5GQ?pwd=2025', '庆余年1-2季+周年特别版【合集】4K', '百度网盘', 'https://pan.baidu.com/s/1jBeFhU3tdZpS6zeU8FX0Hw?pwd=6666', '554448885723935', 'active', '2026-05-21 03:25:52', '2026-05-20 21:25:52', '2026-05-20 21:25:52', '2026-05-20 21:25:52', NULL),
(178, 'https://pan.baidu.com/s/13HPE9AmmT1E2XsQSZTaW8Q?pwd=8888', '奔跑吧第十季', '百度网盘', 'https://pan.baidu.com/s/1r4-owwlri1cpb691JTjtWw?pwd=6666', '669707098930158', 'active', '2026-05-21 03:27:22', '2026-05-20 21:27:24', '2026-05-20 21:27:22', '2026-05-20 21:27:24', NULL),
(179, 'https://pan.baidu.com/s/12oAU1_bDrT7OhF2l4-KvJg?pwd=6666', '#综艺🗄 奔跑吧 第十季 (2026)4K60FPS MAX+ 更新0516期📜', '百度网盘', 'https://pan.baidu.com/s/1Nd7r69hpzCw4sIkeNunqvQ?pwd=6666', '429829503179450', 'active', '2026-05-21 03:27:22', '2026-05-20 21:27:29', '2026-05-20 21:27:22', '2026-05-20 21:27:29', NULL),
(180, 'https://pan.baidu.com/s/10y57t0lfvtM2zFSaeXfj1A?pwd=8dqc', '综艺：奔跑吧 第九季 (2025) 5月30期 第6期', '百度网盘', 'https://pan.baidu.com/s/1uxSfL8wG_EVHflbZgisc4Q?pwd=6666', '335688494208651', 'active', '2026-05-21 03:27:23', '2026-05-20 21:27:33', '2026-05-20 21:27:23', '2026-05-20 21:27:33', NULL),
(181, 'https://pan.baidu.com/s/16y9N7gy6PKbVB4U5kd1piA?pwd=uz92', '奔跑吧·天路篇', '百度网盘', 'https://pan.baidu.com/s/1KvNRySSFXxyfb4Tp8SwWsA?pwd=6666', '927146200641220', 'active', '2026-05-21 03:27:23', '2026-05-20 21:27:24', '2026-05-20 21:27:23', '2026-05-20 21:27:24', NULL),
(182, 'https://pan.baidu.com/s/1kCaW5X9mp7xdV626exT1GQ?pwd=nniv', '奔跑吧·茶马古道篇 (2024) 4K 臻彩 杜比音效 更0111期', '百度网盘', 'https://pan.baidu.com/s/1xw5MENGspNIk3OO7RhYjWw?pwd=6666', '912005049800573', 'active', '2026-05-21 03:27:24', '2026-05-20 21:27:24', '2026-05-20 21:27:24', '2026-05-20 21:27:24', NULL),
(183, 'https://pan.baidu.com/s/1NGmFisQXsraOCdQOnSpU1Q?pwd=gnvg', '短剧：奔跑吧英子（70集）', '百度网盘', 'https://pan.baidu.com/s/12FwsOrmvlEnZNgq7Lt5PXA?pwd=6666', '928540370969999', 'active', '2026-05-21 03:27:27', '2026-05-20 21:27:38', '2026-05-20 21:27:27', '2026-05-20 21:27:38', NULL),
(184, 'https://pan.baidu.com/s/1TWi5TTLhqaz5sfoY2aZ0Hg?pwd=8888', '奔跑吧·茶马古道篇（2024）4K 臻彩 杜比音效 更1123期', '百度网盘', 'https://pan.baidu.com/s/19UQXoCkiT5D-XuFlwghKug?pwd=6666', '912005049800573', 'active', '2026-05-21 03:27:27', '2026-05-20 21:27:27', '2026-05-20 21:27:27', '2026-05-20 21:27:27', NULL),
(185, 'https://pan.baidu.com/s/1hN6ubqTjNcmchVGZV_esEA?pwd=vb3y', '奔跑吧·茶马古道篇（2024）4K 臻彩 杜比音效 更1214期', '百度网盘', 'https://pan.baidu.com/s/1jqHKisWixtsWDP6sez7ITg?pwd=6666', '912005049800573', 'active', '2026-05-21 03:27:28', '2026-05-20 21:27:28', '2026-05-20 21:27:28', '2026-05-20 21:27:28', NULL),
(186, 'https://pan.baidu.com/s/1q2N4xrkFroAV-YorKkm0OA?pwd=b9u5', '奔跑吧 第十季 更新至20260424期 4K SDR 60帧 高码率', '百度网盘', 'https://pan.baidu.com/s/1LvH5M86J_0bMCLfReXzMCw?pwd=6666', '955017909172276', 'active', '2026-05-21 03:27:28', '2026-05-20 21:27:28', '2026-05-20 21:27:28', '2026-05-20 21:27:28', NULL),
(187, 'https://pan.baidu.com/s/1gwUkj6MOcMLQK3lJo7ALoQ?pwd=7yr5', '奔跑吧 第十季 /奔跑吧兄弟 (2026) 郑恺 沙溢 白鹿 范丞丞 真人秀 0518期', '百度网盘', 'https://pan.baidu.com/s/1JL5QxQOqmDqpRskZq6rqEA?pwd=6666', '157044516529436', 'active', '2026-05-21 03:27:29', '2026-05-20 21:27:29', '2026-05-20 21:27:29', '2026-05-20 21:27:29', NULL),
(188, 'https://pan.baidu.com/s/1cXaN8n_vRFGjBiLyd9HC2A?pwd=66M6', '全力奔跑 (2025)', '百度网盘', 'https://pan.baidu.com/s/1HGlCug7WcCraP5glRnbH7w?pwd=6666', '457424986437776', 'active', '2026-05-21 03:27:29', '2026-05-20 21:27:29', '2026-05-20 21:27:29', '2026-05-20 21:27:29', NULL),
(189, 'https://pan.baidu.com/s/1ez6zGIAOyEuQLhUW38_3ag?pwd=gfk4', '奔跑吧！兄弟 (2014) 奔跑吧 第九季 4K 臻彩 杜比音效 更0509期', '百度网盘', 'https://pan.baidu.com/s/1P84bJLWUXn2fjmVbvdKnLQ?pwd=6666', '1036265468835501', 'active', '2026-05-21 03:27:29', '2026-05-20 21:27:29', '2026-05-20 21:27:29', '2026-05-20 21:27:29', NULL),
(190, 'https://pan.baidu.com/s/1QJSocvOAtzEex4i-rkyVzw?pwd=0425', '奔跑吧 第十季 (2026) 更至5.18期 [综艺/游戏][奔跑吧兄弟]', '百度网盘', 'https://pan.baidu.com/s/1A49I5Zj792yZOnr5kFcb6Q?pwd=6666', '1088647100239151', 'active', '2026-05-21 03:27:31', '2026-05-20 21:27:31', '2026-05-20 21:27:31', '2026-05-20 21:27:31', NULL),
(191, 'https://pan.baidu.com/s/1aZP9fJgLoeH6Uv1XsUY7Zw?pwd=wogg', '奔跑吧 第10季 开播 综艺 更新0424', '百度网盘', 'https://pan.baidu.com/s/1JsOoQRIfA-DcG-w6_5Zglw?pwd=6666', '669707098930158', 'active', '2026-05-21 03:27:33', '2026-05-20 21:27:33', '2026-05-20 21:27:33', '2026-05-20 21:27:33', NULL),
(192, 'https://pan.baidu.com/s/17tjQG0ceCAUXucdUTXqdmA?pwd=j6fd', '《如果奔跑是我的宿命》', '百度网盘', 'https://pan.baidu.com/s/11TioP0AJOu8juJLL4biT0g?pwd=6666', '879154280191813', 'active', '2026-05-21 03:27:33', '2026-05-20 21:27:33', '2026-05-20 21:27:33', '2026-05-20 21:27:33', NULL),
(193, 'https://pan.baidu.com/s/1dXvg--S0cN0pvBQ8hn544A?pwd=1234', '【综艺】奔跑吧 第10季（2026）更最新期百度：', '百度网盘', 'https://pan.baidu.com/s/1X7zpw9WCme7H-M4sBLjr8A?pwd=6666', '477958790177842', 'active', '2026-05-21 03:27:34', '2026-05-20 21:27:34', '2026-05-20 21:27:34', '2026-05-20 21:27:34', NULL),
(194, 'https://pan.baidu.com/s/1aa48Aplg_soclsvuf1kGBg?pwd=c592', '奔跑吧兄弟 奔跑吧！兄弟 1-2季 4K WEB-DL H264 AAC', '百度网盘', 'https://pan.baidu.com/s/10G2Y5wWmaUEuk08l8pPtGA?pwd=6666', '185052639624420', 'active', '2026-05-21 03:27:34', '2026-05-20 21:27:34', '2026-05-20 21:27:34', '2026-05-20 21:27:34', NULL),
(195, 'https://pan.baidu.com/s/1WsmrXwvMXtwCsrscPGmAbA?pwd=dmgf', '《在地下奔跑》', '百度网盘', 'https://pan.baidu.com/s/1RQ-XXbJtlungWmlnI4jQEw?pwd=6666', '152199337534833', 'active', '2026-05-21 03:27:37', '2026-05-20 21:27:37', '2026-05-20 21:27:37', '2026-05-20 21:27:37', NULL),
(196, 'https://pan.baidu.com/s/1D0wx8Gh6n7gbgYYejTraAA?pwd=1c16', '综艺：《奔跑吧·天路篇》2025 1080p 国语中字', '百度网盘', 'https://pan.baidu.com/s/1yc3rYASu41UJ1kj66ntG2g?pwd=6666', '821977534342045', 'active', '2026-05-21 03:27:39', '2026-05-20 21:27:39', '2026-05-20 21:27:39', '2026-05-20 21:27:39', NULL),
(197, 'https://pan.baidu.com/s/1Bgpq4NXmU5AtsbgOd4G4wQ?pwd=8888', '【短剧】奔跑吧原始人＆疯狂的原始人（56集）张子烨＆秦玺', '百度网盘', 'https://pan.baidu.com/s/1UAmN93Z0MmqM6UrS11Oyqw?pwd=6666', '1052682305312780', 'active', '2026-05-21 03:27:39', '2026-05-20 21:27:39', '2026-05-20 21:27:39', '2026-05-20 21:27:39', NULL),
(198, 'https://pan.baidu.com/s/1MMCJu-IhXMHqZgqOc7Zu7g?pwd=egjh', '短剧：奔跑在山海之间的浪漫（65集）', '百度网盘', 'https://pan.baidu.com/s/1DgIQ2Z6WTj9Ik6WWgLHHtg?pwd=6666', '345403301495417', 'active', '2026-05-21 03:27:42', '2026-05-20 21:27:42', '2026-05-20 21:27:42', '2026-05-20 21:27:42', NULL),
(199, 'https://pan.baidu.com/s/1AHePygShLFS70JjNDJsQmQ?pwd=8888', '【短剧】奔跑在山海之间的浪漫（65集）', '百度网盘', 'https://pan.baidu.com/s/1y9-wmtiC7YnrI7HgChHdiQ?pwd=6666', '584273026338074', 'active', '2026-05-21 03:27:42', '2026-05-20 21:27:42', '2026-05-20 21:27:42', '2026-05-20 21:27:42', NULL),
(200, 'https://pan.quark.cn/s/c5a506a7e42c', '国家宝藏：历史边缘 National Treasure: Edge of History (2022)', '夸克网盘', 'https://pan.quark.cn/s/b99317c509fd', '1d3ccd6fa6174b6c9583220ca37b992e', 'active', '2026-05-21 16:40:48', '2026-05-21 10:40:48', '2026-05-21 10:40:48', '2026-05-21 10:40:48', NULL),
(201, 'https://pan.quark.cn/s/c5a506a7e42c', '国家宝藏：历史边缘 National Treasure: Edge of History (2022)', '夸克网盘', 'https://pan.quark.cn/s/1f7783a57e09', 'b797b290dc0a472b871a9d940b8c48b9', 'active', '2026-05-21 16:40:48', '2026-05-21 10:40:48', '2026-05-21 10:40:48', '2026-05-21 10:40:48', NULL),
(202, 'https://pan.baidu.com/s/1IqmzGJIkEpRzjR0AWSDJNw?pwd=runs', '怦然心动20岁：冬季', '百度网盘', 'https://pan.baidu.com/s/107-DID8cQrw94BInm6Cl5A?pwd=6666', '62610671183537', 'active', '2026-05-22 01:17:03', '2026-05-21 19:17:03', '2026-05-21 19:17:03', '2026-05-21 19:17:03', NULL),
(203, 'https://pan.quark.cn/s/0bb1d65cf4de', '有史以来最棒的啤酒运送 The Greatest Beer Run Ever (2022)', '夸克网盘', 'https://pan.quark.cn/s/960275599e0a', 'ff218561f114499392c42ca5792cf684', 'active', '2026-05-24 19:16:27', '2026-05-24 13:38:27', '2026-05-24 13:16:27', '2026-05-24 13:38:27', NULL),
(204, 'https://pan.quark.cn/s/8ad695dd494c', '马戏之王 The Greatest Showman (2017)', '夸克网盘', 'https://pan.quark.cn/s/708098140c99', '6a782a9c573b441684266a1d6696f113', 'active', '2026-05-24 19:16:27', '2026-05-24 13:38:27', '2026-05-24 13:16:27', '2026-05-24 13:38:27', NULL),
(205, 'https://pan.quark.cn/s/0e03506aaa96', '📚名称：【极客时间-test】测试开发进阶训练营', '夸克网盘', 'https://pan.quark.cn/s/5a2fd1db449a', '5604ef0201ab466cb2d3e1ea0df70270', 'active', '2026-05-24 19:16:27', '2026-05-24 13:16:27', '2026-05-24 13:16:27', '2026-05-24 13:16:27', NULL),
(206, 'https://pan.quark.cn/s/c2b883ebdc0c', '革命往事 Giù la testa (1971)', '夸克网盘', 'https://pan.quark.cn/s/9eca2a51b2b3', '4771d56ad63643e1b23cf2017af0ee82', 'active', '2026-05-24 19:16:27', '2026-05-24 13:38:27', '2026-05-24 13:16:27', '2026-05-24 13:38:27', NULL),
(207, 'https://pan.quark.cn/s/bc9f2545299e', '最强壮的 The Fittest (2020)', '夸克网盘', 'https://pan.quark.cn/s/67a6d203b04a', '8649f30a7ca14c769b5264c2562705eb', 'active', '2026-05-24 19:16:28', '2026-05-24 13:38:27', '2026-05-24 13:16:28', '2026-05-24 13:38:27', NULL),
(208, 'https://pan.quark.cn/s/a9f28defddb5', '《谋杀干预组3》(2025)[1080P][中文字幕][动作/惊悚/犯罪][纳尼/卡尔迪/阿迪维·赛什]', '夸克网盘', 'https://pan.quark.cn/s/39223582d396', '87935cc02a494ef0b853c9f5eaaf9e14', 'active', '2026-05-24 19:38:30', '2026-05-24 13:38:30', '2026-05-24 13:38:30', '2026-05-24 13:38:30', NULL),
(209, 'https://pan.quark.cn/s/c28764dd234c', '空中乱流 Turbulence (2025)', '夸克网盘', 'https://pan.quark.cn/s/26af96b0e164', '1c59b928d3e44044a8be7c5c081f530d', 'active', '2026-05-24 19:38:30', '2026-05-24 13:38:30', '2026-05-24 13:38:30', '2026-05-24 13:38:30', NULL),
(210, 'https://pan.quark.cn/s/5145a072f6d0', '双盲试验 Double Blind (2023)', '夸克网盘', 'https://pan.quark.cn/s/99a19203f62e', '51105a9d62ad4cfa89523e2ba81f5ac5', 'active', '2026-05-24 19:38:30', '2026-05-24 13:38:30', '2026-05-24 13:38:30', '2026-05-24 13:38:30', NULL),
(211, 'https://pan.baidu.com/s/1kKrWi9-WChvax9MRbS-i6Q?pwd=qpof', '《谋杀干预组3》(2025)[1080P][中文字幕][动作/惊悚/犯罪][纳尼/卡尔迪/阿迪维·赛什]', '百度网盘', 'https://pan.baidu.com/s/1x5f3vKclB8oAB2QBXSfsqA?pwd=6666', '211739514459023', 'active', '2026-05-24 19:38:32', '2026-05-24 13:38:32', '2026-05-24 13:38:32', '2026-05-24 13:38:32', NULL),
(212, 'https://pan.quark.cn/s/44f94c0bf05c', 'N哪吒之魔童闹海幕后纪录片《不破不立》2025', '夸克网盘', 'https://pan.quark.cn/s/dee80725acfb', 'e5ba026b5d2b423583d1f0699de12e64', 'active', '2026-05-29 00:41:13', '2026-05-28 18:41:13', '2026-05-28 18:41:13', '2026-05-28 18:41:13', NULL),
(213, 'https://pan.quark.cn/s/794ccb2378df', '长夜将尽（1080P&4K）（官方正式版)', '夸克网盘', 'https://pan.quark.cn/s/cb1e330cb792', '27e531b5393c470695401f0de8183ee9', 'active', '2026-05-29 00:41:13', '2026-05-28 18:41:13', '2026-05-28 18:41:13', '2026-05-28 18:41:13', NULL),
(214, 'https://pan.baidu.com/s/1ElERkI48kos6CROaDJmg0A?pwd=6666', '【推荐电影】哪吒之魔童闹海（2025）（1080P.极高码）官方正式版', '百度网盘', 'https://pan.baidu.com/s/10kIEwiE-7qFB678zlzAFqQ?pwd=6666', '277202835380354', 'active', '2026-05-29 00:41:15', '2026-05-28 18:41:15', '2026-05-28 18:41:15', '2026-05-28 18:41:15', NULL),
(215, 'https://pan.baidu.com/s/1UNQu6kcK1_1PdX2Z-fk2Mg?pwd=xxnb', '📺《 哪吒之魔童闹海 Ne Zha 2》（2025）4K (HQ )60帧/HDR10+ 120帧 /DV杜比视界 流媒体版 DTS环绕声/杜比全景声 国语简中', '百度网盘', 'https://pan.baidu.com/s/1353lOULjMlcdLlaxPPU8cA?pwd=6666', '551183255642905', 'active', '2026-05-29 00:41:16', '2026-05-28 18:41:16', '2026-05-28 18:41:16', '2026-05-28 18:41:16', NULL),
(216, 'https://pan.quark.cn/s/da1be65f8a2b', '乘风破浪的婚姻(90集)', '夸克网盘', 'https://pan.quark.cn/s/0e6f9041dca8', '3fbd3edd82fd4419b22f59cdea997330', 'active', '2026-05-29 00:41:16', '2026-05-28 18:41:16', '2026-05-28 18:41:16', '2026-05-28 18:41:16', NULL),
(217, 'https://pan.baidu.com/s/1GPm3rF8auBRoNvrlswxWXA?pwd=8888', '罗小黑战记2', '百度网盘', 'https://pan.baidu.com/s/1flt1FAqw0IjbM16OMb5MyA?pwd=6666', '843183412562232', 'active', '2026-05-29 00:41:17', '2026-05-28 18:41:17', '2026-05-28 18:41:17', '2026-05-28 18:41:17', NULL),
(218, 'https://pan.baidu.com/s/1iDfJT_9zKjZb5PbHJJeWBQ?pwd=yhws', '头像：哪吒之魔童闹海系列头像', '百度网盘', 'https://pan.baidu.com/s/1kUeXd0Q-RVrcllUadne9xQ?pwd=6666', '805125177119563', 'active', '2026-05-29 00:41:17', '2026-05-28 18:41:17', '2026-05-28 18:41:17', '2026-05-28 18:41:17', NULL),
(219, 'https://pan.quark.cn/s/e350d3f0272d', '修仙归来(90集)', '夸克网盘', 'https://pan.quark.cn/s/a11b30a84974', '9cd84e31bc6a46deac7bf4b1c1e3a73d', 'active', '2026-05-29 00:41:19', '2026-05-28 18:41:19', '2026-05-28 18:41:19', '2026-05-28 18:41:19', NULL),
(220, 'https://pan.quark.cn/s/0da7650ba892', '凡人修仙记（80集）', '夸克网盘', 'https://pan.quark.cn/s/ae14c38c4941', 'c13b7341ee6f47f4b64beedde6c824ea', 'active', '2026-05-29 00:41:19', '2026-05-28 18:41:19', '2026-05-28 18:41:19', '2026-05-28 18:41:19', NULL),
(221, 'https://pan.quark.cn/s/8c6acb296706', '都市修仙传（87集）', '夸克网盘', 'https://pan.quark.cn/s/e954ccad267b', '0d9574fdfd7b4555991a2bea6e1591f0', 'active', '2026-05-29 00:41:19', '2026-05-28 18:41:19', '2026-05-28 18:41:19', '2026-05-28 18:41:19', NULL),
(222, 'https://pan.quark.cn/s/e27f1a319d47', '你们练武我修仙（92集）', '夸克网盘', 'https://pan.quark.cn/s/0ed644777936', 'd5b519103f2d48a5b05b1c1aacc712fc', 'active', '2026-05-29 00:41:20', '2026-05-28 18:41:20', '2026-05-28 18:41:20', '2026-05-28 18:41:20', NULL),
(223, 'https://pan.quark.cn/s/053ddfc21a49', '重生之都市修仙（82集）', '夸克网盘', 'https://pan.quark.cn/s/ec602a1f97b9', '07518c252ee241668bfbb14efac08993', 'active', '2026-05-29 00:41:20', '2026-05-28 18:41:20', '2026-05-28 18:41:20', '2026-05-28 18:41:20', NULL),
(224, 'https://pan.quark.cn/s/9968c093b557', '修仙逆袭记（79集）', '夸克网盘', 'https://pan.quark.cn/s/8cd252066fff', '45de68db961d41b5ade98ad643a378fa', 'active', '2026-05-29 00:41:22', '2026-05-28 18:41:22', '2026-05-28 18:41:22', '2026-05-28 18:41:22', NULL),
(225, 'https://pan.quark.cn/s/fc391213b767', '都市之修仙归来（97集）', '夸克网盘', 'https://pan.quark.cn/s/3db832e0af8c', '2d060b24d264475f914c35cb8f895b44', 'active', '2026-05-29 00:41:22', '2026-05-28 18:41:22', '2026-05-28 18:41:22', '2026-05-28 18:41:22', NULL),
(226, 'https://pan.quark.cn/s/1dda45707b83', '修仙从离婚开始（97集）', '夸克网盘', 'https://pan.quark.cn/s/00b5e2895746', '958060c8c3114bb097d07882f8423d2e', 'active', '2026-05-29 00:41:22', '2026-05-28 18:41:22', '2026-05-28 18:41:22', '2026-05-28 18:41:22', NULL),
(227, 'https://pan.quark.cn/s/63870fbdc4c6', '修仙归来当奶爸（102集）', '夸克网盘', 'https://pan.quark.cn/s/589dd7272d07', 'c3f2ef996051470fa4f978a5e3a34922', 'active', '2026-05-29 00:41:23', '2026-05-28 18:41:23', '2026-05-28 18:41:23', '2026-05-28 18:41:23', NULL),
(228, 'https://pan.quark.cn/s/a675aa3f554e', '一人之下修仙归来&凡人修仙传仙帝归来 80集', '夸克网盘', 'https://pan.quark.cn/s/7ab918f8c554', '7ccbcad340954dea91181381a3ef11ae', 'active', '2026-05-29 00:41:23', '2026-05-28 18:41:23', '2026-05-28 18:41:23', '2026-05-28 18:41:23', NULL),
(229, 'https://pan.quark.cn/s/5e914f084148', '修仙狂飙从提出离婚开始（106集）', '夸克网盘', 'https://pan.quark.cn/s/2bc7155bbecb', 'd03cd1d1cc2d486b87001127395e15af', 'active', '2026-05-29 00:41:25', '2026-05-28 18:41:25', '2026-05-28 18:41:25', '2026-05-28 18:41:25', NULL),
(230, 'https://pan.quark.cn/s/91230eaf9d0a', '陛下臣真不会修仙（77集）', '夸克网盘', 'https://pan.quark.cn/s/f193b8a76d54', '79dbc8f9ee3942d0bed30da0f190ce27', 'active', '2026-05-29 00:41:25', '2026-05-28 18:41:25', '2026-05-28 18:41:25', '2026-05-28 18:41:25', NULL),
(231, 'https://pan.quark.cn/s/7bd46e9241ef', '下山后，绝世美女非要拜我为师（88集）修仙剧', '夸克网盘', 'https://pan.quark.cn/s/469aeddc2ca8', 'f237da39b93946bc9a4488f5e745a682', 'active', '2026-05-29 00:41:25', '2026-05-28 18:41:25', '2026-05-28 18:41:25', '2026-05-28 18:41:25', NULL),
(232, 'https://pan.quark.cn/s/6ed0fd34d7d6', '别动我的美女徒弟（88集）修仙剧', '夸克网盘', 'https://pan.quark.cn/s/e8c8e4d3e60e', '189ec8c14edd4e129970c63c73db99bb', 'active', '2026-05-29 00:41:26', '2026-05-28 18:41:26', '2026-05-28 18:41:26', '2026-05-28 18:41:26', NULL),
(233, 'https://pan.quark.cn/s/afd03eb63d91', '我真不是修仙大佬（95集）仙侠剧', '夸克网盘', 'https://pan.quark.cn/s/37822fdbc48a', 'b12f5548ead143ef9f88af223f1121ca', 'active', '2026-05-29 00:41:26', '2026-05-28 18:41:26', '2026-05-28 18:41:26', '2026-05-28 18:41:26', NULL),
(234, 'https://pan.quark.cn/s/f7acaa9475d7', '.修仙十年下山已无敌（80集）', '夸克网盘', 'https://pan.quark.cn/s/29b5cd42451b', '073c658f8ee547d69904724be328a63c', 'active', '2026-05-29 00:41:27', '2026-05-28 18:41:27', '2026-05-28 18:41:27', '2026-05-28 18:41:27', NULL),
(235, 'https://pan.quark.cn/s/b13104e4f0d0', '修仙十年下山即无敌（103集）', '夸克网盘', 'https://pan.quark.cn/s/92d721dfe7fb', '053c0ff0e25c4ee5becebcc872aadb38', 'active', '2026-05-29 00:41:28', '2026-05-28 18:41:28', '2026-05-28 18:41:28', '2026-05-28 18:41:28', NULL),
(236, 'https://pan.quark.cn/s/248edd908345', '我就是叶凡&玄幻：开局我能沟通上古神文修仙剧（79集）', '夸克网盘', 'https://pan.quark.cn/s/249f2d33af6a', '9c3ac0e975c84aa58a6b2a8eb65f61bd', 'active', '2026-05-29 00:41:28', '2026-05-28 18:41:28', '2026-05-28 18:41:28', '2026-05-28 18:41:28', NULL),
(237, 'https://pan.quark.cn/s/545a7133ca65', '痞子修仙记 93集', '夸克网盘', 'https://pan.quark.cn/s/2dc83adeaba0', '8636252d31ec4514af271c1aad5bebdd', 'active', '2026-05-29 00:41:30', '2026-05-28 18:41:30', '2026-05-28 18:41:30', '2026-05-28 18:41:30', NULL),
(238, 'https://pan.quark.cn/s/017a2298d3fc', '10.举国修仙，开局上交修仙界（77集）李可馨&丁晓&朱鹏2025', '夸克网盘', 'https://pan.quark.cn/s/4ad3aec83022', '41d1d584126e42ad8ae572e9f125c3b4', 'active', '2026-05-29 00:41:30', '2026-05-28 18:41:30', '2026-05-28 18:41:30', '2026-05-28 18:41:30', NULL),
(239, 'https://pan.quark.cn/s/ef3fab785100', '37.修仙十年，下山即无敌：仙缘劫起＆修仙十年下山即无敌仙缘劫起（71集）邱浩轩＆程攒攒2026', '夸克网盘', 'https://pan.quark.cn/s/0e2bcdac35dc', '6cb4439d37b243ac9e0dc77940ce2221', 'active', '2026-05-29 00:41:31', '2026-05-28 18:41:31', '2026-05-28 18:41:31', '2026-05-28 18:41:31', NULL),
(240, 'https://pan.quark.cn/s/883954097632', '39 - 让你修仙，没让你祸害修仙界啊（80集）2025', '夸克网盘', 'https://pan.quark.cn/s/b8aa3c3c28c4', 'cd5d647261284fa49a06a9553df335b3', 'active', '2026-05-29 00:41:31', '2026-05-28 18:41:31', '2026-05-28 18:41:31', '2026-05-28 18:41:31', NULL),
(241, 'https://pan.quark.cn/s/2fa78dc80c98', '52.修仙归来：前任跪求不放手&分手修仙后，前任追疯了（82集）王三北＆陈羽佳2026', '夸克网盘', 'https://pan.quark.cn/s/2229eab51c24', '2ebd74a5ee0e49a3823ffc1ecaf2bd7a', 'active', '2026-05-29 00:41:31', '2026-05-28 18:41:31', '2026-05-28 18:41:31', '2026-05-28 18:41:31', NULL),
(242, 'https://pan.quark.cn/s/c8b1782d9ffa', '5910-重生之都市修仙（82集）', '夸克网盘', 'https://pan.quark.cn/s/7113a3cbe3d6', '0ab636b921ff453b83338024411cc942', 'active', '2026-05-29 00:41:35', '2026-05-28 18:41:35', '2026-05-28 18:41:35', '2026-05-28 18:41:35', NULL),
(243, 'https://pan.quark.cn/s/a7fbfa6e8950', '1234-都市修仙传（87集）', '夸克网盘', 'https://pan.quark.cn/s/77d3cd488028', '35847ee5f6cd49c2a2decdd1fcbaceb5', 'active', '2026-05-29 00:41:35', '2026-05-28 18:41:35', '2026-05-28 18:41:35', '2026-05-28 18:41:35', NULL),
(244, 'https://pan.quark.cn/s/038b6821d452', '6342-一人之下修仙归来&凡人修仙传仙帝归来 80集', '夸克网盘', 'https://pan.quark.cn/s/b76fd0d29bb5', '7c464961daf34b80b2c686f195a45f25', 'active', '2026-05-29 00:41:35', '2026-05-28 18:41:35', '2026-05-28 18:41:35', '2026-05-28 18:41:35', NULL),
(245, 'https://pan.quark.cn/s/585abd660ffc', '4634-修仙归来(90集)', '夸克网盘', 'https://pan.quark.cn/s/e6c15f149f95', '6b197e5d730e48dc9caf05716b2b049c', 'active', '2026-05-29 00:41:36', '2026-05-28 18:41:36', '2026-05-28 18:41:36', '2026-05-28 18:41:36', NULL),
(246, 'https://pan.quark.cn/s/275d4853faef', '4870-你们练武我修仙（92集）', '夸克网盘', 'https://pan.quark.cn/s/093dda56926b', '7a32abe26a7a4a65be0b3cad4bfa8d1d', 'active', '2026-05-29 00:41:36', '2026-05-28 18:41:36', '2026-05-28 18:41:36', '2026-05-28 18:41:36', NULL),
(247, 'https://pan.quark.cn/s/f1e792732d35', '9151-鸿蒙大帝（80集）浩子 修仙剧', '夸克网盘', 'https://pan.quark.cn/s/ef548123efc1', '8080d9406db84f529eaccef04f698aa6', 'active', '2026-05-29 00:41:38', '2026-05-28 18:41:38', '2026-05-28 18:41:38', '2026-05-28 18:41:38', NULL),
(248, 'https://pan.quark.cn/s/0169157d964d', '8225-别动我的美女徒弟（88集）修仙剧', '夸克网盘', 'https://pan.quark.cn/s/7143c9f49ec2', '2f4a74e7eb334686aab168c418ad8745', 'active', '2026-05-29 00:41:38', '2026-05-28 18:41:38', '2026-05-28 18:41:38', '2026-05-28 18:41:38', NULL),
(249, 'https://pan.quark.cn/s/bb7a098dc537', '9884-陛下臣真不会修仙（77集）', '夸克网盘', 'https://pan.quark.cn/s/5b4b39cdd646', '0376f201e2ff4129803ce8416bfc0087', 'active', '2026-05-29 00:41:38', '2026-05-28 18:41:38', '2026-05-28 18:41:38', '2026-05-28 18:41:38', NULL),
(250, 'https://pan.quark.cn/s/3430192f118d', '10246-九子夺嫡废太子竟是修仙者（80集）', '夸克网盘', 'https://pan.quark.cn/s/9f6e884e2af9', 'f7c2bd14d5524c75b63adfddc9ae2c20', 'active', '2026-05-29 00:41:38', '2026-05-28 18:41:38', '2026-05-28 18:41:38', '2026-05-28 18:41:38', NULL),
(251, 'https://pan.quark.cn/s/ed1dddd97eeb', '9185-修仙逆袭记（79集）', '夸克网盘', 'https://pan.quark.cn/s/b09c271e1655', 'ff4be463e30243a6bf7be08b86fe7f3d', 'active', '2026-05-29 00:41:39', '2026-05-28 18:41:39', '2026-05-28 18:41:39', '2026-05-28 18:41:39', NULL),
(252, 'https://pan.quark.cn/s/c87b43c9f83e', '11281-我和我的莽撞女徒弟（29集）修仙剧', '夸克网盘', 'https://pan.quark.cn/s/3f64d43d6cce', '7db4f63538554e0aab6cf73d78ca4769', 'active', '2026-05-29 00:41:40', '2026-05-28 18:41:40', '2026-05-28 18:41:40', '2026-05-28 18:41:40', NULL),
(253, 'https://pan.quark.cn/s/f4491982b692', '12080-儒道战神&执笔镇山河（60集）修仙剧', '夸克网盘', 'https://pan.quark.cn/s/025045ed2dd0', '7fa04262437c480a9938ea187c664448', 'active', '2026-05-29 00:41:41', '2026-05-28 18:41:41', '2026-05-28 18:41:41', '2026-05-28 18:41:41', NULL),
(254, 'https://pan.quark.cn/s/baeae6f29a31', '12437-斗破2之神界篇（79集）修仙剧', '夸克网盘', 'https://pan.quark.cn/s/c72996540726', 'dc5bbbc6b539490f985fed61ded1e7fd', 'active', '2026-05-29 00:41:41', '2026-05-28 18:41:41', '2026-05-28 18:41:41', '2026-05-28 18:41:41', NULL),
(255, 'https://pan.quark.cn/s/df9b8d4e86b6', '12146-请假回家修仙，没有我村子会输（56集）昕妍', '夸克网盘', 'https://pan.quark.cn/s/dedd81c0426a', '05ca57ef29604f8cabf05509baa5e20a', 'active', '2026-05-29 00:41:41', '2026-05-28 18:41:41', '2026-05-28 18:41:41', '2026-05-28 18:41:41', NULL),
(256, 'https://pan.quark.cn/s/25f972e89b48', '12523-鸿天（77集）修仙剧', '夸克网盘', 'https://pan.quark.cn/s/7fa6c9a6273a', '47a9856ca69445e9bb414f7b1231e99b', 'active', '2026-05-29 00:41:42', '2026-05-28 18:41:42', '2026-05-28 18:41:42', '2026-05-28 18:41:42', NULL),
(257, 'https://pan.quark.cn/s/7ea3478d07c0', '22.我真不会修仙（42集）修仙剧', '夸克网盘', 'https://pan.quark.cn/s/1430a3501194', 'e386d292944c484087edd9c30ebe507a', 'active', '2026-05-29 00:41:43', '2026-05-28 18:41:43', '2026-05-28 18:41:43', '2026-05-28 18:41:43', NULL),
(258, 'https://pan.quark.cn/s/6c10efe0c73b', '一人之下修仙归来&凡人修仙传仙帝归来（80集）', '夸克网盘', 'https://pan.quark.cn/s/1f5000f7233d', '8f04f28966da4ff2a4980d532e134a0c', 'active', '2026-05-29 00:41:44', '2026-05-28 18:41:44', '2026-05-28 18:41:44', '2026-05-28 18:41:44', NULL),
(259, 'https://pan.quark.cn/s/0f63dd77c415', '我的修仙老公（80集）', '夸克网盘', 'https://pan.quark.cn/s/2c5f31a94fe1', '9d681b2eb9da4b71b5c47ca1d2140079', 'active', '2026-05-29 00:41:44', '2026-05-28 18:41:44', '2026-05-28 18:41:44', '2026-05-28 18:41:44', NULL),
(260, 'https://pan.quark.cn/s/b32ee7152d27', '凡人修仙传（80集）', '夸克网盘', 'https://pan.quark.cn/s/c1d708d92a85', '5b74d4fbd0004ab58e7abe5795d83f29', 'active', '2026-05-29 00:41:44', '2026-05-28 18:41:44', '2026-05-28 18:41:44', '2026-05-28 18:41:44', NULL),
(261, 'https://pan.quark.cn/s/2f61b44c3480', '修仙归来（90集）', '夸克网盘', 'https://pan.quark.cn/s/935af6bca005', '44187e3bcd824f76aac212632d21d84b', 'active', '2026-05-29 00:41:45', '2026-05-28 18:41:45', '2026-05-28 18:41:45', '2026-05-28 18:41:45', NULL),
(262, 'https://pan.quark.cn/s/4aa3fb95c41f', '修仙十年下山已无敌（80集）', '夸克网盘', 'https://pan.quark.cn/s/c16bbde7a79d', '2d318d693d704a1dba9be64dee0e4803', 'active', '2026-05-29 00:41:46', '2026-05-28 18:41:46', '2026-05-28 18:41:46', '2026-05-28 18:41:46', NULL),
(263, 'https://pan.quark.cn/s/24d27f0f7b2b', '一人之下修仙归来&凡人修仙传仙帝归来80集', '夸克网盘', 'https://pan.quark.cn/s/a20cd6cfc01a', 'effcccac471e4e57a3d2391c724015be', 'active', '2026-05-29 00:41:46', '2026-05-28 18:41:46', '2026-05-28 18:41:46', '2026-05-28 18:41:46', NULL),
(264, 'https://pan.quark.cn/s/c7d0e66ba096', '从直播开始修仙（48集）', '夸克网盘', 'https://pan.quark.cn/s/9125fab54a3e', '4e188476b1ff41a9857c6336d134f62e', 'active', '2026-05-29 00:41:46', '2026-05-28 18:41:46', '2026-05-28 18:41:46', '2026-05-28 18:41:46', NULL),
(265, 'https://pan.quark.cn/s/4f39a2e56b4c', '我就是叶凡&玄幻：开局我能沟通上古神文 修仙剧（79集）王宇峰&岳雨婷', '夸克网盘', 'https://pan.quark.cn/s/4ee32e736ee0', 'a131707223204941b2299593574117e1', 'active', '2026-05-29 00:41:47', '2026-05-28 18:41:47', '2026-05-28 18:41:47', '2026-05-28 18:41:47', NULL),
(266, 'https://pan.quark.cn/s/e85c995c3ec8', '带着系统来修仙（81集）', '夸克网盘', 'https://pan.quark.cn/s/2db6dbd52d11', 'f485de93c67d4bddaf6b3fdd8ba5153b', 'active', '2026-05-29 00:41:47', '2026-05-28 18:41:47', '2026-05-28 18:41:47', '2026-05-28 18:41:47', NULL),
(267, 'https://pan.baidu.com/s/11kruiGYb_RQFYV_CATcjSQ?pwd=kick', '陈佳 给阿嬷的情书 电影主题原声音乐(2026) FLAC qobuz', '百度网盘', 'https://pan.baidu.com/s/1pFBg6oU-s8uwwemJ2Q8keQ?pwd=6666', '515358859453784', 'active', '2026-05-30 23:29:48', '2026-05-30 17:29:48', '2026-05-30 17:29:48', '2026-05-30 17:29:48', NULL),
(268, 'https://pan.quark.cn/s/8f2e4e37c742', '给阿嬷的情书(2026) TC抢先版', '夸克网盘', 'https://pan.quark.cn/s/a2760792d9ab', '65def7cd16d644d6b6be2b121f4ecd67', 'active', '2026-05-31 22:01:38', '2026-05-31 16:01:38', '2026-05-31 16:01:38', '2026-05-31 16:01:38', NULL),
(269, 'https://pan.quark.cn/s/032c11c9f432', '给阿嬷的情书 电影原声音乐 Hi-Res FLAC 24bit 48kHz qobuz', '夸克网盘', 'https://pan.quark.cn/s/992b93b36e2e', 'e7460bcad7354262a456dcb8672bb524', 'active', '2026-05-31 22:01:41', '2026-05-31 16:01:41', '2026-05-31 16:01:41', '2026-05-31 16:01:41', NULL),
(270, 'https://pan.quark.cn/s/34a7143d4710', '给阿嬷的情书 电影原声音乐 Hi.Res FLAC 24bit 48kHz qobuz', '夸克网盘', 'https://pan.quark.cn/s/1f1a01a39d2d', '1bfa6a81a6ce4cb8a2388d532bf192db', 'active', '2026-05-31 22:01:44', '2026-05-31 16:01:44', '2026-05-31 16:01:44', '2026-05-31 16:01:44', NULL),
(271, 'https://pan.quark.cn/s/898baa030318', '#电影名称：陈佳 给阿嬷的情书 电影主题原声音乐(2026) FLAC qobuz', '夸克网盘', 'https://pan.quark.cn/s/9e407eeb2683', '13b813041ee64d0face3a46d3da67733', 'active', '2026-05-31 22:01:45', '2026-05-31 16:01:46', '2026-05-31 16:01:45', '2026-05-31 16:01:46', NULL),
(272, 'https://pan.quark.cn/s/9e114056cc24', '陈佳 给阿嬷的情书 电影主题原声音乐(2026) FLAC qobuz', '夸克网盘', 'https://pan.quark.cn/s/ab88f27087d4', '50f8e4b9f49a4a7e80e05159f0a7d1b9', 'active', '2026-05-31 22:01:46', '2026-05-31 16:01:46', '2026-05-31 16:01:46', '2026-05-31 16:01:46', NULL),
(273, 'https://pan.baidu.com/s/1k4jDJVXhPpWr_JZR3Z-R1g?pwd=kick', '给阿嬷的情书 电影原声音乐 Hi-Res FLAC 24bit 48kHz qobuz', '百度网盘', 'https://pan.baidu.com/s/1Dz9E5R-Cj4kAXGsF1puBMQ?pwd=6666', '850099857429617', 'active', '2026-05-31 22:01:51', '2026-05-31 16:01:51', '2026-05-31 16:01:51', '2026-05-31 16:01:51', NULL),
(274, 'https://pan.baidu.com/s/11kruiGYb_RQFYV_CATcjSQ?pwd=kick', '#电影名称：陈佳 给阿嬷的情书 电影主题原声音乐(2026) FLAC qobuz', '百度网盘', 'https://pan.baidu.com/s/1jkHLOnelfamcw1fsYFybvA?pwd=6666', '78402276948112', 'active', '2026-05-31 22:02:05', '2026-05-31 16:02:05', '2026-05-31 16:02:05', '2026-05-31 16:02:05', NULL),
(275, 'https://pan.baidu.com/s/14oW8R3A7TWx1jokGxN9IMA?&pwd=6666', '怦然心动20岁：冬季 更新中1080P国语中字网盘资源[1GB期]-百度', '百度网盘', 'https://pan.baidu.com/s/1WDVGiONrq7NfbIL8QGNJ6Q?pwd=6666', '622077984778346', 'active', '2026-06-01 15:23:13', '2026-06-01 09:23:13', '2026-06-01 09:23:13', '2026-06-01 09:23:13', NULL),
(276, 'https://pan.baidu.com/s/13xoQBXhEAfOiKSLvw2n1kA?pwd=0422', '怦然心动20岁：冬季 (2026) 更新至5.29期 [综艺]', '百度网盘', 'https://pan.baidu.com/s/1L78FlfgvyunkEkfBx4SJHg?pwd=6666', '1023961749192680', 'active', '2026-06-01 15:23:21', '2026-06-01 09:23:21', '2026-06-01 09:23:21', '2026-06-01 09:23:21', NULL),
(277, 'https://pan.baidu.com/s/1osDwYFusMKWr6Rv_6glvzw?&pwd=3333', '提取码：3333怦然心动20岁：冬季', '百度网盘', 'https://pan.baidu.com/s/1s2945VeVey7GrRySK6RIIQ?pwd=6666', '4480383019965', 'active', '2026-06-01 15:23:26', '2026-06-01 09:23:26', '2026-06-01 09:23:26', '2026-06-01 09:23:26', NULL),
(278, 'https://pan.baidu.com/s/19U3WjxYFczmqRsbSltP0uQ?&pwd=6666', '怦然心动20岁：冬季/朱荷霖/夏英歌/倪江慧', '百度网盘', 'https://pan.baidu.com/s/1zpZLTO79qqLQQW7YzfYIUQ?pwd=6666', '447572904946421', 'active', '2026-06-01 15:23:31', '2026-06-01 09:23:31', '2026-06-01 09:23:31', '2026-06-01 09:23:31', NULL),
(279, 'https://pan.baidu.com/s/1fuwlvvQYK4iVgmBea2JIzQ?pwd=wogg', '怦然心动20岁：冬季 综艺', '百度网盘', 'https://pan.baidu.com/s/1BQiTNMyMnGPuSDMa4gzaFA?pwd=6666', '964989218284652', 'active', '2026-06-01 15:23:36', '2026-06-01 09:23:36', '2026-06-01 09:23:36', '2026-06-01 09:23:36', NULL),
(280, 'https://pan.baidu.com/s/1l9BqZ0RK8J2aKJE4Oa57oQ?pwd=mwwh', '电影：熊出没·年年有熊 (2026)', '百度网盘', 'https://pan.baidu.com/s/1jhQPiW8dk1SJ1ZNiD7GRww?pwd=6666', '386222996119869', 'active', '2026-06-01 23:35:11', '2026-06-01 17:48:43', '2026-06-01 17:35:11', '2026-06-01 17:48:43', NULL),
(281, 'https://pan.baidu.com/s/1f3odp6WHM-k7ImPbdaW7xw?pwd=6666', '#电影名称：熊出没·年年有熊 (2026) 4K HQ HDR 高码率 国语中字【张伟/张秉君】又名：熊出没大电影12 / 熊出没之年年有熊.', '百度网盘', 'https://pan.baidu.com/s/1O0dtGYziw14vywXaBwGtNQ?pwd=6666', '699303508992509', 'active', '2026-06-01 23:35:15', '2026-06-01 17:48:43', '2026-06-01 17:35:15', '2026-06-01 17:48:43', NULL),
(282, 'https://pan.baidu.com/s/1yq-m1ElR_4N_jQBElmYg3A?pwd=6666', '熊出没·年年有熊 (2026) 4K HQ DoVi 60FPS 高码率 [FLAC无损HIFI声] [内嵌简中]', '百度网盘', 'https://pan.baidu.com/s/1h0KqfdJ4RgUJtAgDQ6M42g?pwd=6666', '18294470524228', 'active', '2026-06-01 23:35:20', '2026-06-01 17:48:44', '2026-06-01 17:35:20', '2026-06-01 17:48:44', NULL),
(283, 'https://pan.baidu.com/s/1tlKymRsXz7RBTXrWLrUKWQ?pwd=5s2g', '熊出没·年年有熊', '百度网盘', 'https://pan.baidu.com/s/1O4mTk5Ozk97UjODGoj7chA?pwd=6666', '449130081798505', 'active', '2026-06-01 23:35:25', '2026-06-01 17:48:48', '2026-06-01 17:35:25', '2026-06-01 17:48:48', NULL),
(284, 'https://pan.baidu.com/s/1WaqYBeo8ee2N7bUPWP7g5A?pwd=yyds', '熊出没·年年有熊‎ (2026) HDR SDR DV杜比视界 HQ高码率 60帧 FALC2.0+DDP2.0+HIFI 内嵌中字【共66GB】熊出没大电影12', '百度网盘', 'https://pan.baidu.com/s/1INLiBwQCOVEHHv-Hw0hX7A?pwd=6666', '919459539326244', 'active', '2026-06-01 23:35:30', '2026-06-01 17:48:49', '2026-06-01 17:35:30', '2026-06-01 17:48:49', NULL),
(285, 'https://pan.baidu.com/s/1HwYdYP5FpKx-ZzCTfjfn3A?pwd=8545', '熊出没·年年有熊(2026)4K HDR 杜比音效 HiveWeb', '百度网盘', 'https://pan.baidu.com/s/1HIhWnB6fchRW8bjvep876Q?pwd=6666', '919459539326244', 'active', '2026-06-01 23:35:35', '2026-06-01 17:48:49', '2026-06-01 17:35:35', '2026-06-01 17:48:49', NULL),
(286, 'https://pan.baidu.com/s/1jO9Zfx9D40NMLvV2YYkzww?pwd=1111', '#电影名称：熊出没·年年有熊 (2026) [4K-HDR] [国语中字]·', '百度网盘', 'https://pan.baidu.com/s/1STvxxHo7fRMGoV8EPJ-hGA?pwd=6666', '232152057121446', 'active', '2026-06-01 23:35:40', '2026-06-01 17:48:48', '2026-06-01 17:35:40', '2026-06-01 17:48:48', NULL),
(287, 'https://pan.baidu.com/s/1UHuxlEnlJjck4EvDadvGBA?pwd=wogg', '熊出没·年年有熊 (2026)[4K][喜剧 动画 奇幻]', '百度网盘', 'https://pan.baidu.com/s/1yb2VksKRPtrYC6UOSr4IXA?pwd=6666', '1028296815072979', 'active', '2026-06-01 23:35:45', '2026-06-01 17:35:45', '2026-06-01 17:35:45', '2026-06-01 17:35:45', NULL),
(288, 'https://pan.baidu.com/s/1kMdk5slD5Q0X6wCUhpEWKA?pwd=9527', '熊出没·年年有熊【2026】【2160P.4K】喜剧 .动画.奇幻.张伟', '百度网盘', 'https://pan.baidu.com/s/17sucmmmfF2XMcns4sktV6A?pwd=6666', '914214750825716', 'active', '2026-06-01 23:48:48', '2026-06-01 17:48:48', '2026-06-01 17:48:48', '2026-06-01 17:48:48', NULL),
(289, 'https://pan.baidu.com/s/13on53FECBI9r4mb-H7ducg?pwd=8888', '光阴之外', '百度网盘', 'https://pan.baidu.com/s/1cdjByz5F08VeoPw3KGy8NA?pwd=6666', '112078731233452', 'active', '2026-06-02 01:54:38', '2026-06-01 19:54:38', '2026-06-01 19:54:38', '2026-06-01 19:54:38', NULL),
(290, 'https://pan.baidu.com/s/1QfXRw66q6szaQ39cl1KWyw?pwd=6666', '【动漫】光阴之外 更新24集 国语中字 2025 4K', '百度网盘', 'https://pan.baidu.com/s/10WLQHk8IDyINLWlQZ0cHnA?pwd=6666', '669687149252501', 'active', '2026-06-02 01:54:43', '2026-06-01 19:54:43', '2026-06-01 19:54:43', '2026-06-01 19:54:43', NULL),
(291, 'https://pan.baidu.com/s/1tj2o9sbo8RN6W4nNTe32yg?pwd=6666', '🗄 光阴之外 (2025) 4K HQ 高码率 [更新24集]', '百度网盘', 'https://pan.baidu.com/s/1Kjkge0micEao9jEq6F4okQ?pwd=6666', '947918828708403', 'active', '2026-06-02 01:54:47', '2026-06-01 19:54:47', '2026-06-01 19:54:47', '2026-06-01 19:54:47', NULL),
(292, 'https://pan.baidu.com/s/1BWy8DsD2cL3kThIDlnPncQ?pwd=yyds', '光阴之外（2025）4K HQ 更新至24集', '百度网盘', 'https://pan.baidu.com/s/1-HqZgyvardknhKyaHU6BGQ?pwd=6666', '661585868946222', 'active', '2026-06-02 01:54:53', '2026-06-01 19:54:53', '2026-06-01 19:54:53', '2026-06-01 19:54:53', NULL),
(293, 'https://pan.baidu.com/s/1-Q0N6DkoRDBrkP8O4Tt6jA?pwd=jfhm', '光阴之外 (2025)4K HQ 高码率 S01E01-E24', '百度网盘', 'https://pan.baidu.com/s/1bV8HAg3ZU9yuFEcP9nDtwQ?pwd=6666', '168603875056447', 'active', '2026-06-02 01:54:57', '2026-06-01 19:54:57', '2026-06-01 19:54:57', '2026-06-01 19:54:57', NULL),
(294, 'https://pan.baidu.com/s/1zA-v9kKohkQgUDiBEgSUtw?pwd=1111', '光阴之外 (2025) [WEB-4K] [国语中字] [更至14集]', '百度网盘', 'https://pan.baidu.com/s/1N7z50E9DXBqzYzfOBPRmZg?pwd=6666', '485867580717289', 'active', '2026-06-02 01:55:04', '2026-06-01 19:55:04', '2026-06-01 19:55:04', '2026-06-01 19:55:04', NULL),
(295, 'https://pan.baidu.com/s/1Hy6KPQs6fra_Fn7HPHwdeQ?pwd=6666', '资源标题：光阴之外 (2025)奇幻 武侠 古装 4KHQHDR10 更新24集', '百度网盘', 'https://pan.baidu.com/s/18nsIVekqm5rHmfdfeQNAHg?pwd=6666', '249386193790949', 'active', '2026-06-02 01:55:08', '2026-06-01 19:55:08', '2026-06-01 19:55:08', '2026-06-01 19:55:08', NULL),
(296, 'https://pan.baidu.com/s/1cS6s8eA4DMggzn2lE3ybKw?pwd=6666', '【国漫】光阴之外 更新23集 国语中字 2025 4K', '百度网盘', 'https://pan.baidu.com/s/1-KUKn0Kl8U6S_IlyvPPE-A?pwd=6666', '669687149252501', 'active', '2026-06-02 01:55:13', '2026-06-01 19:55:13', '2026-06-01 19:55:13', '2026-06-01 19:55:13', NULL),
(297, 'https://pan.baidu.com/s/116ltagqNHLUiNZUuiBYVig?pwd=Yu66', '光阴之外(2025)【更23集】【4K.HQ.高码率】【内嵌简中】【奇幻/动作】', '百度网盘', 'https://pan.baidu.com/s/1PiIuBLwKDobLFfswg5w6tw?pwd=6666', '824699306660326', 'active', '2026-06-02 01:55:17', '2026-06-01 19:55:17', '2026-06-01 19:55:17', '2026-06-01 19:55:17', NULL),
(298, 'https://pan.baidu.com/s/1-HYcSWxoznGaUeADywf-TA?pwd=ddwu', '光阴之外 更新至15集 4K SDR 高码率', '百度网盘', 'https://pan.baidu.com/s/1WyMzInz7GfH1_kBxE8mueg?pwd=6666', '632931959515541', 'active', '2026-06-02 01:55:22', '2026-06-01 19:55:22', '2026-06-01 19:55:22', '2026-06-01 19:55:22', NULL),
(299, 'https://pan.baidu.com/s/1hEt1IvLo5UNPEHNXfMO-Fw?pwd=d233', '光阴之外 (2025) 4K HQ 高码率 更新EP16', '百度网盘', 'https://pan.baidu.com/s/18DPWPjZhGHpVzQWJ7OH6Fg?pwd=6666', '261297444082867', 'active', '2026-06-02 01:55:26', '2026-06-01 19:55:26', '2026-06-01 19:55:26', '2026-06-01 19:55:26', NULL),
(300, 'https://pan.baidu.com/s/1G3sAyhlsg4IHQgbN5eINeg?pwd=0421', '我们的爸爸 第二季 (2026) 更至5.26期 [综艺/家庭]', '百度网盘', 'https://pan.baidu.com/s/1hW3a6zfGqjbda5qamc6Xuw?pwd=6666', '583806714210418', 'active', '2026-06-02 02:03:26', '2026-06-01 20:03:26', '2026-06-01 20:03:26', '2026-06-01 20:03:26', NULL),
(301, 'https://pan.quark.cn/s/3f7999bfaa7c', '我们的爸爸 第二季.1080P更 5.31期', '夸克网盘', 'https://pan.quark.cn/s/fede6e7dc20b', 'b4e01f1455304c749e1fa7900255af14', 'active', '2026-06-02 02:06:16', '2026-06-01 20:06:16', '2026-06-01 20:06:16', '2026-06-01 20:06:16', NULL),
(302, 'https://pan.quark.cn/s/c87bb2e8abd9', '苹果映人心世间有正道（45集）AI短剧', '夸克网盘', 'https://pan.quark.cn/s/5ba1cc7abf46', '24ce0f6093e74ae58fc6d8bfb3f2ca5c', 'active', '2026-06-02 02:07:56', '2026-06-01 20:07:56', '2026-06-01 20:07:56', '2026-06-01 20:07:56', NULL),
(303, 'https://pan.baidu.com/s/1nDWocb6NKCdAYCvIPENl6A?pwd=rtq4', '黄金苹果 황금사과 (2005)', '百度网盘', 'https://pan.baidu.com/s/1dOIHvffPqP1qP7hQ8OgLlg?pwd=6666', '854976162221394', 'active', '2026-06-02 02:08:13', '2026-06-01 20:08:13', '2026-06-01 20:08:13', '2026-06-01 20:08:13', NULL),
(304, 'https://pan.baidu.com/s/1NfjoNBKuH10qTuxBYL2ZhA?pwd=8888', '苹果映人心世间有正道 (45集) AI短剧 | 短剧', '百度网盘', 'https://pan.baidu.com/s/1gXPDE4WrauEHUnjSqc2NmQ?pwd=6666', '309378354237903', 'active', '2026-06-02 02:08:25', '2026-06-01 20:08:25', '2026-06-01 20:08:25', '2026-06-01 20:08:25', NULL),
(305, 'https://pan.baidu.com/s/15Zr-ii8pvZB5zrjFGTZS6g?pwd=kick', '🗄 侃爷 Kanye West BULLY 2026 ALAC 24bit 96Khz 苹果音乐 美区 高解析度无损 内嵌歌词 附歌词文件', '百度网盘', 'https://pan.baidu.com/s/1y9FjwHe_3CqBIrzGwGiobA?pwd=6666', '310662014370028', 'active', '2026-06-02 02:08:30', '2026-06-01 20:08:30', '2026-06-01 20:08:30', '2026-06-01 20:08:30', NULL),
(306, 'https://pan.baidu.com/s/11EbYZnHFk00YGjNQabFzaQ?pwd=dsb3', '《苹果是怎样长成的？》', '百度网盘', 'https://pan.baidu.com/s/1eYLmCFBVTNJ1uJWumhLVvQ?pwd=6666', '1082048345623710', 'active', '2026-06-02 02:08:35', '2026-06-01 20:08:35', '2026-06-01 20:08:35', '2026-06-01 20:08:35', NULL),
(307, 'https://pan.quark.cn/s/5ad339481ded', '黄金苹果 황금사과 (2005)', '夸克网盘', 'https://pan.quark.cn/s/235a81b5eb96', '39b3d4fe5d964d02b59182cd3f174357', 'active', '2026-06-02 02:08:42', '2026-06-01 20:08:42', '2026-06-01 20:08:42', '2026-06-01 20:08:42', NULL),
(308, 'https://pan.quark.cn/s/3da217fa09dd', '神效苹果醋', '夸克网盘', 'https://pan.quark.cn/s/150995607eed', '01035fee04d14a9cbc1a2f4ffce090fa', 'active', '2026-06-02 02:08:45', '2026-06-01 20:08:45', '2026-06-01 20:08:45', '2026-06-01 20:08:45', NULL),
(309, 'https://pan.quark.cn/s/25841024fb01', '美图秀秀解锁会员版（安卓+苹果）：全面的图片编辑体验提供美图秀秀解锁会员版，适用于安卓和苹果设备，享受无广告、丰富功能的图片编辑与美化，助力用户轻松制作精美照片。：', '夸克网盘', 'https://pan.quark.cn/s/e8af512aa832', '7584d6869287468f95a27e3d44cb7a3e', 'active', '2026-06-02 02:08:48', '2026-06-01 20:08:48', '2026-06-01 20:08:48', '2026-06-01 20:08:48', NULL),
(310, 'https://pan.quark.cn/s/2737eee250e3', '[欧美剧][群星][2024][全8集][英语中字][1080P][12G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/679ec583c4c2', '7a75883b6263455eb01dcb3b58d4a63d', 'active', '2026-06-02 02:08:50', '2026-06-01 20:08:50', '2026-06-01 20:08:50', '2026-06-01 20:08:50', NULL),
(311, 'https://pan.quark.cn/s/830539956316', '[欧美剧][闪亮女孩][2022][全8集][英语中字][4K HDR][单集2.5G][22G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/abc9e81211fd', '0e3158de3e194410ad08f15aa1a313f0', 'active', '2026-06-02 02:08:53', '2026-06-01 20:08:53', '2026-06-01 20:08:53', '2026-06-01 20:08:53', NULL),
(312, 'https://pan.quark.cn/s/928f7e8ef8a1', '[欧美剧][人生复本 第一季][2024][全9集][英语中字][4K HDR][单集9G][84G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/14931475bd1d', 'a76330bba54a4ced91ebb593f69021d9', 'active', '2026-06-02 02:08:57', '2026-06-01 20:08:57', '2026-06-01 20:08:57', '2026-06-01 20:08:57', NULL),
(313, 'https://pan.quark.cn/s/063933fa8bc9', '[欧美剧][群星][2024][全8集][英语中字][4K HDR][单集9G][76G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/459a3985b423', '4fafd3e1e34c40198e1a6eec767efdc3', 'active', '2026-06-02 02:09:00', '2026-06-01 20:09:00', '2026-06-01 20:09:00', '2026-06-01 20:09:00', NULL),
(314, 'https://pan.quark.cn/s/e205758d45ec', '[欧美剧][空战群英][2024][全9集][英语中字][4K HDR 杜比视界][单集10G][85G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/e977f83ef127', 'a187ec1e10974ee3b171a92110126713', 'active', '2026-06-02 02:09:02', '2026-06-01 20:09:02', '2026-06-01 20:09:02', '2026-06-01 20:09:02', NULL),
(315, 'https://pan.quark.cn/s/683d52aee9c4', '[欧美剧][骇人来电][2021][全9集][英语中字][1080P][13G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/f9e0fc834b4f', '6253a4e6ce744f7c89c5ac901472e370', 'active', '2026-06-02 02:09:05', '2026-06-01 20:09:05', '2026-06-01 20:09:05', '2026-06-01 20:09:05', NULL),
(316, 'https://pan.quark.cn/s/6b7a6a958ea7', '[欧美剧][弹子球游戏][全1-2季][英语中字][1080P蓝光][32G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/fd2ef7704349', '256baf807b1d456abb39bede0565313a', 'active', '2026-06-02 02:09:07', '2026-06-01 20:09:07', '2026-06-01 20:09:07', '2026-06-01 20:09:07', NULL),
(317, 'https://pan.quark.cn/s/b95c63433567', '[欧美剧][化学课][2023][全8集][英语中字][4K HDR][66G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/eb3cd1d74c5c', 'fa89e884509e4b948f786fae9a72d4b3', 'active', '2026-06-02 02:09:10', '2026-06-01 20:09:10', '2026-06-01 20:09:10', '2026-06-01 20:09:10', NULL),
(318, 'https://pan.quark.cn/s/9a537db31f67', '[欧美剧][捍卫雅各布][2020][全8集][英语中字][1080P][15.5G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/389a036eb7ea', '84b3da99145b40439acb0cb01badcf93', 'active', '2026-06-02 02:09:12', '2026-06-01 20:09:12', '2026-06-01 20:09:12', '2026-06-01 20:09:12', NULL),
(319, 'https://pan.quark.cn/s/830b8ccd03ff', '[欧美剧][为全人类][全1-4季][英语中字][1080P蓝光][76G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/f10840f3844a', '84c2dc0e732c42cf8794d6cb7bc2a04d', 'active', '2026-06-02 02:09:15', '2026-06-01 20:09:15', '2026-06-01 20:09:15', '2026-06-01 20:09:15', NULL),
(320, 'https://pan.quark.cn/s/a2b7c79cbb58', '[欧美剧][拥挤的房间][2023][全10集][简繁英字幕][1080P][36G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/809568610a46', '6484838d43114ffca070652f202bf0cb', 'active', '2026-06-02 02:09:17', '2026-06-01 20:09:17', '2026-06-01 20:09:17', '2026-06-01 20:09:17', NULL),
(321, 'https://pan.quark.cn/s/31fd04c3e720', '[欧美剧][空战群英][2024][全9集][英语中字][1080P蓝光][13G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/1bf9b0ccfaff', 'c0503c010acd4a0fb1989e39dec3ff7b', 'active', '2026-06-02 02:09:20', '2026-06-01 20:09:20', '2026-06-01 20:09:20', '2026-06-01 20:09:20', NULL),
(322, 'https://pan.quark.cn/s/d347d4b800b6', '[欧美剧][初创玩家][2022][全8集][内封多国字幕][4K HDR][单集9G][76G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/35b9f81a5d3b', 'd66bbf938b884869b86775f54d561ed6', 'active', '2026-06-02 02:09:22', '2026-06-01 20:09:22', '2026-06-01 20:09:22', '2026-06-01 20:09:22', NULL),
(323, 'https://pan.quark.cn/s/b91e27d120ba', '[欧美剧][好莱坞诈骗女王][2024][全3集][简繁英字幕][1080P][12G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/e1bab775701b', '447a4bb596ee4f0d9f9e4186da26ed2c', 'active', '2026-06-02 02:09:24', '2026-06-01 20:09:24', '2026-06-01 20:09:24', '2026-06-01 20:09:24', NULL),
(324, 'https://pan.quark.cn/s/a977b7858b79', '[欧美剧][劫机七小时 第一季][2023][全7集][简繁英字幕][4K HDR 杜比视界][单集8G][60G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/cb869c6dc13d', '88c741f7798e4b5b9617796e0f171ac8', 'active', '2026-06-02 02:09:27', '2026-06-01 20:09:27', '2026-06-01 20:09:27', '2026-06-01 20:09:27', NULL),
(325, 'https://pan.quark.cn/s/836f0a04171d', '[欧美剧][惊异传奇][2020][全5集][中文字幕][1080P][7.6G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/187539c684ef', '5ce39311210b43f893a288759ae89b19', 'active', '2026-06-02 02:09:29', '2026-06-01 20:09:29', '2026-06-01 20:09:29', '2026-06-01 20:09:29', NULL),
(326, 'https://pan.quark.cn/s/588d6cc1fe86', '[欧美剧][咆哮 第一季][2022][全8集][内封多国字幕][4K HDR][单集5G][46G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/5678cd2835b6', '928feaf23e0145cea71e256a1b8d7884', 'active', '2026-06-02 02:09:32', '2026-06-01 20:09:32', '2026-06-01 20:09:32', '2026-06-01 20:09:32', NULL),
(327, 'https://pan.quark.cn/s/891bf7679f53', '[欧美剧][入侵][全1-2季][中文字幕][1080P蓝光][54G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/d120871cad08', 'bc7b0c108e874beba229946709bd3e50', 'active', '2026-06-02 02:09:34', '2026-06-01 20:09:34', '2026-06-01 20:09:34', '2026-06-01 20:09:34', NULL),
(328, 'https://pan.quark.cn/s/3cf5bdda96db', '-苹果映人心世间有正道 (45集) AI短剧', '夸克网盘', 'https://pan.quark.cn/s/6ccb0f67e972', '90ce760d4a174498b4fdbedf4e23d56c', 'active', '2026-06-02 02:09:39', '2026-06-01 20:09:39', '2026-06-01 20:09:39', '2026-06-01 20:09:39', NULL),
(329, 'https://pan.quark.cn/s/7d04edbe80c8', '🗄 侃爷 Kanye West BULLY 2026 ALAC 24bit 96Khz 苹果音乐 美区 高解析度无损 内嵌歌词 附歌词文件', '夸克网盘', 'https://pan.quark.cn/s/1720d56170bd', 'a388cc5ed8f446a1812ab3726ec18102', 'active', '2026-06-02 02:09:42', '2026-06-01 20:09:42', '2026-06-01 20:09:42', '2026-06-01 20:09:42', NULL),
(330, 'https://pan.quark.cn/s/891de0db69b7', '窦靖童 专辑 空中飛人 (2024）ALAC 24B-48.0kHz AM HK港区 苹果音乐数字母带', '夸克网盘', 'https://pan.quark.cn/s/c12ec1605216', 'e8b126cdd57a4e71af11f463d1918be3', 'active', '2026-06-02 02:09:45', '2026-06-01 20:09:45', '2026-06-01 20:09:45', '2026-06-01 20:09:45', NULL),
(331, 'https://pan.quark.cn/s/d1b410b445d4', '苹果手机抖音无限注册技术，不掉线不核对+效果自测提供一套创新的抖音无限注册技术，确保用户在苹果手机上顺畅使用，支持不掉线和无需核对，便于自我测试效果，实现快速注册与使用。：', '夸克网盘', 'https://pan.quark.cn/s/462220e55023', '4ab60fef9bad45d28bb874818baeceba', 'active', '2026-06-02 02:09:48', '2026-06-01 20:09:48', '2026-06-01 20:09:48', '2026-06-01 20:09:48', NULL),
(332, 'https://pan.quark.cn/s/4f1d4d5a57b9', '剪映【win+苹果+安卓】专业版6.3 SVIP超级会员解锁！专业视频剪辑体验，永久版！提供全面的视频剪辑功能，支持多平台操作，用户可以轻松进行视频编辑、特效添加、音频处理等，适合创作者制作高质量视频内容，提升视频制作效率。：', '夸克网盘', 'https://pan.quark.cn/s/86fb3c0554bf', 'e243dd6cda3d4871bca76d8268f81349', 'active', '2026-06-02 02:09:50', '2026-06-01 20:09:50', '2026-06-01 20:09:50', '2026-06-01 20:09:50', NULL),
(333, 'https://pan.quark.cn/s/589fd68e499a', '抖音自动抢福袋软件，居然抢到苹果17，一天几百块钱是怎么抢的，一个视频教会你演示自动抢福袋工具的使用方法、策略与收益案例，解析触发机制、脚本设置与风险控制，帮助用户快速上手并提高抢购成功率与变现能力。：', '夸克网盘', 'https://pan.quark.cn/s/99cc36f8cf01', '4bbc3646fd474065a3158cd1f1bb55ff', 'active', '2026-06-02 02:09:53', '2026-06-01 20:09:53', '2026-06-01 20:09:53', '2026-06-01 20:09:53', NULL),
(334, 'https://pan.quark.cn/s/a99cbc40af27', '苹果自动记账软件（包含视频课程）：轻松管理财务的智能助手提供功能强大的苹果自动记账软件，配合详细的视频课程，帮助用户高效管理个人财务，掌握记账技巧，让财务状况一目了然。：', '夸克网盘', 'https://pan.quark.cn/s/7cf2c76363e8', '00f315a2d03c48b18283bb874bd972e8', 'active', '2026-06-02 02:09:55', '2026-06-01 20:09:55', '2026-06-01 20:09:55', '2026-06-01 20:09:55', NULL),
(335, 'https://pan.quark.cn/s/0e3867a1b35c', '《苹果是怎样长成的？》', '夸克网盘', 'https://pan.quark.cn/s/627cdba3d59f', 'c9c7eb2700944a5ea862a8ad9749321d', 'active', '2026-06-02 02:09:58', '2026-06-01 20:09:58', '2026-06-01 20:09:58', '2026-06-01 20:09:58', NULL),
(336, 'https://pan.quark.cn/s/fe467b707d97', '《苹果 (2007)》一部深刻揭示中国社会底层女性生存困境的现实主义电影，充满人文关怀#现实主义 #苹果 #范冰冰 #李玉导演 #中国电影2025-07-17 16:14:28', '夸克网盘', 'https://pan.quark.cn/s/9eb2fad548f6', 'a0a285d258544470a9464c359a9c42f8', 'active', '2026-06-02 02:10:00', '2026-06-01 20:10:00', '2026-06-01 20:10:00', '2026-06-01 20:10:00', NULL),
(337, 'https://pan.quark.cn/s/e80f5acf0cb4', '《appleseed..苹果核战记.中文字幕.hr-hdtv.ac3.1024x576.x264-人人影视制作.mkv》亮点：经典科幻动画，高清画质与震撼音效完美结合，中文字幕畅享精彩剧情标签：#科幻动画 #苹果核战记 #人人影视更新日期：2025-06-02 16:08:31', '夸克网盘', 'https://pan.quark.cn/s/e280f00789bd', '138d93f968aa4a6ca0adfd46d990b7ed', 'active', '2026-06-02 02:10:03', '2026-06-01 20:10:03', '2026-06-01 20:10:03', '2026-06-01 20:10:03', NULL),
(338, 'https://pan.quark.cn/s/3b1cc85ee661', 'Taylor Swift 苹果音乐歌单 Winter Warmers ALAC', '夸克网盘', 'https://pan.quark.cn/s/d76ee46aecf4', '15ef544f41324b77a7d01a8593101478', 'active', '2026-06-02 02:10:06', '2026-06-01 20:10:06', '2026-06-01 20:10:06', '2026-06-01 20:10:06', NULL),
(339, 'https://pan.quark.cn/s/9cb4f1930bb2', '《神效苹果醋 [2025][澳大利亚 英国 传记??犯罪]》', '夸克网盘', 'https://pan.quark.cn/s/c96324ae27ef', '64e2cef89b0c4cdeac3831cb27909ab5', 'active', '2026-06-02 02:10:09', '2026-06-01 20:10:09', '2026-06-01 20:10:09', '2026-06-01 20:10:09', NULL),
(340, 'https://pan.quark.cn/s/5008fd6780ae', '《苹果・2007・国语中字 》', '夸克网盘', 'https://pan.quark.cn/s/b168f8d0ef42', 'fd235457094a4b39a5f88e4f4463e6d7', 'active', '2026-06-02 02:10:12', '2026-06-01 20:10:12', '2026-06-01 20:10:12', '2026-06-01 20:10:12', NULL),
(341, 'https://pan.quark.cn/s/2afc7e76c754', '《小苹果影视盒子 v1.5.2》下载', '夸克网盘', 'https://pan.quark.cn/s/df3ef88d9eb4', '7524fb89f9704b0a80bd84a446d858fe', 'active', '2026-06-02 02:10:15', '2026-06-01 20:10:15', '2026-06-01 20:10:15', '2026-06-01 20:10:15', NULL),
(342, 'https://pan.quark.cn/s/510da57f5fd5', '[解放黑奴][2022][英语中字][1080P][5.3G][苹果TV].', '夸克网盘', 'https://pan.quark.cn/s/aba18163c828', 'd2071d99fb804abc8bc541ab319596a7', 'active', '2026-06-02 02:10:18', '2026-06-01 20:10:18', '2026-06-01 20:10:18', '2026-06-01 20:10:18', NULL),
(343, 'https://drive.uc.cn/s/2fb23438c0074', '角头：斗阵欸(2025)【WEB-DL.1080p】【内封简繁英字幕】【动作/犯罪】', 'UC网盘', 'https://drive.uc.cn/s/855331db94c64', '[\"cdb75c6274754a3c927a174b39211b00\"]', 'active', '2026-06-02 02:19:28', '2026-06-01 20:19:28', '2026-06-01 20:19:28', '2026-06-01 20:19:28', NULL),
(344, 'https://pan.quark.cn/s/378774320958', '角头：斗阵欸', '夸克网盘', 'https://pan.quark.cn/s/6252c5289f0c', 'c11a4014337d41cd9c042dc89878d6d4', 'active', '2026-06-02 02:19:31', '2026-06-01 20:19:31', '2026-06-01 20:19:31', '2026-06-01 20:19:31', NULL),
(345, 'https://pan.quark.cn/s/26dc0f46a4da', '#电影🗄 角头：斗阵欸 角頭：鬥陣欸 (2025) [1080P] [内封多国字幕]·📜', '夸克网盘', 'https://pan.quark.cn/s/f7033f784b5a', '99071a17081841f08936744dc7ad0d13', 'active', '2026-06-02 02:19:35', '2026-06-01 20:19:35', '2026-06-01 20:19:35', '2026-06-01 20:19:35', NULL),
(346, 'https://pan.baidu.com/s/1gzlF7i-sj9LXd2_ph-7hDQ?pwd=8888', '角头：斗阵欸', '百度网盘', 'https://pan.baidu.com/s/17wIUdWYQ1pdaQ4FxnYr09A?pwd=6666', '542133873798525', 'active', '2026-06-02 02:19:40', '2026-06-01 20:19:40', '2026-06-01 20:19:40', '2026-06-01 20:19:40', NULL),
(347, 'https://pan.baidu.com/s/1f8fKBC1vZIdIn9R-cwmK4A?pwd=rzhp', '#电影🗄 角头：斗阵欸 角頭：鬥陣欸 (2025) 国语闽南语简繁英多国字幕.1080p.NF.WEB-DL.H.264.DDP5.1.Atmos.mkv （4.9G）📜', '百度网盘', 'https://pan.baidu.com/s/10gatyWreALmIEnbaQ_lGeA?pwd=6666', '606770523937976', 'active', '2026-06-02 02:19:44', '2026-06-01 20:19:44', '2026-06-01 20:19:44', '2026-06-01 20:19:44', NULL);
INSERT INTO `temp_share` (`id`, `original_url`, `title`, `cloud_name`, `temp_share_url`, `file_id`, `status`, `expires_at`, `last_accessed_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(348, 'https://pan.baidu.com/s/1qgHs4yCNH5MHe9Beq6lzCQ?pwd=piat', '[夸克网盘][百度网盘][迅雷云盘]台湾电影《角头：斗阵欸》（2025）剧情 / 动作 / 犯罪', '百度网盘', 'https://pan.baidu.com/s/1YHQ8gkw2p_AYjLiwLUDkKQ?pwd=6666', '251184617009185', 'active', '2026-06-02 02:19:48', '2026-06-01 20:19:48', '2026-06-01 20:19:48', '2026-06-01 20:19:48', NULL),
(349, 'https://pan.baidu.com/s/1wIjCxDtSL1AmXzHn5SOQUw?pwd=1ysb', '角头：斗阵欸｜角头斗阵欸(2025)【WEB-DL.4K】【内封简繁英字幕】【动作 】【犯罪】【剧情】【电影】', '百度网盘', 'https://pan.baidu.com/s/1J-Yanx_2lMeEFeryNYoC4Q?pwd=6666', '1061496806415561', 'active', '2026-06-02 02:19:52', '2026-06-01 20:19:52', '2026-06-01 20:19:52', '2026-06-01 20:19:52', NULL),
(350, 'https://pan.baidu.com/s/1WRYM_yss6SJAU7cg-vPg0w?pwd=Yu66', '角头：斗阵欸(2025)【WEB-DL.1080p】【内封简繁英字幕】【动作/犯罪】', '百度网盘', 'https://pan.baidu.com/s/1YR74LUBX9wo50uZlJetBMw?pwd=6666', '238840107869071', 'active', '2026-06-02 02:20:00', '2026-06-01 20:20:00', '2026-06-01 20:20:00', '2026-06-01 20:20:00', NULL),
(351, 'https://pan.baidu.com/s/1ZE_w_J2G8riuQwsYZEz-pA?pwd=1111', '#电影🗄 角头：斗阵欸 角頭：鬥陣欸 (2025) [1080P] [内封多国字幕]·📜', '百度网盘', 'https://pan.baidu.com/s/10VblUrv5spO_KFNG7m9EKg?pwd=6666', '606770523937976', 'active', '2026-06-02 02:20:04', '2026-06-01 20:20:04', '2026-06-01 20:20:04', '2026-06-01 20:20:04', NULL),
(352, 'https://pan.baidu.com/s/14aweiacrmH7iOReP-6GwCg?pwd=53a5', '电影：《角头：斗阵欸》2025 1080p高码 国语中字', '百度网盘', 'https://pan.baidu.com/s/1eg5taenaBLlCX4zZWwwP5g?pwd=6666', '542133873798525', 'active', '2026-06-02 02:20:08', '2026-06-01 20:20:08', '2026-06-01 20:20:08', '2026-06-01 20:20:08', NULL),
(353, 'https://pan.baidu.com/s/14ELrfegIDcsPEAZBMd-yqw?pwd=8888', '仙逆剧场版 神临之战', '百度网盘', 'https://pan.baidu.com/s/1NskMdPFoefWmEG3Ms3xzVA?pwd=6666', '1007913274335991', 'active', '2026-06-02 03:28:10', '2026-06-01 21:28:10', '2026-06-01 21:28:10', '2026-06-01 21:28:10', NULL),
(354, 'https://pan.baidu.com/s/1qgvZ1s-1_Fv0kqyE66Vu2g?pwd=5vk2', '仙逆 (2023) 更新EP142 4K～1080p 动漫/修仙 仙逆剧场版 神临之战', '百度网盘', 'https://pan.baidu.com/s/1x6sDribupmfw5E0XCkR7UQ?pwd=6666', '348251693727643', 'active', '2026-06-02 03:28:14', '2026-06-01 21:28:14', '2026-06-01 21:28:14', '2026-06-01 21:28:14', NULL),
(355, 'https://pan.baidu.com/s/14fBefpwlrGETB0h-uGNDBw?pwd=1111', '仙逆剧场版 神临之战 (2025) [WEB-4K] [国语中字]', '百度网盘', 'https://pan.baidu.com/s/1l1FgFPoUUSyg8qbEtVRFqA?pwd=6666', '497986481946009', 'active', '2026-06-02 03:28:20', '2026-06-01 21:28:20', '2026-06-01 21:28:20', '2026-06-01 21:28:20', NULL),
(356, 'https://pan.quark.cn/s/5c94789a6740', '【标题】：仙逆剧场版 神临之战（2025）4K 臻彩【描述】：古神之地后，修魔内海永夜魔城一夜崛起，为拓展领地，不断对修魔海周边宗门下手，其中也包括了李慕婉所在云天宗。李慕婉在护门大战中身中奇毒，性命攸关，王林得知此事后，携其再次闯入修魔内海，王林以化神初期修为力战三大城主，名震修魔内海，带回解药救下李幕婉，却发现危机并未解决，千年阴谋浮出水面。最终凭借二人情愫及化神后首次与古神之身合体，联手斩灭魔尊。下载地址', '夸克网盘', 'https://pan.quark.cn/s/718ee14e38a0', '65802577d62b49d0a493bc1acea6ab8d', 'active', '2026-06-02 03:28:25', '2026-06-01 21:28:25', '2026-06-01 21:28:25', '2026-06-01 21:28:25', NULL),
(357, 'https://pan.quark.cn/s/3fe25b3e6eba', '名称：《仙逆剧场版 神临之战》2025 [4K画质更新] 内嵌中字 [7.4G]️亮点：该剧场版动画结合动作、奇幻和古装元素，提供4K高清画质和内嵌中文字幕，带给观众震撼的视觉体验，适合喜欢仙侠题材的影迷。标签：#仙逆 #剧场版 #4K画质 #动作动画 #奇幻古装', '夸克网盘', 'https://pan.quark.cn/s/34c119fa0d6c', '7624e87e972d4db88411f32a8b4e3fae', 'active', '2026-06-02 03:28:28', '2026-06-01 21:28:28', '2026-06-01 21:28:28', '2026-06-01 21:28:28', NULL),
(358, 'https://pan.quark.cn/s/d028157be564', '仙逆 / 仙逆剧场版 神临之战 (2025) 4K 国漫.', '夸克网盘', 'https://pan.quark.cn/s/b3380c2e7c84', '0682b10b4f134fb0bfa6f2fcad720919', 'active', '2026-06-02 03:28:31', '2026-06-01 21:28:31', '2026-06-01 21:28:31', '2026-06-01 21:28:31', NULL),
(359, 'https://pan.quark.cn/s/f412dc34daa1', '初入职场·金融季.1080P更 6.3期', '夸克网盘', 'https://pan.quark.cn/s/fdcaba548723', '8a4bec3ac49c47fc8e451b9c1404ac12', 'active', '2026-06-03 22:59:33', '2026-06-03 16:59:33', '2026-06-03 16:59:33', '2026-06-03 16:59:33', NULL),
(360, 'https://pan.quark.cn/s/5d1f26207762', '给阿嬷的情书(2026)', '夸克网盘', 'https://pan.quark.cn/s/4f8b2b53cfcc', '79b5fce01daa452182a1a5c84d95837a', 'active', '2026-06-04 14:27:22', '2026-06-04 12:44:06', '2026-06-04 08:27:22', '2026-06-04 12:44:06', NULL),
(361, 'https://pan.quark.cn/s/e3af4dfaa68e', '一人之下修仙归来|凡人修仙传仙帝归来 80集', '夸克网盘', 'https://pan.quark.cn/s/fa3b6b2f7faf', 'f83081e0c7a64158971c9a3a9a958e28', 'active', '2026-06-04 14:28:47', '2026-06-04 08:28:47', '2026-06-04 08:28:47', '2026-06-04 08:28:47', NULL),
(362, 'https://pan.quark.cn/s/24d27f0f7b2b', '一人之下修仙归来&凡人修仙传仙帝归来80集', '夸克网盘', 'https://pan.quark.cn/s/a1d0cfc2e42c', 'e808aa8d09fd4c3e9bae570f100d93f7', 'active', '2026-06-04 14:29:40', '2026-06-04 08:29:40', '2026-06-04 08:29:40', '2026-06-04 08:29:40', NULL),
(363, 'https://pan.quark.cn/s/6c10efe0c73b', '一人之下修仙归来&凡人修仙传仙帝归来（80集）', '夸克网盘', 'https://pan.quark.cn/s/0b248d47a087', 'fc016102a75a480ba7835b4afa1be42f', 'active', '2026-06-04 14:31:56', '2026-06-04 08:31:56', '2026-06-04 08:31:56', '2026-06-04 08:31:56', NULL),
(364, 'https://pan.baidu.com/s/1h707-dzBqXPJAtQvpQMRxA?pwd=8888', '【电影】熊出没·年年有熊.2026（熊出没年年有熊）', '百度网盘', 'https://pan.baidu.com/s/1tQECo5ZnwOfCYbn4KHngHg?pwd=6666', '269855645056952', 'active', '2026-06-04 14:39:32', '2026-06-04 08:39:32', '2026-06-04 08:39:32', '2026-06-04 08:39:32', NULL),
(365, 'https://pan.baidu.com/s/1PfPvoa7zyq5dwBpsxNy84A?pwd=Yu66', '熊出没·年年有熊(2026)【4K.HQ.高码率】【HDR10&DV 双版本】【内嵌简中】', '百度网盘', 'https://pan.baidu.com/s/1XgErFR0s9ljY064l_Mslnw?pwd=6666', '1069028733228040', 'active', '2026-06-04 14:39:36', '2026-06-04 08:39:36', '2026-06-04 08:39:36', '2026-06-04 08:39:36', NULL),
(366, 'https://pan.baidu.com/s/1d-hPvqWMsWuguqLGc9klEA?pwd=77e6', '🗄 熊出没·年年有熊 (2026) 4K 高码 HDR', '百度网盘', 'https://pan.baidu.com/s/147vrcy_cX9yMvh8pEUqRUg?pwd=6666', '774611775670516', 'active', '2026-06-04 14:39:40', '2026-06-04 08:39:40', '2026-06-04 08:39:40', '2026-06-04 08:39:40', NULL),
(367, 'https://pan.baidu.com/s/1WaqYBeo8ee2N7bUPWP7g5A?pwd=yyds', '熊出没·年年有熊‎ (2026) HDR SDR DV杜比视界 HQ高码率 60帧 FALC2.0+DDP2.0+HIFI 内嵌中字【共66GB】熊出没大电影12', '百度网盘', 'https://pan.baidu.com/s/1mVicOvhCSzSjwdsqFnC3JA?pwd=6666', '505661318417632', 'active', '2026-06-04 14:39:45', '2026-06-04 08:39:45', '2026-06-04 08:39:45', '2026-06-04 08:39:45', NULL),
(368, 'https://pan.baidu.com/s/12K5C6uuQkISGW6ZFjSmE_g?pwd=6558', '熊出没·年年有熊（臻彩）', '百度网盘', 'https://pan.baidu.com/s/1i0m_m6YzxNuIo8KneYGNMQ?pwd=6666', '203255815982250', 'active', '2026-06-04 14:39:49', '2026-06-04 08:39:49', '2026-06-04 08:39:49', '2026-06-04 08:39:49', NULL),
(369, 'https://pan.baidu.com/s/1kMdk5slD5Q0X6wCUhpEWKA?pwd=9527', '熊出没·年年有熊【2026】【4KHQHDR60FPS_DDP高码率.4K】喜剧 .动画.奇幻.张伟', '百度网盘', 'https://pan.baidu.com/s/1Jf06mZ0x4ATlcth7DcD_Lw?pwd=6666', '117123303631351', 'active', '2026-06-04 14:39:54', '2026-06-04 08:39:54', '2026-06-04 08:39:54', '2026-06-04 08:39:54', NULL),
(370, 'https://pan.baidu.com/s/1rTHnGPrpzjco1Bk6Opj0CQ?pwd=1234', '【电影】熊出没·年年有熊（2026）4K+1080P', '百度网盘', 'https://pan.baidu.com/s/12Fh86j8MEHox9wpOFULktw?pwd=6666', '7892750180306', 'active', '2026-06-04 14:39:59', '2026-06-04 08:39:59', '2026-06-04 08:39:59', '2026-06-04 08:39:59', NULL),
(371, 'https://pan.baidu.com/s/17IrHU_XLIXuQTcfDZrTAXw?pwd=afq7', '#电影🗄 熊出没·年年有熊 (2026) 【4K.HQ】&【4KHDR10D】&【4K.DV】&【高码率】【内嵌简中】【喜剧】【动画】【儿童电影】📜', '百度网盘', 'https://pan.baidu.com/s/1DUvM2r4tuoFuJFqXaBM8aw?pwd=6666', '1069028733228040', 'active', '2026-06-04 14:40:04', '2026-06-04 08:40:04', '2026-06-04 08:40:04', '2026-06-04 08:40:04', NULL),
(372, 'https://pan.baidu.com/s/1UHuxlEnlJjck4EvDadvGBA?pwd=wogg', '熊出没·年年有熊 (2026)[4K][喜剧 动画 奇幻]', '百度网盘', 'https://pan.baidu.com/s/1c8tFb6UdsjKNAu_eC8e31Q?pwd=6666', '203255815982250', 'active', '2026-06-04 14:40:08', '2026-06-04 08:40:08', '2026-06-04 08:40:08', '2026-06-04 08:40:08', NULL),
(373, 'https://pan.baidu.com/s/1l9BqZ0RK8J2aKJE4Oa57oQ?pwd=mwwh', '#电影电影：熊出没·年年有熊 (2026)剧情：熊大曾是森林里的“老大哥”，直到一个不速之客到来，它将自己神力传给了熊强，熊大变成了三人组合内能力最弱者。为了改变现状，他步入了反派陷阱，引发了毁天灭地的危机.....💾夸克网盘| 💾百度网盘| 💽UC网盘| 💿迅雷网盘| 💾阿里云盘📁 大小：N🏷 标签：#电影 #熊出没⬇️【评论区可搜索】 | 🔍网盘专搜', '百度网盘', 'https://pan.baidu.com/s/16mYx5AYyknFL1kcc67z8Mw?pwd=6666', '891217190592944', 'active', '2026-06-04 14:40:13', '2026-06-04 08:40:13', '2026-06-04 08:40:13', '2026-06-04 08:40:13', NULL),
(374, 'https://pan.baidu.com/s/1yq-m1ElR_4N_jQBElmYg3A?pwd=6666', '熊出没·年年有熊 (2026) 4K HQ DoVi 60FPS 高码率 [FLAC无损HIFI声] [内嵌简中]', '百度网盘', 'https://pan.baidu.com/s/1darrMeIrycvJT2AJ4Iipdw?pwd=6666', '588576171249008', 'active', '2026-06-04 14:40:17', '2026-06-04 08:40:17', '2026-06-04 08:40:17', '2026-06-04 08:40:17', NULL),
(375, 'https://pan.baidu.com/s/1jO9Zfx9D40NMLvV2YYkzww?pwd=1111', '#电影名称：熊出没·年年有熊 (2026) [4K-HDR] [国语中字]·', '百度网盘', 'https://pan.baidu.com/s/155AcDVOpvruhLS73Hqe6tw?pwd=6666', '984772873429172', 'active', '2026-06-04 14:40:22', '2026-06-04 08:40:22', '2026-06-04 08:40:22', '2026-06-04 08:40:22', NULL),
(376, 'https://pan.baidu.com/s/1f3odp6WHM-k7ImPbdaW7xw?pwd=6666', '#电影名称：熊出没·年年有熊 (2026) 4K HQ HDR 高码率 国语中字【张伟/张秉君】又名：熊出没大电影12 / 熊出没之年年有熊.', '百度网盘', 'https://pan.baidu.com/s/1L24eqMDTSCTkLztQ6nyi_w?pwd=6666', '1108270845220694', 'active', '2026-06-04 14:40:28', '2026-06-04 08:40:28', '2026-06-04 08:40:28', '2026-06-04 08:40:28', NULL),
(377, 'https://pan.baidu.com/s/1HwYdYP5FpKx-ZzCTfjfn3A?pwd=8545', '熊出没·年年有熊(2026)4K HDR 杜比音效 HiveWeb', '百度网盘', 'https://pan.baidu.com/s/1efQp-DmIJ0xReap_s195Ng?pwd=6666', '505661318417632', 'active', '2026-06-04 14:40:32', '2026-06-04 08:40:32', '2026-06-04 08:40:32', '2026-06-04 08:40:32', NULL),
(378, 'https://pan.quark.cn/s/d15b5f169f74', '【电影】熊出没·年年有熊.2026（熊出没年年有熊）', '夸克网盘', 'https://pan.quark.cn/s/a0c834f07967', 'e44ac995fbe64791811f879983498768', 'active', '2026-06-04 14:40:35', '2026-06-04 08:40:35', '2026-06-04 08:40:35', '2026-06-04 08:40:35', NULL),
(379, 'https://pan.quark.cn/s/9df30784a0e0', '2026动画.熊出没·年年有熊.1080p.4k.HD国语中字', '夸克网盘', 'https://pan.quark.cn/s/49464bd6587d', '63804fad318d4de6a7ec0b56eae9a420', 'active', '2026-06-04 14:40:38', '2026-06-04 08:40:38', '2026-06-04 08:40:38', '2026-06-04 08:40:38', NULL),
(380, 'https://pan.quark.cn/s/59e88ffd1aea', '熊出没·年年有熊(2026)【4K.HQ.高码率】【HDR10&DV 双版本】【内嵌简中】', '夸克网盘', 'https://pan.quark.cn/s/8d05e13cf17b', '4c200f826a314019a027b5197d14d47b', 'active', '2026-06-04 14:40:41', '2026-06-04 08:40:41', '2026-06-04 08:40:41', '2026-06-04 08:40:41', NULL),
(381, 'https://pan.quark.cn/s/9956e43bd7d0', '#电影名称：熊出没·年年有熊(2026)【4K/HDR/SDR/DV杜比视界/高码】.', '夸克网盘', 'https://pan.quark.cn/s/3489a5c04d1d', '3b5a4673d791453dbd49fc18d2b2a116', 'active', '2026-06-04 14:40:44', '2026-06-04 08:40:44', '2026-06-04 08:40:44', '2026-06-04 08:40:44', NULL),
(382, 'https://pan.quark.cn/s/2ed15d7e24e9', '熊出没·年年有熊 (2026) 4K 高码 HDR', '夸克网盘', 'https://pan.quark.cn/s/1a5c990f7b7e', '489d6d5064b04684999463b3c424ac2e', 'active', '2026-06-04 14:40:47', '2026-06-04 08:40:47', '2026-06-04 08:40:47', '2026-06-04 08:40:47', NULL),
(383, 'https://pan.quark.cn/s/31702964e152', '熊出没·年年有熊‎ (2026) HDR SDR DV杜比视界 HQ高码率 60帧 FALC2.0+DDP2.0+HIFI 内嵌中字【共66GB】熊出没大电影12', '夸克网盘', 'https://pan.quark.cn/s/10f5acd15186', 'ac41f9415860444aa0d1c4c954173f24', 'active', '2026-06-04 14:40:50', '2026-06-04 08:40:50', '2026-06-04 08:40:50', '2026-06-04 08:40:50', NULL),
(384, 'https://pan.quark.cn/s/3d39f57106b8', '#电影名称：熊出没·年年有熊 (2026) 【4K.HQ】&【4KHDR10D】&【4K.DV】&【高码率】【内嵌简中】【喜剧】【动画】【儿童电影】', '夸克网盘', 'https://pan.quark.cn/s/4bc538b5d868', 'b55a16d2a7e7498cad4093279b442162', 'active', '2026-06-04 14:40:54', '2026-06-04 08:40:54', '2026-06-04 08:40:54', '2026-06-04 08:40:54', NULL),
(385, 'https://pan.quark.cn/s/0f83950227af', '熊出没·年年有熊 【熊出没年年有熊 (2026)】【4K/高码/超清】【国语中字】【类型：喜剧 / 奇幻 / 动画 / 治愈】 今天', '夸克网盘', 'https://pan.quark.cn/s/f1fbe7051ea1', '09bab03295e942a58bb8a231573557d4', 'active', '2026-06-04 14:40:58', '2026-06-04 08:40:58', '2026-06-04 08:40:58', '2026-06-04 08:40:58', NULL),
(386, 'https://pan.quark.cn/s/8afb4f0579f5', '熊出没·年年有熊 【4K国产片】熊出没年年有熊 (2026)[喜剧 动画 奇幻].2160P.60fps.内嵌中字. 提取码： 今天', '夸克网盘', 'https://pan.quark.cn/s/7d5519e99e08', '0a2c2661764e4be3ab16e4d94c05de76', 'active', '2026-06-04 14:41:02', '2026-06-04 08:41:02', '2026-06-04 08:41:02', '2026-06-04 08:41:02', NULL),
(387, 'https://pan.quark.cn/s/ff54fdcacbd6', '熊出没·年年有熊 熊出没年年有熊(2026) [中国大陆] [喜剧/动画/奇幻] 汉语普通话6.5分 今天', '夸克网盘', 'https://pan.quark.cn/s/fe8099461511', '3e09253948c647ed8721001eb5fbf22e', 'active', '2026-06-04 14:41:05', '2026-06-04 08:41:05', '2026-06-04 08:41:05', '2026-06-04 08:41:05', NULL),
(388, 'https://pan.quark.cn/s/6f1e79a0ae59', '熊出没·年年有熊 (2026)[4K][喜剧 动画 奇幻]', '夸克网盘', 'https://pan.quark.cn/s/60bb31630a9d', '9fb939296cd347e1bc5464582ddb3486', 'active', '2026-06-04 14:41:09', '2026-06-04 08:41:09', '2026-06-04 08:41:09', '2026-06-04 08:41:09', NULL),
(389, 'https://pan.quark.cn/s/e2c1693f2b34', '#电影名称：熊出没·年年有熊 4K高码率 [60帧率版][FLAC无损音轨]', '夸克网盘', 'https://pan.quark.cn/s/742d73bd9b23', '46c9e67d3c3f43049b6adb4a4ae03280', 'active', '2026-06-04 14:41:12', '2026-06-04 08:41:12', '2026-06-04 08:41:12', '2026-06-04 08:41:12', NULL),
(390, 'https://pan.quark.cn/s/1bd15f1d9c8d', '熊出没·年年有熊(2026)WEB-4K HQ DV杜比视界 简体字幕', '夸克网盘', 'https://pan.quark.cn/s/b4fec89ea163', '2a17dd3cf50f4e52a6c674a303b97ff4', 'active', '2026-06-04 14:41:15', '2026-06-04 08:41:15', '2026-06-04 08:41:15', '2026-06-04 08:41:15', NULL),
(391, 'https://pan.quark.cn/s/82f18917c839', '熊出没·年年有熊 (2026) 4K HQ DoVi 60FPS 高码率 [FLAC无损HIFI声] [内嵌简中]', '夸克网盘', 'https://pan.quark.cn/s/78bfe03c84e5', 'aec71577cfcb4884be7947016366b0ab', 'active', '2026-06-04 14:41:18', '2026-06-04 08:41:18', '2026-06-04 08:41:18', '2026-06-04 08:41:18', NULL),
(392, 'https://pan.quark.cn/s/fb4cd3d5f0b0', '熊出没·年年有熊 (2026) [4K] [HDR] [内嵌简中]', '夸克网盘', 'https://pan.quark.cn/s/10a171f1f2de', '31c44ad62f384bcea564dc42e14853b9', 'active', '2026-06-04 14:41:21', '2026-06-04 08:41:21', '2026-06-04 08:41:21', '2026-06-04 08:41:21', NULL),
(393, 'https://pan.quark.cn/s/4a296efdf42a', '#电影名称：熊出没·年年有熊 (2026) [4K-HDR] [国语中字]·', '夸克网盘', 'https://pan.quark.cn/s/f44fc8a77173', 'af4160b575a94b2597b900f3345e780a', 'active', '2026-06-04 14:41:23', '2026-06-04 08:41:23', '2026-06-04 08:41:23', '2026-06-04 08:41:23', NULL),
(394, 'https://pan.quark.cn/s/44ae85bfd2dd', '资源标题：熊出没·年年有熊 (2026)喜剧 动画 奇幻 4KHQHDR60FPS 杜比视界 HiFi无损声', '夸克网盘', 'https://pan.quark.cn/s/0858672d37bd', '36eed2c8c58a447d920836f4961eab3f', 'active', '2026-06-04 14:41:27', '2026-06-04 08:41:27', '2026-06-04 08:41:27', '2026-06-04 08:41:27', NULL),
(395, 'https://pan.quark.cn/s/013ae7609887', '熊出没·年年有熊(2026)4K HDR 杜比音效 HiveWeb', '夸克网盘', 'https://pan.quark.cn/s/f5833cbcf7c0', 'a20b21e07b574fb3a62a120a59a96042', 'active', '2026-06-04 14:41:29', '2026-06-04 08:41:29', '2026-06-04 08:41:29', '2026-06-04 08:41:29', NULL),
(396, 'https://pan.quark.cn/s/2b2a2e2ad58b', '#电影名称：熊出没·年年有熊 (2026) 4K HQ HDR 高码率 国语中字【张伟/张秉君】又名：熊出没大电影12 / 熊出没之年年有熊.', '夸克网盘', 'https://pan.quark.cn/s/4af046c411cd', 'dc69c76cabed4b42b5d99ab49da57dde', 'active', '2026-06-04 14:41:32', '2026-06-04 08:41:32', '2026-06-04 08:41:32', '2026-06-04 08:41:32', NULL),
(397, 'https://pan.quark.cn/s/8f2e4e37c742', '给阿嬷的情书(2026) TC抢先版', '夸克网盘', 'https://pan.quark.cn/s/2e7e2e542952', 'a92e14021253468393f29022a17de37b', 'active', '2026-06-04 18:44:09', '2026-06-04 12:44:09', '2026-06-04 12:44:09', '2026-06-04 12:44:09', NULL),
(398, 'https://pan.baidu.com/s/1dYR0XEMC6SONK28b8dQZGw?&pwd=qxqz', '给阿嬷的情书（TC1080P完整版）', '百度网盘', 'https://pan.baidu.com/s/13if7543IbNbQ2W51LfZW0A?pwd=6666', '485711332138979', 'active', '2026-06-04 18:44:14', '2026-06-04 12:44:14', '2026-06-04 12:44:14', '2026-06-04 12:44:14', NULL),
(399, 'https://pan.baidu.com/s/1Fj7mJldA2IQkA_WpSItz4A?&pwd=6666', '给阿嬷的情书', '百度网盘', 'https://pan.baidu.com/s/1Qyn0Rf_rBurDlDtWSNJzpQ?pwd=6666', '51376877353815', 'active', '2026-06-04 18:44:18', '2026-06-04 12:44:18', '2026-06-04 12:44:18', '2026-06-04 12:44:18', NULL),
(400, 'https://pan.baidu.com/s/1k4jDJVXhPpWr_JZR3Z-R1g?pwd=kick', '给阿嬷的情书 电影原声音乐 Hi-Res FLAC 24bit 48kHz qobuz', '百度网盘', 'https://pan.baidu.com/s/14NQ8RdhekZ9pvujVOHIcMw?pwd=6666', '469397041787496', 'active', '2026-06-04 18:44:22', '2026-06-04 12:44:22', '2026-06-04 12:44:22', '2026-06-04 12:44:22', NULL),
(401, 'https://pan.baidu.com/s/11kruiGYb_RQFYV_CATcjSQ?pwd=kick', '#电影名称：陈佳 给阿嬷的情书 电影主题原声音乐(2026) FLAC qobuz', '百度网盘', 'https://pan.baidu.com/s/1bOCwrhYn0JqkgbEAWsvDhw?pwd=6666', '1095990772683777', 'active', '2026-06-04 18:44:26', '2026-06-04 12:44:26', '2026-06-04 12:44:26', '2026-06-04 12:44:26', NULL),
(402, 'https://pan.quark.cn/s/ab23b25253c7', '给阿嬷的情书（TC1080P完整版）', '夸克网盘', 'https://pan.quark.cn/s/c6a8ea968178', 'f7a783775aa746eea3e85ba83c918279', 'active', '2026-06-04 18:44:29', '2026-06-04 12:44:29', '2026-06-04 12:44:29', '2026-06-04 12:44:29', NULL),
(403, 'https://pan.quark.cn/s/846542f2db5e', '给阿嬷的情书》电影原声音乐 24B-48kHz', '夸克网盘', 'https://pan.quark.cn/s/137fccdc509f', 'd8e32c06e269400cb83e7df7cf5b1ba3', 'active', '2026-06-04 18:45:12', '2026-06-04 12:45:12', '2026-06-04 12:45:12', '2026-06-04 12:45:12', NULL),
(404, 'https://pan.quark.cn/s/032c11c9f432', '给阿嬷的情书 电影原声音乐 Hi-Res FLAC 24bit 48kHz qobuz', '夸克网盘', 'https://pan.quark.cn/s/36fef63dc8f7', 'db8af800fcf64e6697f55cc7d7b8a3ce', 'active', '2026-06-04 18:45:15', '2026-06-04 12:45:15', '2026-06-04 12:45:15', '2026-06-04 12:45:15', NULL),
(405, 'https://pan.quark.cn/s/898baa030318', '#电影名称：陈佳 给阿嬷的情书 电影主题原声音乐(2026) FLAC qobuz', '夸克网盘', 'https://pan.quark.cn/s/29fc8ed0b576', '3a842d430ee5461db47f5fe79687281e', 'active', '2026-06-04 18:45:19', '2026-06-04 12:45:19', '2026-06-04 12:45:19', '2026-06-04 12:45:19', NULL);

--
-- 转储表的索引
--

--
-- 表的索引 `api_config`
--
ALTER TABLE `api_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_api_name` (`name`);

--
-- 表的索引 `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_category_name` (`name`);

--
-- 表的索引 `cookie_config`
--
ALTER TABLE `cookie_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_cloud_name` (`cloud_name`);

--
-- 表的索引 `resources`
--
ALTER TABLE `resources`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_share_link` (`share_link`(255)),
  ADD UNIQUE KEY `uk_file_id` (`file_id`),
  ADD KEY `idx_category_id` (`category_id`),
  ADD KEY `idx_sort_order` (`sort_order`);

--
-- 表的索引 `system_config`
--
ALTER TABLE `system_config`
  ADD PRIMARY KEY (`config_key`);

--
-- 表的索引 `temp_share`
--
ALTER TABLE `temp_share`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_temp_share_lookup` (`cloud_name`,`status`,`expires_at`),
  ADD KEY `idx_temp_share_original` (`original_url`(255));

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `api_config`
--
ALTER TABLE `api_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=18;

--
-- 使用表AUTO_INCREMENT `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=25;

--
-- 使用表AUTO_INCREMENT `cookie_config`
--
ALTER TABLE `cookie_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=53;

--
-- 使用表AUTO_INCREMENT `resources`
--
ALTER TABLE `resources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=174;

--
-- 使用表AUTO_INCREMENT `temp_share`
--
ALTER TABLE `temp_share`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键', AUTO_INCREMENT=406;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
