#!/bin/bash
# =============================================================================
# 宝藏搜 - Linux 一键部署脚本 (适配宝塔 Python 3.9.7)
# 支持: Ubuntu / Debian / CentOS / Rocky / AlmaLinux
# =============================================================================

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 配置变量
INSTALL_DIR="/opt/baozang-search"
SERVICE_NAME="baozang-search"
PORT=5004
DB_NAME="baozangsearch"
DB_USER="baozangsearch"
DB_PASSWORD="baozangsearch"
ADMIN_USER="admin"
ADMIN_PASS="admin123"
SECRET_KEY="$(openssl rand -hex 32)"

# 命令行参数解析
CHANGE_PASSWORD_MODE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --change-password)
            CHANGE_PASSWORD_MODE=true
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# Python 配置 - 宝塔 Python 3.9.7
PYTHON_CMD="python3.9"
PIP_CMD="pip3.9"
PYTHON_VERSION="3.9.7"

# 日志函数
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_ok() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# 检查root权限
check_root() {
    if [ "$EUID" -ne 0 ]; then
        log_error "请使用 root 权限运行此脚本"
        exit 1
    fi
}

# 检测系统类型
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        VERSION=$VERSION_ID
    else
        log_error "无法检测操作系统类型"
        exit 1
    fi
    log_info "检测到系统: $OS $VERSION"
}

# 检查宝塔 Python 3.9 是否安装
check_bt_python() {
    log_info "检查宝塔 Python ${PYTHON_VERSION}..."
    
    # 检查宝塔安装的 Python 3.9
    if [ -f "/www/server/python_manager/versions/3.9.7/bin/python3.9" ]; then
        PYTHON_CMD="/www/server/python_manager/versions/3.9.7/bin/python3.9"
        PIP_CMD="/www/server/python_manager/versions/3.9.7/bin/pip3.9"
        log_ok "检测到宝塔 Python 3.9.7"
        return 0
    elif command -v python3.9 &> /dev/null; then
        PYTHON_CMD="python3.9"
        PIP_CMD="pip3.9"
        log_ok "检测到系统 Python 3.9"
        return 0
    else
        log_error "未检测到 Python 3.9，请先安装:"
        log_error "1. 宝塔面板 -> 软件商店 -> Python项目管理器"
        log_error "2. 安装 Python 3.9.7"
        exit 1
    fi
}

# 安装依赖
install_dependencies() {
    log_info "正在安装系统依赖..."

    # 检查nginx是否已安装（如宝塔已安装）
    if command -v nginx &> /dev/null; then
        log_ok "检测到 Nginx 已安装，跳过安装"
        SKIP_NGINX=true
    else
        SKIP_NGINX=false
    fi

    # 检查mysql是否已安装（如宝塔已安装）
    if command -v mysql &> /dev/null || command -v mariadb &> /dev/null; then
        log_ok "检测到 MySQL/MariaDB 已安装，跳过安装"
        SKIP_MYSQL=true
    else
        SKIP_MYSQL=false
    fi

    case $OS in
        ubuntu|debian)
            apt-get update -qq
            PACKAGES="git curl openssl"
            if [ "$SKIP_NGINX" = false ]; then
                PACKAGES="$PACKAGES nginx"
            fi
            if [ "$SKIP_MYSQL" = false ]; then
                PACKAGES="$PACKAGES mysql-server"
            fi
            apt-get install -y -qq $PACKAGES
            ;;
        centos|rhel|rocky|almalinux|fedora|alinux)
            PACKAGES="git curl openssl"
            if [ "$SKIP_NGINX" = false ]; then
                PACKAGES="$PACKAGES nginx"
            fi
            if [ "$SKIP_MYSQL" = false ]; then
                PACKAGES="$PACKAGES mysql-server"
            fi
            if command -v dnf &> /dev/null; then
                dnf install -y $PACKAGES
            else
                yum install -y $PACKAGES
            fi
            ;;
        *)
            log_error "不支持的操作系统: $OS"
            exit 1
            ;;
    esac

    log_ok "系统依赖安装完成"
}

