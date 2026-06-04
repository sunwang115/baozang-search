@echo off
chcp 65001 >nul
title BaozangSearch - Windows Setup
color 0A

:: =============================================================================
:: BaozangSearch - Windows Setup Script
:: Support: Windows 7/8/10/11
:: Database: XAMPP MySQL or other MySQL/MariaDB
:: =============================================================================

setlocal enabledelayedexpansion

:: ====================== CONFIGURATION AREA ======================
set "INSTALL_DIR=%USERPROFILE%\baozang-search"
set "PORT=5004"

:: Database Configuration
set "DB_NAME=baozangsearch"
set "DB_USER=root"
set "DB_PASSWORD="

:: Admin Account
set "ADMIN_USER=admin"
set "ADMIN_PASS=admin123"

:: MySQL Path Detection (auto-detect, can modify manually)
set "XAMPP_MYSQL_PATH=C:\xampp\mysql\bin"
set "MYSQL_CMD="
:: =============================================================================

:: Welcome message
echo.
echo ========================================
echo   BaozangSearch - Windows Setup
echo ========================================
echo.

:: Show welcome info
echo [INFO] Welcome to BaozangSearch Setup!
echo [INFO] Please ensure MySQL service is running
echo.

:: Check if .env file exists (user already configured)
if exist ".env" (
    echo [INFO] Found .env file, will use configuration from .env
    call :load_env_config
) else (
    echo [INFO] .env file not found, will use default configuration
)

:: Check Python
call :check_python

:: Check MySQL
call :check_mysql

:: Prepare project directory
call :prepare_directory

:: Setup Python virtual environment
call :setup_python_env

:: Create config file if not exists
if not exist "%INSTALL_DIR%\.env" (
    call :create_config
)

:: Initialize database
call :init_database

:: Create startup scripts
call :create_startup_scripts

:: Show completion info
call :show_completion

echo.
echo [INFO] Setup complete! Press any key to exit...
pause >nul
exit /b 0

:: =============================================================================
:: Function Definitions
:: =============================================================================

:load_env_config
:: Load configuration from .env file
echo [INFO] Loading configuration from .env...
for /f "tokens=1,2 delims==" %%a in ('findstr /i "DB_HOST DB_PORT DB_DATABASE DB_USER DB_PASSWORD" .env') do (
    set "%%a=%%b"
    set "%%a=!%%a: =!"
)
if defined DB_DATABASE set "DB_NAME=%DB_DATABASE%"
goto :eof

:check_python
echo [INFO] Checking Python environment...
python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python not found, please install Python 3.8+
    echo [INFO] Download: https://www.python.org/downloads/
    pause
    exit /b 1
)
for /f "tokens=2" %%a in ('python --version') do set "PYTHON_VERSION=%%a"
echo [OK] Python %PYTHON_VERSION% detected
goto :eof

:check_mysql
echo [INFO] Checking MySQL environment...

:: Try multiple common MySQL paths
set "MYSQL_PATHS=%XAMPP_MYSQL_PATH%;C:\Program Files\MySQL\MySQL Server 8.0\bin;C:\Program Files\MariaDB 10.6\bin;C:\xampp\mysql\bin;C:\wamp64\bin\mysql\mysql8.0.27\bin"

set "MYSQL_FOUND=0"
for %%p in (%MYSQL_PATHS%) do (
    if exist "%%p\mysql.exe" (
        set "MYSQL_CMD=%%p\mysql.exe"
        set "MYSQL_FOUND=1"
        echo [INFO] Found MySQL: %%p
        goto :mysql_found
    )
)

if %MYSQL_FOUND% equ 0 (
    echo [WARN] MySQL not auto-detected, trying system PATH...
    where mysql >nul 2>&1
    if errorlevel 1 (
        echo [ERROR] MySQL not found, please ensure MySQL is installed and in PATH
        echo [INFO] Or modify XAMPP_MYSQL_PATH variable in the script
        pause
        exit /b 1
    )
    set "MYSQL_CMD=mysql"
)

:mysql_found

:: Check MySQL connection
echo [INFO] Testing MySQL connection...
"%MYSQL_CMD%" --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] MySQL command not working, please check configuration
    pause
    exit /b 1
)
echo [OK] MySQL command detected successfully

:: Try to connect to database (password not required)
if "%DB_PASSWORD%"=="" (
    "%MYSQL_CMD%" -u %DB_USER% -e "SELECT 1;" >nul 2>&1
) else (
    "%MYSQL_CMD%" -u %DB_USER% -p%DB_PASSWORD% -e "SELECT 1;" >nul 2>&1
)

