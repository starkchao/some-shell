#!/bin.sh

# 导出建库建表sql至文件，建库【create-db.sql】，建表【create-table.sql】
 
port=3306
user=root
password=root
echo "$(mysql -u${user} -P${port} -p${password} -e 'show databases;'|grep -E -v 'Database|information_schema|mysql|sys|performance_schema'|xargs mysqldump -u${user} -P${port} -p${password} --databases > ddl.sql)"
cat ddl.sql|grep 'CREATE DATABASE' > create-db.sql
sed '/CREATE DATABASE/d' ddl.sql > create-table.sql
