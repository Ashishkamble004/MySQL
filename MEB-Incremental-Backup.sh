#!/bin/bash

DIR='/home/mysql/SCRIPTS'
. $DIR/.DB_PARAM

MYSQL_BASE=/appl/mysql
export MYSQL_BASE

MYSQL_HOME=/appl/mysql/8.0.22

export MYSQL_HOME

PATH=$PATH:$MYSQL_HOME:$MYSQL_HOME/bin
export PATH

VARDATE=`date +%Y%m%d`
export VARDATE

mysqlbackup --defaults-file=/appl/mysql/8.0.22/my.cnf -u$pid -p$pidpw --backup_dir=/backup/dbbackup/daily --backup-image=db_incr_backup_$VARDATE.mbi backup-to-image --with-timestamp --incremental --incremental-base=history:last_backup --compress --compress-method=zlib --skip-binlog

find /backup/dbbackup/daily -mtime +15 -type d -exec rm -rf {} \;
