import pymysql

conn = pymysql.connect(host='127.0.0.1', port=3306, user='root', password='', database='ucmao_search', charset='utf8mb4')
cursor = conn.cursor()

# 检查当前表结构
cursor.execute('SHOW COLUMNS FROM resources')
results = cursor.fetchall()
print('当前 resources 表结构:')
existing_columns = []
for r in results:
    print(f'  {r[0]}: {r[1]}')
    existing_columns.append(r[0])

# 添加排序字段
if 'sort_order' not in existing_columns:
    print('\n添加 sort_order 字段...')
    cursor.execute("ALTER TABLE resources ADD COLUMN sort_order int(11) NOT NULL DEFAULT 0 COMMENT '排序权重，越大越靠前'")
    cursor.execute("ALTER TABLE resources ADD INDEX idx_sort_order (sort_order)")
    print('✓ sort_order 字段添加成功')
else:
    print('\n✓ sort_order 字段已存在')

conn.commit()

# 验证
cursor.execute('SHOW COLUMNS FROM resources')
results = cursor.fetchall()
print('\n修复后的 resources 表结构:')
for r in results:
    print(f'  {r[0]}: {r[1]}')

cursor.close()
conn.close()
