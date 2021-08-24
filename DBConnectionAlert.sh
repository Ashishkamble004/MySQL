datetime=`date "+%Y-%m-%d-%H-%M"`
LOG_DIR=/home/mysql/SCRIPTS/logs
log=$LOG_DIR/processlist_$datetime.log
file=$LOG_DIR/proc_file_$datetime.log

mysql -u <user> -p'<password>' -P 1561 -e 'select Id from information_schema.processlist' > $file

sed 1d $file > $log

connections=`cat $log | wc -l`

echo "Current DB connections: $connections" >> $log

if [ $connections -gt 350 ]
then
  echo "The DB connections has crossed the threshold value of 350" >>  $log
else
  echo "The DB connection count is below threshold" >> $log
fi

find $LOG_DIR/proc* -mtime +7 -exec rm {} \;
[mysql@VMDBPDPD09 :/home/mysql]#
