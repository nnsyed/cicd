#!/bin/sh
read -p "Enter path to the weblogic log file:" log_file
if [ -f "$log_file" ]
then
    echo "$log_file exists"
    error_count=`grep -ic error $log_file`
    critical_error_count=`grep -ic critical $log_file` 

    if [ "$error_count" -gt 0 ]
    then
        echo "Errors in the $log_file"
    fi

    if [ "$critical_error_count" -gt 0 ]
    then
        echo "critical errors in the $log_file"
    fi

fi