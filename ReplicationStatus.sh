#!/bin/bash

MYSQL_USER='username'
MYSQL_PASS='password'

today=`date +%y%m%d_%H:%M`
file_name=/home/mysql/SCRIPTS/logs/rep_log_$today.txt

echo -e  "$file_name" ;

host_name=$(mysql -u$MYSQL_USER -p$MYSQL_PASS -P 1561 -t -e "SHOW variables like 'hostname'\G" | grep "Value" | awk '{ print $2 }')

echo -e  "\n#####MySQL Report for $host_name #####\n" >  $file_name ;
echo -e  "\n##### Mysql Stats #####\n" >>  $file_name ;
mysql -u$MYSQL_USER -p$MYSQL_PASS -P 1561 -t  -e "\s" >> $file_name ;

#echo -e  "\n##### Mysql Master  Status #####\n" >>  $file_name ;
#mysql  -u$MYSQL_USER -p$MYSQL_PASS -P 1651 -t -e "show master status\G" >> $file_name ;

echo -e  "\n##### Mysql Slave Status #####\n" >>  $file_name ;
mysql -u$MYSQL_USER -p$MYSQL_PASS -P 1561 -t -e "show slave status\G" >> $file_name ;

find /home/mysql/SCRIPTS/logs/  -iname "rep_log__*" -mtime +14  -exec rm {} \;

#mail -s "Mysql Health Report For $host_name Dated $today" -a $file_name  backup@email.com < message.txt