# 检查MySQL状态
check_mysql() {
    log_info "检查 MySQL 状态..."

    # 检查MySQL是否运行
    if systemctl is-active --quiet mysql || systemctl is-active --quiet mysqld; then
        log_ok "MySQL 服务正在运行"
    else
        log_warn "MySQL 服务未运行，请手动启动:"
        log_warn "  systemctl start mysql"
        log_warn "  或"
        log_warn "  systemctl start mysqld"
        exit 1
    fi

    # 检查数据库是否存在（使用配置的用户名密码）
    if mysql -u "${DB_USER}" -p"${DB_PASSWORD}" -e "USE \`${DB_NAME}\`;" 2>/dev/null; then
        log_ok "数据库 ${DB_NAME} 已存在"
    else
        log_warn "数据库 ${DB_NAME} 不存在或连接失败，请检查:"
        log_warn "1. 宝塔面板中是否已创建数据库 ${DB_NAME}"
        log_warn "2. 用户名 ${DB_USER} 和密码是否正确"
        log_warn "3. MySQL 服务是否正常运行"
        log_warn ""
        log_warn "宝塔面板创建数据库步骤:"
        log_warn "  数据库 -> 添加数据库 -> 数据库名: baozangsearch -> 用户名: baozangsearch -> 密码: baozangsearch"
        exit 1
    fi
}

# 下载项目代码
download_project() {
    log_info "正在准备项目文件..."

    # 检测当前是否在项目目录中运行（支持 schema.sql 或 baozangsearch.sql 或 数据库文件.sql）
    if [ -f "app.py" ] && ([ -f "schema.sql" ] || [ -f "baozangsearch.sql" ] || [ -f "数据库文件.sql" ]); then
        log_info "检测到在当前项目目录中运行脚本"
        log_info "将自动复制当前目录到安装路径..."

        # 创建安装目录
        mkdir -p $INSTALL_DIR

        # 如果目标目录已存在，先备份
        if [ -d "$INSTALL_DIR/search-ucmao-master" ]; then
            BACKUP_DIR="backup_$(date +%Y%m%d_%H%M%S)"
            log_warn "发现已有项目，备份到 $BACKUP_DIR"
            mv "$INSTALL_DIR/search-ucmao-master" "$INSTALL_DIR/$BACKUP_DIR"
        fi

        # 复制当前目录到安装路径
        cp -r "$(pwd)" "$INSTALL_DIR/search-ucmao-master"
        log_ok "项目文件已复制到 $INSTALL_DIR/search-ucmao-master/"
        return
    fi

    # 创建安装目录
    mkdir -p $INSTALL_DIR
    cd $INSTALL_DIR

    # 如果目录已存在，先备份
    if [ -d "search-ucmao-master" ]; then
        BACKUP_DIR="backup_$(date +%Y%m%d_%H%M%S)"
        log_warn "发现已有项目，备份到 $BACKUP_DIR"
        mv search-ucmao-master $BACKUP_DIR
    fi

    log_info "请将项目文件上传到 $INSTALL_DIR/search-ucmao-master/"
    log_info "或者使用 git clone 下载"

    # 创建项目目录结构
    mkdir -p search-ucmao-master

    log_ok "项目目录准备完成"
}

