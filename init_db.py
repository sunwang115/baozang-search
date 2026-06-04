import pymysql

# 连接 MySQL (root 用户，无密码)
conn = pymysql.connect(host='127.0.0.1', port=3306, user='root', password='')
cursor = conn.cursor()

# 创建数据库
cursor.execute('CREATE DATABASE IF NOT EXISTS baozangsearch CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;')

# 创建用户并授权
cursor.execute("CREATE USER IF NOT EXISTS 'baozangsearch'@'localhost' IDENTIFIED BY 'baozangsearch';")
cursor.execute("GRANT ALL PRIVILEGES ON baozangsearch.* TO 'baozangsearch'@'localhost';")
cursor.execute('FLUSH PRIVILEGES;')

conn.commit()
print('数据库和用户创建成功')

cursor.close()
conn.close()
