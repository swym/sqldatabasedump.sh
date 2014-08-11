#!/bin/bash
 
# sqldatabasedump.sh
#
# Backup (mysqldump) all your MariaDB/MySQL databases in separate files
# based on: https://gist.github.com/tonybolzan/9793414
 
BACKUPFOLDER="/var/backup/mysqldump"
TIMESTAMP=$(date +"%Y%m%d-%H%M")
 
DATABASES=$(mysql --defaults-file=/etc/mysql/debian.cnf -Bse 'SHOW DATABASES WHERE `database` NOT IN ("information_schema", "performance_schema", "mysql", "test");')
 
mkdir -p $BACKUPFOLDER
 
for DB in $DATABASES; do
    mysqldump --defaults-file=/etc/mysql/debian.cnf --opt --triggers --hex-blob --databases $DB > $BACKUPFOLDER/$DB-$TIMESTAMP.sql
done

exit 0
