目录
- Linux 系统部署
- Windows 系统部署
- 部署后配置
- 常见问题
- 功能与接口
- API 开放接口
- 网盘配置
- 需要修改端口教程(搭建部署前修改)默认端口5004
- 联系方式
- 免责声明
Linux 系统部署
支持系统
- Ubuntu 18.04+
- Debian 9+
- CentOS 7+
- Rocky Linux 8+
- AlmaLinux 8+
环境要求
暂时无法在飞书文档外展示此内容
部署前准备
1. 安装 MySQL 并创建数据库
安装 MySQL（如果未安装）：
Ubuntu/Debian:
sudo apt-get update
sudo apt-get install -y mysql-server
 
CentOS/Rocky/AlmaLinux:
sudo yum install -y mysql-server
sudo systemctl start mysqld
 
启动 MySQL:
sudo systemctl start mysql
sudo systemctl enable mysql
 
登录 MySQL 创建数据库:
mysql -u root -p
 
在 MySQL 中执行：
CREATE DATABASE ucmao_search CHARACTER SET utf8mb4;
exit
2. 上传项目文件
使用 scp 上传项目到服务器：
scp -r search-ucmao-master root@你的服务器IP:/opt/baozang-search/
3. 修改脚本配置
编辑 install.sh，修改数据库配置：
DB_NAME="ucmao_search"        # 你的数据库名
DB_USER="root"                # 你的用户名
DB_PASSWORD="你的密码"         # 你的密码（必须修改）
运行部署脚本
进入项目目录：
cd /opt/baozang-search/search-ucmao-master
 
赋予执行权限：
chmod +x install.sh
 
运行脚本（必须使用 root 权限）：
sudo ./install.sh
脚本执行流程
1. 1. 显示数据库配置指南
2. 2. 检查数据库配置是否已修改
3. 3. 检查 root 权限
4. 4. 检测系统类型
5. 5. 安装系统依赖（Python3、Nginx等）
6. 6. 检查 MySQL 状态
7. 7. 准备项目目录
8. 8. [暂停] 确认项目文件已上传
9. 9. 配置 Python 虚拟环境
10. 10. 创建 .env 配置文件
11. 11. 导入 schema.sql 表结构
12. 12. 创建 Systemd 服务
13. 13. 配置 Nginx
14. 14. 配置防火墙
15. 15. 启动服务
16. 16. 显示完成信息
部署完成
脚本会显示以下信息：
========================================
  宝藏搜部署完成！
========================================
 
访问地址:
  本机: http://127.0.0.1:5004
  外网: http://你的服务器IP
 
管理员账号:
  用户名: admin
  密码: admin123
 
常用命令:
  启动: systemctl start baozang-search
  停止: systemctl stop baozang-search
  重启: systemctl restart baozang-search
  状态: systemctl status baozang-search
  日志: journalctl -u baozang-search -f

简易部署教学
部署前准备
1. ✅ 宝塔面板已安装
2. ✅ Python 3.9.7 已安装(宝塔应用商店可以直接下载安装)
[图片]
3. ✅ Nginx 已安装
4. ✅ MySQL/MariaDB 已安装
5. ✅ 数据库 baozangsearch 已创建
6. ✅ 项目文件已上传
7. ✅ .env 配置已修改（可选）
8. ✅ baozangsearch.sql 数据库文件已上传（可选）
一键部署命令
1. 进入项目目录
cd /www/wwwroot/search-ucmao-master

2. 赋予执行权限
chmod +x install.sh

3. 运行部署脚本
sudo ./install.sh
Windows 系统部署
支持系统
- Windows 7/8/10/11
环境要求
暂时无法在飞书文档外展示此内容
部署前准备
1. 安装 XAMPP 并启动 MySQL
1. 下载并安装 XAMPP：https://www.apachefriends.org/
2. 打开 XAMPP Control Panel
3. 点击 MySQL 的 Start 按钮
4. 确认 MySQL 状态显示为绿色/运行中
2. 创建数据库
打开命令提示符或 XAMPP Shell：
cd C:\xampp\mysql\bin
mysql.exe -u root -p
 
在 MySQL 中执行：
CREATE DATABASE ucmao_search CHARACTER SET utf8mb4;
exit
3. 修改脚本配置
编辑 install-windows.bat，修改以下配置：
set "DB_NAME=ucmao_search"        :: 你的数据库名
set "DB_USER=root"                :: 你的用户名
set "DB_PASSWORD=你的密码"         :: 你的密码（必须修改）
 
XAMPP 路径（如果安装路径不同请修改）：
set "XAMPP_MYSQL_PATH=C:\xampp\mysql\bin"
运行部署脚本
1. 将 install-windows.bat 复制到项目根目录（search-ucmao-master）
2. 双击运行 install-windows.bat
脚本执行流程
3. 1. 显示数据库配置指南
4. 2. 检查数据库配置是否已修改
5. 3. 检查 Python 环境
6. 4. 检查 XAMPP MySQL 是否运行
7. 5. 检查数据库是否已创建
8. 6. 准备项目目录
9. 7. 配置 Python 虚拟环境
10. 8. 创建 .env 配置文件
11. 9. 导入 schema.sql 表结构
12. 10. 创建启动脚本
13. 11. 显示完成信息
部署完成
脚本会显示以下信息：
========================================
  宝藏搜部署完成！
========================================
 
访问地址:
  本机: http://127.0.0.1:5004
  局域网: http://你的计算机名:5004
 
启动方式:
  方式1: 双击 start.bat （显示命令行窗口）
  方式2: 双击 start.vbs （后台运行，无窗口）
 
