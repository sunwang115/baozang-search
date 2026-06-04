import pymysql

# 连接 MySQL
conn = pymysql.connect(host='127.0.0.1', port=3306, user='baozangsearch', password='baozangsearch', database='baozangsearch')
cursor = conn.cursor()

# 读取 SQL 文件
with open('baozangsearch.sql', 'r', encoding='utf-8') as f:
    sql_content = f.read()

# 执行 SQL 语句
for statement in sql_content.split(';'):
    stmt = statement.strip()
    if stmt:
        try:
            cursor.execute(stmt)
        except Exception as e:
            print(f'执行SQL出错: {e}')
            print(f'SQL: {stmt[:100]}...')

conn.commit()
print('数据库导入完成')

cursor.close()
conn.close()
