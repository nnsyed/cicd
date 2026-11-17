#!/bin/sh
read -p "Enter the WebLogic AdminServer.log path:" log_file

if [ -f $log_file  ]
then
     echo log file $log_file exists.
     error_count=`grep -c ERROR $log_file`
     critical_count=`grep -c Critical $log_file`
     echo "error count: $error_count"
     echo "critical count: $critical_count"
else
     echo log file $log_file does not exists.
     exit 1
fi
