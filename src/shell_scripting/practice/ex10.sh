#!/bin/sh

LOGS_DIR=/home/nnsyed/t_work/shell-scripting/data/logs
#files=$(find "$LOG_DIR" -name "*.log" -print)
echo $files

for f in "$files"
do
   echo "processing $f"
   f_user=$(stat -c %U $f)
   echo $f $f_user

   if [ "$f_user" == "root" ]
   then
       echo "Security Alert: $f is owned by root"
    else
        echo "$f is ownership is a valid $file_owner"
    fi
done