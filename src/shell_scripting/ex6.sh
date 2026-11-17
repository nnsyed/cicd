#!/usr/bin/sh

check_status()
{
    if [ "$1" -eq 200 ]
    then
        return 0
    else
        return 1
    fi
}

check_status 200

if [ $? -eq 0 ] 
then 
     echo "service is healthy"
else
     echo "service is down"
 fi
 
 status_code=(200 500 404 202)
 

for code in "${status_code[@]}"
do 
    echo "Tesing status code : $code"
    if [ $? -eq 0 ] 
    then 
        echo "service is healthy"
    else
        echo "service is down"
    fi
done
 