# 配置Python环境
setup_python_env() {
    log_info "正在配置 Python ${PYTHON_VERSION} 虚拟环境..."

    cd $INSTALL_DIR/search-ucmao-master

    # 删除旧的虚拟环境（如果存在）
    if [ -d "venv" ]; then
        log_warn "发现旧的虚拟环境，删除重建..."
        rm -rf venv
    fi

    # 使用宝塔 Python 3.9 创建虚拟环境
    $PYTHON_CMD -m venv venv
    
    # 检查虚拟环境是否创建成功
    if [ ! -f "venv/bin/python" ]; then
        log_error "虚拟环境创建失败，请检查 Python 3.9 是否正常工作"
        exit 1
    fi
    
    # 激活虚拟环境
    source venv/bin/activate

    # 检查虚拟环境是否激活成功
    if ! which python | grep -q "venv"; then
        log_error "虚拟环境激活失败"
        exit 1
    fi

    # 升级pip（使用虚拟环境中的pip）
    pip install --upgrade pip

    # 安装依赖（使用 Python 3.9 兼容版本）
    log_info "正在安装 Python 依赖..."
    
    # 安装 requirements.txt 中的依赖
    if [ -f "requirements.txt" ]; then
        log_info "发现 requirements.txt，安装项目依赖..."
        pip install -r requirements.txt || {
            log_warn "部分依赖安装失败，尝试安装兼容版本..."
            pip install Flask==3.0.3 APScheduler==3.10.4 jmespath==1.0.1 PyMySQL==1.1.2 PyJWT==2.10.1 python-dotenv==1.0.1 requests==2.32.3
        }
    else
        log_warn "未找到 requirements.txt，安装默认依赖..."
        pip install Flask==3.0.3 APScheduler==3.10.4 jmespath==1.0.1 PyMySQL==1.1.2 PyJWT==2.10.1 python-dotenv==1.0.1 requests==2.32.3
    fi

    # 验证 Flask 是否安装成功
    if python -c "import flask" 2>/dev/null; then
        log_ok "Flask 安装成功"
    else
        log_error "Flask 安装失败，请检查错误信息"
        exit 1
    fi

    log_ok "Python 环境配置完成"
}

# 修改管理员账号密码
change_admin_password() {
    log_info "正在修改管理员账号密码..."
    
    cd $INSTALL_DIR/search-ucmao-master
    
    # 检查虚拟环境是否存在
    if [ ! -f "venv/bin/python" ]; then
        log_error "虚拟环境不存在，请先运行完整部署"
        exit 1
    fi
    
    # 读取当前配置
    if [ -f ".env" ]; then
        CURRENT_ADMIN=$(grep -E "^ADMIN_USERNAME\s*=" .env | sed 's/.*=\s*//' | tr -d ' ')
        CURRENT_PASS=$(grep -E "^ADMIN_PASSWORD\s*=" .env | sed 's/.*=\s*//' | tr -d ' ')
        log_info "当前管理员账号: ${CURRENT_ADMIN}"
    else
        log_error "配置文件不存在，请先运行完整部署"
        exit 1
    fi
    
    echo ""
    read -p "请输入新管理员账号 [默认: ${CURRENT_ADMIN}]: " NEW_ADMIN
    NEW_ADMIN=${NEW_ADMIN:-$CURRENT_ADMIN}
    
    read -p "请输入新管理员密码: " NEW_PASS
    while [ -z "$NEW_PASS" ]; do
        log_error "密码不能为空"
        read -p "请输入新管理员密码: " NEW_PASS
    done
    
    # 更新 .env 文件
    sed -i "s/^ADMIN_USERNAME\s*=.*/ADMIN_USERNAME = ${NEW_ADMIN}/" .env
    sed -i "s/^ADMIN_PASSWORD\s*=.*/ADMIN_PASSWORD = ${NEW_PASS}/" .env
    
    log_ok "管理员账号密码已更新"
    log_info "新账号: ${NEW_ADMIN}"
    log_info "新密码: ${NEW_PASS}"
    
    # 重启服务使配置生效
    log_info "正在重启服务..."
    systemctl restart ${SERVICE_NAME}
    
    if systemctl is-active --quiet ${SERVICE_NAME}; then
        log_ok "服务重启成功！"
    else
        log_error "服务重启失败，请检查: journalctl -u ${SERVICE_NAME} -f"
    fi
}

