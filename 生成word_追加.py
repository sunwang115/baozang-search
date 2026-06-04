from docx import Document
from docx.shared import Pt, RGBColor, Inches
from docx.enum.text import WD_ALIGN_PARAGRAPH

# 打开现有文档
doc = Document('宝藏搜-搭建教程.docx')

# 添加分页符
doc.add_page_break()

# 添加新章节标题
title = doc.add_heading('一键部署教程', 1)
title.alignment = WD_ALIGN_PARAGRAPH.CENTER

subtitle = doc.add_paragraph('使用一键脚本快速部署宝藏搜系统')
subtitle.alignment = WD_ALIGN_PARAGRAPH.CENTER
subtitle.runs[0].font.color.rgb = RGBColor(128, 128, 128)

doc.add_paragraph()

# 目录
doc.add_heading('目录', 2)
toc_items = [
    'Linux 系统部署',
    'Windows 系统部署',
    '部署后配置',
    '常见问题'
]
for item in toc_items:
    doc.add_paragraph(item, style='List Bullet')

doc.add_page_break()

# Linux 系统部署
doc.add_heading('Linux 系统部署', 1)

doc.add_heading('支持系统', 2)
systems = ['Ubuntu 18.04+', 'Debian 9+', 'CentOS 7+', 'Rocky Linux 8+', 'AlmaLinux 8+']
for sys in systems:
    doc.add_paragraph(sys, style='List Bullet')

doc.add_heading('环境要求', 2)
table = doc.add_table(rows=4, cols=2)
table.style = 'Light Grid Accent 1'
data = [
    ['项目', '要求'],
    ['Python', '3.8+'],
    ['MySQL', '5.7 或 8.0+'],
    ['内存', '建议 2GB+']
]
for i, (k, v) in enumerate(data):
    table.rows[i].cells[0].text = k
    table.rows[i].cells[1].text = v

doc.add_heading('部署前准备', 2)

doc.add_heading('1. 安装 MySQL 并创建数据库', 3)
doc.add_paragraph('安装 MySQL（如果未安装）：')
doc.add_paragraph('Ubuntu/Debian:')
doc.add_paragraph('sudo apt-get update')
doc.add_paragraph('sudo apt-get install -y mysql-server')
doc.add_paragraph()
doc.add_paragraph('CentOS/Rocky/AlmaLinux:')
doc.add_paragraph('sudo yum install -y mysql-server')
doc.add_paragraph('sudo systemctl start mysqld')
doc.add_paragraph()
doc.add_paragraph('启动 MySQL:')
doc.add_paragraph('sudo systemctl start mysql')
doc.add_paragraph('sudo systemctl enable mysql')
doc.add_paragraph()
doc.add_paragraph('登录 MySQL 创建数据库:')
doc.add_paragraph('mysql -u root -p')
doc.add_paragraph()
doc.add_paragraph('在 MySQL 中执行：')
doc.add_paragraph('CREATE DATABASE ucmao_search CHARACTER SET utf8mb4;')
doc.add_paragraph('exit')

doc.add_heading('2. 上传项目文件', 3)
doc.add_paragraph('使用 scp 上传项目到服务器：')
doc.add_paragraph('scp -r search-ucmao-master root@你的服务器IP:/opt/baozang-search/')

doc.add_heading('3. 修改脚本配置', 3)
doc.add_paragraph('编辑 install.sh，修改数据库配置：')
doc.add_paragraph('DB_NAME="ucmao_search"        # 你的数据库名')
doc.add_paragraph('DB_USER="root"                # 你的用户名')
doc.add_paragraph('DB_PASSWORD="你的密码"         # 你的密码（必须修改）')

doc.add_heading('运行部署脚本', 2)
doc.add_paragraph('进入项目目录：')
doc.add_paragraph('cd /opt/baozang-search/search-ucmao-master')
doc.add_paragraph()
doc.add_paragraph('赋予执行权限：')
doc.add_paragraph('chmod +x install.sh')
doc.add_paragraph()
doc.add_paragraph('运行脚本（必须使用 root 权限）：')
doc.add_paragraph('sudo ./install.sh')

doc.add_heading('脚本执行流程', 2)
steps = [
    '显示数据库配置指南',
    '检查数据库配置是否已修改',
    '检查 root 权限',
    '检测系统类型',
    '安装系统依赖（Python3、Nginx等）',
    '检查 MySQL 状态',
    '准备项目目录',
    '[暂停] 确认项目文件已上传',
    '配置 Python 虚拟环境',
    '创建 .env 配置文件',
    '导入 schema.sql 表结构',
    '创建 Systemd 服务',
    '配置 Nginx',
    '配置防火墙',
    '启动服务',
    '显示完成信息'
]
for i, step in enumerate(steps, 1):
    doc.add_paragraph(f'{i}. {step}', style='List Number')