注意: 请确保 XAMPP MySQL 一直在运行

部署后配置
1. 登录管理后台
地址：http://你的IP:5004/admin
默认账号：admin
默认密码：admin123
2. 配置网盘凭证
进入"系统配置"页面，配置各网盘的 Cookie/Token：
暂时无法在飞书文档外展示此内容
3. 开启公开API（可选）
如需对外提供搜索接口，开启"公开聚合接口"开关。
4. 配置分类（可选）
进入"分类管理"页面，创建资源分类。

常见问题
Linux 问题
Q: 脚本提示 "请使用 root 权限运行此脚本"
A: 使用 sudo 运行脚本：
sudo ./install.sh
 
Q: 脚本提示 "MySQL 服务未运行"
A: 手动启动 MySQL：
sudo systemctl start mysql
 
Q: 脚本提示 "数据库不存在"
A: 先创建数据库：
mysql -u root -p
CREATE DATABASE ucmao_search CHARACTER SET utf8mb4;
exit
 
Q: 服务启动失败
A: 查看日志排查问题：
journalctl -u baozang-search -f
Windows 问题
Q: 脚本提示 "未检测到 Python"
A: 安装 Python 3.8+：
https://www.python.org/downloads/
 
Q: 脚本提示 "未找到 MySQL 命令"
A: 修改脚本中的 XAMPP_MYSQL_PATH：
set "XAMPP_MYSQL_PATH=D:\你的路径\xampp\mysql\bin"
 
Q: 脚本提示 "无法连接到 MySQL"
A: 检查：
1. XAMPP Control Panel 中 MySQL 是否已启动
2. 数据库配置（用户名/密码）是否正确
Q: 如何后台运行服务？
A: 使用 start.vbs 启动，或在命令行中：
cd %USERPROFILE%\baozang-search
venv\Scripts\pythonw.exe app.py

文件说明
暂时无法在飞书文档外展示此内容
注意事项
- 数据库密码必须修改：脚本会检查 DB_PASSWORD 是否为空，为空则退出
- Linux 必须使用 root：脚本需要 root 权限安装系统依赖
- Windows 需要先启动 XAMPP MySQL：脚本会检查 MySQL 是否运行
- 项目文件必须包含 schema.sql：用于初始化数据库表结构
- 部署后修改默认密码：建议立即修改管理员默认密码
每日更新
系统内置定时任务，每 30 分钟自动清理过期临时分享。无需手动操作。

功能与接口
全网搜
宝藏搜支持多网盘聚合搜索，包括：
- 本地资源库搜索
- 第三方 API 搜索（趣盘搜、狗狗盘搜等）
- 外部数据源搜索
微信对话平台
可通过 API 接口对接微信公众号/小程序，实现微信内搜索资源。
前端页面代码
前端采用响应式设计，支持：
- PC 端浏览器访问
- 移动端浏览器访问
- 资源封面展示
- 分类浏览

API 开放接口
资源搜索接口
接口地址：GET /api
请求参数：
暂时无法在飞书文档外展示此内容
返回示例：
{
  "success": true,
  "total": 2,
  "results": [
    {
      "source": "hot",
      "name": "庆余年第二季",
      "share_link": "https://pan.quark.cn/s/xxxx",
      "cloud_name": "夸克网盘"
    }
  ]
}
资源详情接口
接口地址：POST /api/view-link
请求参数：
暂时无法在飞书文档外展示此内容
返回示例：
{
  "success": true,
  "url": "https://pan.quark.cn/s/xxxx",
  "mode": "copy"
}
网盘转存分享接口
接口地址：POST /create_share
请求参数：
暂时无法在飞书文档外展示此内容
返回示例：
{
  "success": true,
  "message": "分享创建成功"
}

网盘配置
夸克网盘
1. 登录夸克网盘网页版 https://pan.quark.cn
2. 按 F12 打开开发者工具
3. 刷新页面，在 Network 中找到第一个请求
4. 复制 Request Headers 中的 Cookie
5. 粘贴到后台"系统配置"中
阿里网盘
1. 登录阿里云盘网页版 https://www.aliyundrive.com
2. 使用开发者工具获取 refresh_token
3. 粘贴到后台"系统配置"中
百度网盘
1. 登录百度网盘网页版 https://pan.baidu.com
2. 按 F12 打开开发者工具
3. 刷新页面，复制 Cookie
4. 粘贴到后台"系统配置"中
UC网盘
1. 登录 UC网盘网页版 https://drive.uc.cn
2. 按 F12 打开开发者工具
3. 刷新页面，复制 Cookie
4. 粘贴到后台"系统配置"中
迅雷云盘
迅雷网盘需要三个参数：
- Refresh Token
- Captcha Sign
- User ID
这三个参数需要同时填写，缺一不可。
需要修改端口教程(搭建部署前修改)默认端口5004

1.修改 Flask 服务端口 app.py
# 原代码
app.run(host='0.0.0.0', port=5004)

# 修改为
app.run(host='0.0.0.0', port=8080)
2. 修改 Linux 脚本端口 install.sh
# 原代码
PORT=5004

# 修改为
PORT=8080
3. 修改 Windows 脚本端口 install-windows.bat
:: 原代码
set "PORT=5004"

:: 修改为
set "PORT=8080"

联系方式
如有问题或建议，欢迎通过以下方式联系：
- 项目地址：<你的仓库地址>
- 问题反馈：请提交 Issue
免责声明
本工具仅供技术交流学习，严禁用于任何非法目的。因使用本工具造成的任何账号封禁或法律风险，均与原作者无关。
宝藏搜 - 让每一份网盘资源都为你创造价值