# 创建配置文件
create_config() {
    log_info "正在检查配置文件..."

    cd $INSTALL_DIR/search-ucmao-master

    # 检查用户是否已上传 .env 文件
    if [ -f ".env" ]; then
        log_info "发现用户上传的 .env 配置文件"
        log_info "配置文件内容:"
        cat .env | grep -E "^(DB_|ADMIN_)" | sed 's/^/  /'

        # 读取用户 .env 中的数据库配置
        ENV_DB_NAME=$(grep -E "^DB_DATABASE\s*=" .env | sed 's/.*=\s*//' | tr -d ' ')
        ENV_DB_USER=$(grep -E "^DB_USER\s*=" .env | sed 's/.*=\s*//' | tr -d ' ')
        ENV_DB_PASS=$(grep -E "^DB_PASSWORD\s*=" .env | sed 's/.*=\s*//' | tr -d ' ')

        if [ -n "$ENV_DB_NAME" ] && [ -n "$ENV_DB_USER" ]; then
            log_info "检测到用户自定义数据库配置: ${ENV_DB_NAME} / ${ENV_DB_USER}"
            log_warn "请确保宝塔面板中已创建对应的数据库和用户"

            # 测试用户配置的数据库连接
            if mysql -u "${ENV_DB_USER}" -p"${ENV_DB_PASS}" -e "USE \`${ENV_DB_NAME}\`;" 2>/dev/null; then
                log_ok "用户配置的数据库连接成功"
            else
                log_error "用户配置的数据库连接失败！"
                log_error "请检查 .env 文件中的数据库配置是否正确"
                log_error "或删除 .env 文件让脚本创建默认配置"
                exit 1
            fi
        else
            log_warn "用户 .env 中数据库配置不完整，使用脚本默认配置覆盖..."
            # 备份原 .env
            cp .env .env.backup.$(date +%Y%m%d_%H%M%S)
            # 更新数据库配置
            sed -i "s/^DB_DATABASE\s*=.*/DB_DATABASE = ${DB_NAME}/" .env
            sed -i "s/^DB_USER\s*=.*/DB_USER = ${DB_USER}/" .env
            sed -i "s/^DB_PASSWORD\s*=.*/DB_PASSWORD = ${DB_PASSWORD}/" .env
            log_ok "已更新 .env 数据库配置为脚本默认值"
        fi
    else
        log_info "未找到 .env 文件，创建默认配置..."
        cat > .env << EOF
# ==============================================================================
# .env 配置文件
# ==============================================================================

# 安全密钥
SECRET_KEY = ${SECRET_KEY}

# MYSQL 数据库配置
DB_HOST = 127.0.0.1
DB_PORT = 3306
DB_DATABASE = ${DB_NAME}
DB_USER = ${DB_USER}
DB_PASSWORD = ${DB_PASSWORD}
DB_CHARSET = utf8mb4

# 管理员账户密码
ADMIN_USERNAME = ${ADMIN_USER}
ADMIN_PASSWORD = ${ADMIN_PASS}
EOF
        log_ok "默认配置文件创建完成"
    fi

    log_info "管理员账号: $ADMIN_USER"
    log_info "管理员密码: $ADMIN_PASS"
}

# 初始化数据库
init_database() {
    log_info "正在初始化数据库..."

    cd $INSTALL_DIR/search-ucmao-master

    # 优先从 .env 读取数据库配置
    if [ -f ".env" ]; then
        ENV_DB_NAME=$(grep -E "^DB_DATABASE\s*=" .env | sed 's/.*=\s*//' | tr -d ' ')
        ENV_DB_USER=$(grep -E "^DB_USER\s*=" .env | sed 's/.*=\s*//' | tr -d ' ')
        ENV_DB_PASS=$(grep -E "^DB_PASSWORD\s*=" .env | sed 's/.*=\s*//' | tr -d ' ')

        if [ -n "$ENV_DB_NAME" ] && [ -n "$ENV_DB_USER" ]; then
            log_info "从 .env 读取数据库配置: ${ENV_DB_NAME} / ${ENV_DB_USER}"
            IMPORT_DB_NAME="$ENV_DB_NAME"
            IMPORT_DB_USER="$ENV_DB_USER"
            IMPORT_DB_PASS="$ENV_DB_PASS"
        else
            log_warn ".env 配置不完整，使用默认配置"
            IMPORT_DB_NAME="${DB_NAME}"
            IMPORT_DB_USER="${DB_USER}"
            IMPORT_DB_PASS="${DB_PASSWORD}"
        fi
    else
        log_info "未找到 .env，使用默认数据库配置"
        IMPORT_DB_NAME="${DB_NAME}"
        IMPORT_DB_USER="${DB_USER}"
        IMPORT_DB_PASS="${DB_PASSWORD}"
    fi

    # 检查是否有数据库文件
    SQL_FILE=""
    if [ -f "baozangsearch.sql" ]; then
        SQL_FILE="baozangsearch.sql"
        log_info "发现数据库文件: baozangsearch.sql"
    elif [ -f "数据库文件.sql" ]; then
        SQL_FILE="数据库文件.sql"
        log_info "发现数据库文件: 数据库文件.sql"
    elif [ -f "schema.sql" ]; then
        SQL_FILE="schema.sql"
        log_info "发现数据库文件: schema.sql"
    fi

    if [ -n "$SQL_FILE" ]; then
        log_info "正在导入数据库文件到 ${IMPORT_DB_NAME}: $SQL_FILE"
        if mysql -u "${IMPORT_DB_USER}" -p"${IMPORT_DB_PASS}" "${IMPORT_DB_NAME}" < "$SQL_FILE"; then
            log_ok "数据库导入完成"
        else
            log_error "数据库导入失败！请检查:"
            log_error "  1. 数据库 ${IMPORT_DB_NAME} 是否存在"
            log_error "  2. 用户 ${IMPORT_DB_USER} 是否有权限"
            log_error "  3. SQL 文件是否正确"
            exit 1
        fi
    else
        log_warn "未找到数据库文件，请手动导入:"
        log_warn "  1. 上传你的数据库文件（如: baozangsearch.sql）到项目目录"
        log_warn "  2. 或上传 数据库文件.sql 到项目目录"
        log_warn "  3. 然后运行: mysql -u ${IMPORT_DB_USER} -p${IMPORT_DB_PASS} ${IMPORT_DB_NAME} < 你的数据库文件.sql"
    fi
}

