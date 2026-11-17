#!/bin/sh

# Script 7: Disk Space Monitoring
#Middleware applications like WebLogic and JBoss can crash or corrupt cache directories if the local disk fills up. Administrators write scripts to monitor #filesystems and alert them before space runs out.
#Your Task:
#Write a script that:

#    Checks the disk usage percentage of the root directory (/).
#    Extracts just the numerical value of the percentage (e.g., if its 45%, extract 45).
#    Compares it against a threshold of 90%.
#    If the usage is greater than or equal to 90, print a high-priority warning: "ALERT: Disk space critical on / ! Current usage: X%"
#    Otherwise, print: "Disk space is healthy: X%"
#
# Hint: Use df -h / to view disk info. You can use awk or sed to isolate the numeric percentage field, and strip out the % sign.
# Give it a shot and paste your code below! If you arent sure how to extract the exact number with awk, try your best or ask for a hint!


# getting second line of df -k output
# df -k / | sed -n '2p' |awk '{print $5}'
# df -k / | head -n 2 | tail -n 1 |awk '{print $5}'
# p_usage=$(df -k / | awk 'NR==2' |awk '{print $5}')

#note double (( will convert string to number.
p_usage=$(df -k / | awk 'NR==2 {print $5}' | tr -d '%')

echo $p_usage
if [ "$p_usage" -gt 90 ]
then
    echo "ALERT: Disk space critical on / ! Current usage: $p_usage%"
else
    echo "Disk space is healthy: $p_usage%"
fi    

