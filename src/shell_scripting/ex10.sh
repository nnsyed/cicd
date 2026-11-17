#!/bin/sh

# Script 9: User & Permissions Management
# WebLogic and JBoss processes should never run as the root user for security reasons. They typically run under dedicated system users like oracle or jboss. If # # configuration or log files accidentally get written as root, the application server will throw permissions errors and fail to start or rotate logs.
# Your Task:
# Write a script that:
#
#    Loops through all .log files in a given directory (you can hardcode or pass a directory path).
#    For each file, extracts the owner name (the user who owns the file).
#    If the owner of any log file is root, print a warning message: "SECURITY WARNING: File [FILENAME] is owned by root!"
#    If it's owned by any other user, print: "[FILENAME] ownership is valid ([OWNER])".

#Hint: You can find the owner of a file by using stat -c '%U' filename or using ls -l filename | awk '{print $3}'.

LOGS_DIR=/home/nnsyed/t_work/shell-scripting/logs

for f in "$LOGS_DIR"/*.*
do
    file_owner=$(stat -c %U $f)
    #file_owner=$(ls -l $f | awk '{print $3}')
    
    echo $file_owner
    
    if [ "$file_owner" == "root" ]
    then
        echo "SECURITY WARNING: $f is owned by root"
    else
        echo "$f is ownership is a valid $file_owner"
    fi
done