# 创建Systemd服务
create_systemd_service() {
    log_info "正在创建系统服务..."

    cat > /etc/systemd/system/${SERVICE_NAME}.service << EOF
[Unit]
Description=BaoZang Search Service
After=network.target mysql.service

[Service]
Type=simple
User=root
WorkingDirectory=${INSTALL_DIR}/search-ucmao-master
Environment="PATH=${INSTALL_DIR}/search-ucmao-master/venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin"
Environment="PYTHONPATH=${INSTALL_DIR}/search-ucmao-master"
ExecStart=${INSTALL_DIR}/search-ucmao-master/venv/bin/python ${INSTALL_DIR}/search-ucmao-master/app.py
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
    systemctl enable ${SERVICE_NAME}

    log_ok "系统服务创建完成"
}

# 配置Nginx
setup_nginx() {
    log_info "正在配置 Nginx..."

    # 确保 Nginx 配置目录存在
    if [ ! -d "/etc/nginx/conf.d" ]; then
        log_warn "/etc/nginx/conf.d 目录不存在，尝试创建..."
        mkdir -p /etc/nginx/conf.d
    fi

    # 检测宝塔环境的 Nginx 配置路径
    if [ -d "/www/server/panel/vhost/nginx" ]; then
        log_info "检测到宝塔环境，使用宝塔 Nginx 配置目录"
        NGINX_CONF_DIR="/www/server/panel/vhost/nginx"
    else
        NGINX_CONF_DIR="/etc/nginx/conf.d"
    fi

    cat > ${NGINX_CONF_DIR}/${SERVICE_NAME}.conf << EOF
server {
    listen 80;
    server_name _;

    client_max_body_size 50M;

    location / {
        proxy_pass http://127.0.0.1:${PORT};
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }

    location /static {
        alias ${INSTALL_DIR}/search-ucmao-master/static/;
        expires 30d;
    }
}
EOF

    # 测试配置
    nginx -t

    # 重启Nginx（宝塔环境使用不同命令）
    if [ -f "/www/server/nginx/sbin/nginx" ]; then
        log_info "检测到宝塔 Nginx，使用宝塔命令重启..."
        /etc/init.d/nginx restart
    else
        systemctl restart nginx
        systemctl enable nginx
    fi

    log_ok "Nginx 配置完成"
}

# 配置防火墙
setup_firewall() {
    log_info "正在配置防火墙..."

    if command -v ufw &> /dev/null; then
        ufw allow 80/tcp
        ufw allow 443/tcp
        ufw allow ${PORT}/tcp
        log_ok "UFW 防火墙规则添加完成"
    elif command -v firewall-cmd &> /dev/null; then
        firewall-cmd --permanent --add-service=http
        firewall-cmd --permanent --add-service=https
        firewall-cmd --permanent --add-port=${PORT}/tcp
        firewall-cmd --reload
        log_ok "Firewalld 防火墙规则添加完成"
    else
        log_warn "未检测到防火墙工具，请手动配置"
    fi
}