if errorlevel 1 (
    echo [WARN] Cannot connect to MySQL with current configuration
    echo [INFO] Please verify:
    echo [INFO] 1. MySQL service is running
    echo [INFO] 2. Username: %DB_USER%
    echo [INFO] 3. Password: %DB_PASSWORD%
    echo [INFO] 
    echo [WARN] Will continue setup, but manual database import may be needed
) else (
    echo [OK] MySQL connected successfully
    
    :: Check if database exists
    "%MYSQL_CMD%" -u %DB_USER% %DB_PASSWORD:-p=% -e "USE %DB_NAME%;" >nul 2>&1
    if errorlevel 1 (
        echo [WARN] Database %DB_NAME% does not exist
    ) else (
        echo [OK] Database %DB_NAME% exists
    )
)
goto :eof

:prepare_directory
echo [INFO] Preparing project directory...

:: Create installation directory
if not exist "%INSTALL_DIR%" (
    mkdir "%INSTALL_DIR%"
    echo [OK] Created install directory: %INSTALL_DIR%
)

:: Check if current directory is project directory
if not exist "app.py" (
    echo [ERROR] Please run this script from project root directory
    echo [INFO] Current directory: %CD%
    echo [INFO] Please cd to search-ucmao-master directory and try again
    pause
    exit /b 1
)

:: Copy project files to install directory
echo [INFO] Copying project files to %INSTALL_DIR%...
xcopy /E /I /Y /H /R "%CD%" "%INSTALL_DIR%" >nul 2>&1
if errorlevel 1 (
    echo [WARN] Some files may have failed to copy, please check permissions
) else (
    echo [OK] Project files copied successfully
)
goto :eof

:setup_python_env
echo [INFO] Setting up Python virtual environment...

cd /d "%INSTALL_DIR%"

:: Remove old virtual environment if exists
if exist "venv" (
    echo [WARN] Found existing virtual environment, removing...
    rmdir /s /q "venv"
)

:: Create new virtual environment
echo [INFO] Creating Python virtual environment...
python -m venv venv
if errorlevel 1 (
    echo [ERROR] Failed to create virtual environment
    pause
    exit /b 1
)
echo [OK] Virtual environment created successfully

:: Activate virtual environment and install dependencies
echo [INFO] Activating virtual environment...
call venv\Scripts\activate.bat

echo [INFO] Upgrading pip...
python -m pip install --upgrade pip

echo [INFO] Installing project dependencies...
if exist "requirements.txt" (
    pip install -r requirements.txt
    if errorlevel 1 (
        echo [WARN] Some dependencies failed, trying compatible versions...
        pip install Flask==2.0.3 APScheduler==3.10.1 jmespath==0.10.0 PyMySQL==1.0.2 PyJWT==2.4.0 python-dotenv==0.20.0 requests==2.27.1
    )
) else (
    echo [WARN] requirements.txt not found, installing default dependencies...
    pip install Flask==2.0.3 APScheduler==3.10.1 jmespath==0.10.0 PyMySQL==1.0.2 PyJWT==2.4.0 python-dotenv==0.20.0 requests==2.27.1
)

echo [OK] Python environment configured successfully
goto :eof

:create_config
echo [INFO] Creating configuration file...

cd /d "%INSTALL_DIR%"

:: Generate random secret key
for /f %%a in ('powershell -Command "-join ((48..57) + (65..90) + (97..122) | Get-Random -Count 32 | ForEach-Object {[char]$_})"') do set "SECRET_KEY=%%a"

:: Create .env file
(
echo # ==============================================================================
echo # .env Configuration - BaozangSearch
echo # ==============================================================================
echo.
echo # Security Key
echo SECRET_KEY = %SECRET_KEY%
echo.
echo # MYSQL Database Configuration
echo DB_HOST = 127.0.0.1
echo DB_PORT = 3306
echo DB_DATABASE = %DB_NAME%
echo DB_USER = %DB_USER%
echo DB_PASSWORD = %DB_PASSWORD%
echo DB_CHARSET = utf8mb4
echo.
echo # Admin Account
echo ADMIN_USERNAME = %ADMIN_USER%
echo ADMIN_PASSWORD = %ADMIN_PASS%
) > .env

echo [OK] Configuration file created
echo [INFO] Admin account: %ADMIN_USER%
echo [INFO] Admin password: %ADMIN_PASS%
goto :eof

:init_database
echo [INFO] Initializing database...

cd /d "%INSTALL_DIR%"

:: Try to import database
set "DB_IMPORTED=0"

