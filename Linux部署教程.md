# 宝藏搜 - Linux 系统部署教程

## 一、环境要求

### 1. 系统要求
- **操作系统**: CentOS 7/8, Ubuntu 18.04/20.04, Debian 9/10, Rocky Linux, AlmaLinux
- **内存**: 建议 1GB 以上
- **硬盘**: 建议 10GB 以上可用空间

### 2. 软件要求
- **宝塔面板**（推荐）
- **Python 3.9.7**（通过宝塔 Python 项目管理器安装）
- **MySQL 5.7+** 或 **MariaDB 10.3+**
- **Nginx**

---

## 二、宝塔面板安装（如已安装请跳过）

### 1. 安装宝塔面板

```bash
# CentOS/Rocky/AlmaLinux
yum install -y wget && wget -O install.sh https://download.bt.cn/install/install_6.0.sh && sh install.sh ed8484bec

# Ubuntu/Debian
wget -O install.sh https://download.bt.cn/install/install-ubuntu_6.0.sh && sudo bash install.sh ed8484bec
```

### 2. 登录宝塔面板
- 安装完成后，会显示面板地址、用户名和密码
- 在浏览器中访问：`http://你的服务器IP:8888`
- 使用提供的用户名和密码登录

---

## 三、安装必要软件

### 1. 安装 Python 3.9.7

1. 登录宝塔面板
2. 进入 **软件商店**
3. 搜索 **Python 项目管理器**
4. 点击 **安装**
5. 安装完成后，点击 **设置** → **版本管理**
6. 安装 **Python 3.9.7**

### 2. 安装 Nginx

1. 宝塔面板 → **软件商店**
2. 搜索 **Nginx**
3. 点击 **安装**（推荐安装 1.20+ 版本）

### 3. 安装 MySQL/MariaDB

1. 宝塔面板 → **软件商店**
2. 搜索 **MySQL** 或 **MariaDB**
3. 点击 **安装**（推荐 MySQL 5.7+ 或 MariaDB 10.3+）

---

## 四、创建数据库

### 1. 创建数据库

1. 宝塔面板 → **数据库** → **添加数据库**
2. 填写以下信息：
   - **数据库名**: `baozangsearch`
   - **用户名**: `baozangsearch`
   - **密码**: `baozangsearch`
   - **访问权限**: **本地服务器** 或 **指定IP**
3. 点击 **提交**

### 2. 记录数据库信息

```
数据库名: baozangsearch
用户名: baozangsearch
密码: baozangsearch
主机: 127.0.0.1
端口: 3306
```

---

## 五、上传项目文件

### 1. 上传方式

**方式一：使用宝塔文件管理器**
1. 宝塔面板 → **文件**
2. 进入 `/www/wwwroot/` 目录
3. 点击 **上传** → 选择项目压缩包
4. 解压到 `search-ucmao-master` 目录

**方式二：使用 SCP 命令**
```bash
# 在本地电脑上运行
scp -r search-ucmao-master root@你的服务器IP:/www/wwwroot/
```

**方式三：使用 Git**
```bash
cd /www/wwwroot/
git clone 你的仓库地址 search-ucmao-master
```

### 2. 项目目录结构

上传完成后，项目目录应包含以下文件：
```
/www/wwwroot/search-ucmao-master/
├── app.py                  # Flask 应用入口
├── install.sh              # 一键部署脚本
├── baozangsearch.sql       # 数据库文件（自动导入）
├── .env                    # 配置文件（可选，自定义）
├── requirements.txt        # Python 依赖
├── static/                 # 静态文件
├── templates/              # HTML 模板
└── src/                    # 源代码
```

---

## 六、自定义配置（可选）

### 1. 修改数据库配置

如果需要修改数据库连接信息，编辑 `.env` 文件：

```bash
cd /www/wwwroot/search-ucmao-master
vim .env
```

修改以下内容：
```env
# MYSQL 数据库配置
DB_HOST = 127.0.0.1
DB_PORT = 3306
DB_DATABASE = baozangsearch
DB_USER = baozangsearch
DB_PASSWORD = baozangsearch
DB_CHARSET = utf8mb4

# 管理员账户密码
ADMIN_USERNAME = admin
ADMIN_PASSWORD = admin123
```

### 2. 使用自定义数据库文件

如果需要使用自己的数据库文件：
1. 将数据库文件命名为 `baozangsearch.sql`
2. 上传到项目根目录
3. 脚本会自动导入此文件

---

## 七、运行部署脚本

### 1. 进入项目目录

```bash
cd /www/wwwroot/search-ucmao-master
```

### 2. 赋予脚本执行权限

```bash
chmod +x install.sh
```

### 3. 运行部署脚本

```bash
sudo ./install.sh
```

### 4. 脚本执行流程