# 启动服务
start_service() {
    log_info "正在启动宝藏搜服务..."

    systemctl start ${SERVICE_NAME}

    sleep 3

    # 检查服务状态
    if systemctl is-active --quiet ${SERVICE_NAME}; then
        log_ok "服务启动成功！"
    else
        log_error "服务启动失败，请检查日志: journalctl -u ${SERVICE_NAME} -f"
        exit 1
    fi
}

# 显示完成信息
show_completion() {
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}  宝藏搜部署完成！${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo -e "${BLUE}访问地址:${NC}"
    echo -e "  本机: http://127.0.0.1:${PORT}"
    echo -e "  外网: http://$(curl -s ifconfig.me 2>/dev/null || echo '你的服务器IP')"
    echo ""
    echo -e "${BLUE}管理员账号:${NC}"
    echo -e "  用户名: ${ADMIN_USER}"
    echo -e "  密码: ${ADMIN_PASS}"
    echo ""
    echo -e "${BLUE}管理后台:${NC}"
    echo -e "  http://你的服务器IP/admin"
    echo ""
    echo -e "${BLUE}常用命令:${NC}"
    echo -e "  启动: systemctl start ${SERVICE_NAME}"
    echo -e "  停止: systemctl stop ${SERVICE_NAME}"
    echo -e "  重启: systemctl restart ${SERVICE_NAME}"
    echo -e "  状态: systemctl status ${SERVICE_NAME}"
    echo -e "  日志: journalctl -u ${SERVICE_NAME} -f"
    echo ""
    echo -e "${BLUE}项目目录:${NC} ${INSTALL_DIR}/search-ucmao-master"
    echo -e "${BLUE}配置文件:${NC} ${INSTALL_DIR}/search-ucmao-master/.env"
    echo ""
    echo -e "${YELLOW}========================================${NC}"
    echo -e "${YELLOW}  提示: 修改管理员账号密码命令${NC}"
    echo -e "${YELLOW}  bash ${INSTALL_DIR}/search-ucmao-master/install.sh --change-password${NC}"
    echo -e "${YELLOW}========================================${NC}"
    echo ""
}

# 主函数
main() {
    # 如果指定了修改密码模式
    if [ "$CHANGE_PASSWORD_MODE" = true ]; then
        echo -e "${GREEN}========================================${NC}"
        echo -e "${GREEN}  宝藏搜 - 修改管理员账号密码${NC}"
        echo -e "${GREEN}========================================${NC}"
        echo ""
        change_admin_password
        exit 0
    fi
    
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}  宝藏搜 - Linux 一键部署脚本${NC}"
    echo -e "${GREEN}  (适配宝塔 Python ${PYTHON_VERSION})${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo -e "${BLUE}提示: 部署完成后可使用 --change-password 参数修改管理员账号密码${NC}"
    echo ""

    # 数据库配置已预设为宝塔默认值
    log_info "数据库配置: ${DB_NAME} / ${DB_USER} / ******"
    log_info "Python 版本: ${PYTHON_VERSION}"
    log_info "如需修改，请编辑脚本中的 DB_NAME / DB_USER / DB_PASSWORD 变量"

    check_root
    detect_os
    check_bt_python
    install_dependencies
    check_mysql
    download_project

    echo ""
    log_warn "请确保项目文件已在 ${INSTALL_DIR}/search-ucmao-master/ 目录下"
    read -p "项目文件是否已准备好? (y/n): " confirm

    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        log_info "请先上传项目文件，然后重新运行脚本"
        echo ""
        echo "你可以使用以下命令上传:"
        echo "  scp -r search-ucmao-master root@你的服务器IP:${INSTALL_DIR}/"
        echo ""
        exit 0
    fi

    setup_python_env
    create_config
    init_database
    create_systemd_service
    setup_nginx
    setup_firewall
    start_service
    show_completion
}

# 运行主函数
main "$@"