:: Priority 1: baozangsearch.sql
if exist "baozangsearch.sql" (
    echo [INFO] Found baozangsearch.sql, importing...
    if "%DB_PASSWORD%"=="" (
        "%MYSQL_CMD%" -u %DB_USER% %DB_NAME% < baozangsearch.sql 2>nul
    ) else (
        "%MYSQL_CMD%" -u %DB_USER% -p%DB_PASSWORD% %DB_NAME% < baozangsearch.sql 2>nul
    )
    if not errorlevel 1 (
        set "DB_IMPORTED=1"
        echo [OK] Database imported successfully (baozangsearch.sql)
    )
)

:: Priority 2: 数据库文件.sql
if %DB_IMPORTED% equ 0 (
    if exist "数据库文件.sql" (
        echo [INFO] Found database file, importing...
        if "%DB_PASSWORD%"=="" (
            "%MYSQL_CMD%" -u %DB_USER% %DB_NAME% < "数据库文件.sql" 2>nul
        ) else (
            "%MYSQL_CMD%" -u %DB_USER% -p%DB_PASSWORD% %DB_NAME% < "数据库文件.sql" 2>nul
        )
        if not errorlevel 1 (
            set "DB_IMPORTED=1"
            echo [OK] Database imported successfully
        )
    )
)

:: Priority 3: schema.sql
if %DB_IMPORTED% equ 0 (
    if exist "schema.sql" (
        echo [INFO] Found schema.sql, importing...
        if "%DB_PASSWORD%"=="" (
            "%MYSQL_CMD%" -u %DB_USER% %DB_NAME% < schema.sql 2>nul
        ) else (
            "%MYSQL_CMD%" -u %DB_USER% -p%DB_PASSWORD% %DB_NAME% < schema.sql 2>nul
        )
        if not errorlevel 1 (
            set "DB_IMPORTED=1"
            echo [OK] Database imported successfully (schema.sql)
        )
    )
)

if %DB_IMPORTED% equ 0 (
    echo [WARN] Database not imported automatically, please import manually:
    echo [INFO] Available database files:
    if exist "baozangsearch.sql" echo [INFO]   - baozangsearch.sql
    if exist "数据库文件.sql" echo [INFO]   - database file.sql
    if exist "schema.sql" echo [INFO]   - schema.sql
)
goto :eof

:create_startup_scripts
echo [INFO] Creating startup scripts...

cd /d "%INSTALL_DIR%"

:: Create startup script
(
echo @echo off
echo chcp 65001 ^>nul
echo title BaozangSearch Service
echo cd /d "%INSTALL_DIR%"
echo echo.
echo echo ========================================
echo echo   BaozangSearch - Starting...
echo echo ========================================
echo echo.
echo call venv\Scripts\activate.bat
echo python app.py
echo echo.
echo echo Service stopped, press any key to exit...
echo pause ^>nul
) > start.bat

:: Create background startup script (hidden window)
(
echo Set WshShell = CreateObject("WScript.Shell")
echo WshShell.Run "cmd /c ""%INSTALL_DIR%\start.bat""", 0, false
echo Set WshShell = Nothing
) > start.vbs

:: Create stop script
(
echo @echo off
echo title Stop BaozangSearch
echo echo Stopping BaozangSearch service...
echo taskkill /F /IM python.exe /FI "WINDOWTITLE eq BaozangSearch*"
echo echo.
echo echo Service stopped
echo pause
) > stop.bat

echo [OK] Startup scripts created successfully
goto :eof

:show_completion
echo.
echo ========================================
echo   BaozangSearch Setup Complete!
echo ========================================
echo.
echo [INFO] Access URLs:
echo   Local: http://127.0.0.1:%PORT%
echo   LAN: http://%COMPUTERNAME%:%PORT%
echo.
echo [INFO] Admin Dashboard:
echo   http://127.0.0.1:%PORT%/admin
echo   Username: %ADMIN_USER%
echo   Password: %ADMIN_PASS%
echo.
echo [INFO] Start Methods:
echo   Method 1: Double-click start.bat (show console window)
echo   Method 2: Double-click start.vbs (run in background, no window)
echo.
echo [INFO] Stop Service:
echo   Double-click stop.bat
echo.
echo [INFO] Project Directory: %INSTALL_DIR%
echo [INFO] Config File: %INSTALL_DIR%\.env
echo.
echo [WARN] Notes:
echo   1. Please ensure MySQL service is running
echo   2. To modify database config, edit .env file
echo   3. Restart service after modifying configuration
echo.
goto :eof