doc.add_heading('部署完成', 2)
doc.add_paragraph('脚本会显示以下信息：')
doc.add_paragraph('========================================')
doc.add_paragraph('  宝藏搜部署完成！')
doc.add_paragraph('========================================')
doc.add_paragraph()
doc.add_paragraph('访问地址:')
doc.add_paragraph('  本机: http://127.0.0.1:5004')
doc.add_paragraph('  外网: http://你的服务器IP')
doc.add_paragraph()
doc.add_paragraph('管理员账号:')
doc.add_paragraph('  用户名: admin')
doc.add_paragraph('  密码: admin123')
doc.add_paragraph()
doc.add_paragraph('常用命令:')
doc.add_paragraph('  启动: systemctl start baozang-search')
doc.add_paragraph('  停止: systemctl stop baozang-search')
doc.add_paragraph('  重启: systemctl restart baozang-search')
doc.add_paragraph('  状态: systemctl status baozang-search')
doc.add_paragraph('  日志: journalctl -u baozang-search -f')

doc.add_page_break()

# Windows 系统部署
doc.add_heading('Windows 系统部署', 1)

doc.add_heading('支持系统', 2)
doc.add_paragraph('Windows 7/8/10/11', style='List Bullet')

doc.add_heading('环境要求', 2)
table2 = doc.add_table(rows=4, cols=2)
table2.style = 'Light Grid Accent 1'
data2 = [
    ['项目', '要求'],
    ['Python', '3.8+'],
    ['MySQL', 'XAMPP MySQL'],
    ['内存', '建议 2GB+']
]
for i, (k, v) in enumerate(data2):
    table2.rows[i].cells[0].text = k
    table2.rows[i].cells[1].text = v

doc.add_heading('部署前准备', 2)

doc.add_heading('1. 安装 XAMPP 并启动 MySQL', 3)
doc.add_paragraph('1. 下载并安装 XAMPP：https://www.apachefriends.org/')
doc.add_paragraph('2. 打开 XAMPP Control Panel')
doc.add_paragraph('3. 点击 MySQL 的 Start 按钮')
doc.add_paragraph('4. 确认 MySQL 状态显示为绿色/运行中')

doc.add_heading('2. 创建数据库', 3)
doc.add_paragraph('打开命令提示符或 XAMPP Shell：')
doc.add_paragraph(r'cd C:\xampp\mysql\bin')
doc.add_paragraph('mysql.exe -u root -p')
doc.add_paragraph()
doc.add_paragraph('在 MySQL 中执行：')
doc.add_paragraph('CREATE DATABASE ucmao_search CHARACTER SET utf8mb4;')
doc.add_paragraph('exit')

doc.add_heading('3. 修改脚本配置', 3)
doc.add_paragraph('编辑 install-windows.bat，修改以下配置：')
doc.add_paragraph('set "DB_NAME=ucmao_search"        :: 你的数据库名')
doc.add_paragraph('set "DB_USER=root"                :: 你的用户名')
doc.add_paragraph('set "DB_PASSWORD=你的密码"         :: 你的密码（必须修改）')
doc.add_paragraph()
doc.add_paragraph('XAMPP 路径（如果安装路径不同请修改）：')
doc.add_paragraph(r'set "XAMPP_MYSQL_PATH=C:\xampp\mysql\bin"')

doc.add_heading('运行部署脚本', 2)
doc.add_paragraph('1. 将 install-windows.bat 复制到项目根目录（search-ucmao-master）')
doc.add_paragraph('2. 双击运行 install-windows.bat')

doc.add_heading('脚本执行流程', 2)
steps_win = [
    '显示数据库配置指南',
    '检查数据库配置是否已修改',
    '检查 Python 环境',
    '检查 XAMPP MySQL 是否运行',
    '检查数据库是否已创建',
    '准备项目目录',
    '配置 Python 虚拟环境',
    '创建 .env 配置文件',
    '导入 schema.sql 表结构',
    '创建启动脚本',
    '显示完成信息'
]
for i, step in enumerate(steps_win, 1):
    doc.add_paragraph(f'{i}. {step}', style='List Number')

doc.add_heading('部署完成', 2)
doc.add_paragraph('脚本会显示以下信息：')
doc.add_paragraph('========================================')
doc.add_paragraph('  宝藏搜部署完成！')
doc.add_paragraph('========================================')
doc.add_paragraph()
doc.add_paragraph('访问地址:')
doc.add_paragraph('  本机: http://127.0.0.1:5004')
doc.add_paragraph('  局域网: http://你的计算机名:5004')
doc.add_paragraph()
doc.add_paragraph('启动方式:')
doc.add_paragraph('  方式1: 双击 start.bat （显示命令行窗口）')
doc.add_paragraph('  方式2: 双击 start.vbs （后台运行，无窗口）')
doc.add_paragraph()
doc.add_paragraph('注意: 请确保 XAMPP MySQL 一直在运行')

doc.add_page_break()

# 部署后配置
doc.add_heading('部署后配置', 1)

