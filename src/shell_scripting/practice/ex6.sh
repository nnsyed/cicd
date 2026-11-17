#!/bin/bash

check_status()
{
    if [ "$1" -eq 200 ]
    then
        return 0
    else
        return -1
    fi
}

check_status 200
if [ $? -eq 0 ]
then
    echo "Successful status"
else
    echo "It is a failed status"
fi

statuses=(200 400 500)

for s in "${statuses[@]}"
do
    check_status $s
    if [ $? -eq 0 ]
    then
        echo "Service is up"
    else
        echo "Service is down"
    fi
done