脚本会自动完成以下操作：
1. ✅ 检测系统环境
2. ✅ 检查宝塔 Python 3.9.7
3. ✅ 安装系统依赖（git, curl, openssl）
4. ✅ 检查 MySQL 状态
5. ✅ 复制项目文件到 `/opt/baozang-search/`
6. ✅ 创建 Python 虚拟环境
7. ✅ 安装 Python 依赖（Flask, APScheduler 等）
8. ✅ 创建 `.env` 配置文件
9. ✅ 导入数据库（`baozangsearch.sql`）
10. ✅ 创建 Systemd 服务
11. ✅ 配置 Nginx 反向代理
12. ✅ 配置防火墙规则
13. ✅ 启动服务

### 5. 确认部署

脚本会提示：
```
项目文件是否已准备好? (y/n):
```
输入 `y` 确认继续。

---

## 八、部署完成

### 1. 访问网站

部署完成后，会显示以下信息：

```
========================================
  宝藏搜部署完成！
========================================

访问地址:
  本机: http://127.0.0.1:5004
  外网: http://你的服务器IP

管理员账号:
  用户名: admin
  密码: admin123

管理后台:
  http://你的服务器IP/admin
```

### 2. 前台页面
- **地址**: `http://你的服务器IP`
- **功能**: 搜索网盘资源

### 3. 管理后台
- **地址**: `http://你的服务器IP/admin`
- **账号**: `admin`
- **密码**: `admin123`（可在 `.env` 中修改）

---

## 九、常用命令

### 服务管理

```bash
# 启动服务
systemctl start baozang-search

# 停止服务
systemctl stop baozang-search

# 重启服务
systemctl restart baozang-search

# 查看状态
systemctl status baozang-search

# 查看日志
journalctl -u baozang-search -f
```

### 项目目录

```bash
# 进入项目目录
cd /opt/baozang-search/search-ucmao-master

# 激活虚拟环境
source venv/bin/activate

# 手动运行（调试用）
python app.py
```

---

## 十、常见问题

### 1. 服务启动失败

**问题**: `ModuleNotFoundError: No module named 'flask'`

**解决**:
```bash
cd /opt/baozang-search/search-ucmao-master
source venv/bin/activate
pip install Flask==3.0.3
systemctl restart baozang-search
```

### 2. 数据库连接失败

**问题**: `Access denied for user 'baozangsearch'@'localhost'`

**解决**:
1. 检查宝塔面板中数据库用户密码是否正确
2. 检查 `.env` 文件中的数据库配置
3. 确保 MySQL 服务正在运行：`systemctl status mysql`

### 3. 端口被占用

**问题**: `Address already in use`

**解决**:
```bash
# 查看占用 5004 端口的进程
lsof -i :5004

# 杀死进程
kill -9 PID

# 重启服务
systemctl restart baozang-search
```

### 4. Nginx 配置冲突

**问题**: `conflicting server name "_" on 0.0.0.0:80`

**解决**:
```bash
# 检查 Nginx 配置
nginx -t

# 编辑配置文件
vim /www/server/panel/vhost/nginx/baozang-search.conf

# 重启 Nginx
/etc/init.d/nginx restart
```

### 5. 防火墙阻止访问

**解决**:
```bash
# 开放 80 端口
firewall-cmd --permanent --add-service=http

# 开放 5004 端口
firewall-cmd --permanent --add-port=5004/tcp

# 重载防火墙
firewall-cmd --reload
```

---

## 十一、更新项目

### 1. 备份数据

```bash
# 备份数据库
mysqldump -u baozangsearch -pbaozangsearch baozangsearch > backup_$(date +%Y%m%d).sql

# 备份项目
cp -r /opt/baozang-search/search-ucmao-master /opt/baozang-search/backup_$(date +%Y%m%d)
```

### 2. 上传新版本

```bash
# 停止服务
systemctl stop baozang-search

# 进入项目目录
cd /www/wwwroot/search-ucmao-master

# 上传新文件（覆盖旧文件）

# 重新运行脚本
sudo ./install.sh
```

---

## 十二、卸载项目

```bash
# 停止服务
systemctl stop baozang-search

# 禁用服务
systemctl disable baozang-search

# 删除服务文件
rm /etc/systemd/system/baozang-search.service

# 删除 Nginx 配置
rm /www/server/panel/vhost/nginx/baozang-search.conf

# 删除项目目录
rm -rf /opt/baozang-search

# 重载 systemd
systemctl daemon-reload

# 重启 Nginx
/etc/init.d/nginx restart
```

---

## 十三、联系支持

如有问题，请查看：
- 项目日志：`journalctl -u baozang-search -f`
- Nginx 日志：`/www/server/nginx/logs/`
- 项目目录：`/opt/baozang-search/search-ucmao-master/`

---

**部署完成！开始使用宝藏搜吧！** 🎉