doc.add_heading('1. 登录管理后台', 2)
doc.add_paragraph('地址：http://你的IP:5004/admin')
doc.add_paragraph('默认账号：admin')
doc.add_paragraph('默认密码：admin123')

doc.add_heading('2. 配置网盘凭证', 2)
doc.add_paragraph('进入"系统配置"页面，配置各网盘的 Cookie/Token：')

table3 = doc.add_table(rows=6, cols=2)
table3.style = 'Light Grid Accent 1'
data3 = [
    ['网盘', '配置项'],
    ['夸克网盘', 'Cookie'],
    ['百度网盘', 'Cookie'],
    ['阿里云盘', 'Refresh Token'],
    ['UC网盘', 'Cookie'],
    ['迅雷云盘', 'Refresh Token + Captcha Sign + User ID']
]
for i, (k, v) in enumerate(data3):
    table3.rows[i].cells[0].text = k
    table3.rows[i].cells[1].text = v

doc.add_heading('3. 开启公开API（可选）', 2)
doc.add_paragraph('如需对外提供搜索接口，开启"公开聚合接口"开关。')

doc.add_heading('4. 配置分类（可选）', 2)
doc.add_paragraph('进入"分类管理"页面，创建资源分类。')

doc.add_page_break()

# 常见问题
doc.add_heading('常见问题', 1)

doc.add_heading('Linux 问题', 2)

doc.add_paragraph('Q: 脚本提示 "请使用 root 权限运行此脚本"')
doc.add_paragraph('A: 使用 sudo 运行脚本：')
doc.add_paragraph('sudo ./install.sh')
doc.add_paragraph()

doc.add_paragraph('Q: 脚本提示 "MySQL 服务未运行"')
doc.add_paragraph('A: 手动启动 MySQL：')
doc.add_paragraph('sudo systemctl start mysql')
doc.add_paragraph()

doc.add_paragraph('Q: 脚本提示 "数据库不存在"')
doc.add_paragraph('A: 先创建数据库：')
doc.add_paragraph('mysql -u root -p')
doc.add_paragraph('CREATE DATABASE ucmao_search CHARACTER SET utf8mb4;')
doc.add_paragraph('exit')
doc.add_paragraph()

doc.add_paragraph('Q: 服务启动失败')
doc.add_paragraph('A: 查看日志排查问题：')
doc.add_paragraph('journalctl -u baozang-search -f')

doc.add_heading('Windows 问题', 2)

doc.add_paragraph('Q: 脚本提示 "未检测到 Python"')
doc.add_paragraph('A: 安装 Python 3.8+：')
doc.add_paragraph('https://www.python.org/downloads/')
doc.add_paragraph()

doc.add_paragraph('Q: 脚本提示 "未找到 MySQL 命令"')
doc.add_paragraph('A: 修改脚本中的 XAMPP_MYSQL_PATH：')
doc.add_paragraph(r'set "XAMPP_MYSQL_PATH=D:\你的路径\xampp\mysql\bin"')
doc.add_paragraph()

doc.add_paragraph('Q: 脚本提示 "无法连接到 MySQL"')
doc.add_paragraph('A: 检查：')
doc.add_paragraph('1. XAMPP Control Panel 中 MySQL 是否已启动')
doc.add_paragraph('2. 数据库配置（用户名/密码）是否正确')
doc.add_paragraph()

doc.add_paragraph('Q: 如何后台运行服务？')
doc.add_paragraph('A: 使用 start.vbs 启动，或在命令行中：')
doc.add_paragraph(r'cd %USERPROFILE%\baozang-search')
doc.add_paragraph(r'venv\Scripts\pythonw.exe app.py')

doc.add_page_break()

# 文件说明
doc.add_heading('文件说明', 1)

table4 = doc.add_table(rows=6, cols=2)
table4.style = 'Light Grid Accent 1'
data4 = [
    ['文件', '说明'],
    ['install.sh', 'Linux 一键部署脚本'],
    ['install-windows.bat', 'Windows 一键部署脚本'],
    ['schema.sql', '数据库表结构文件'],
    ['requirements.txt', 'Python 依赖列表'],
    ['.env.example', '环境变量配置示例']
]
for i, (k, v) in enumerate(data4):
    table4.rows[i].cells[0].text = k
    table4.rows[i].cells[1].text = v

doc.add_heading('注意事项', 1)
notes = [
    '数据库密码必须修改：脚本会检查 DB_PASSWORD 是否为空，为空则退出',
    'Linux 必须使用 root：脚本需要 root 权限安装系统依赖',
    'Windows 需要先启动 XAMPP MySQL：脚本会检查 MySQL 是否运行',
    '项目文件必须包含 schema.sql：用于初始化数据库表结构',
    '部署后修改默认密码：建议立即修改管理员默认密码'
]
for note in notes:
    doc.add_paragraph(note, style='List Bullet')

# 保存文档
import time
time.sleep(2)
doc.save('宝藏搜-搭建教程-完整版.docx')
print('Word文档已更新：宝藏搜-搭建教程.docx')
