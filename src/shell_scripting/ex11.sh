#!/bin/sh

#
# Process Monitoring This is the final script of Level 2! In enterprise setups, monitoring tools or cron 
# jobs frequently check if the core java processes for WebLogic or JBoss are running. If they crash, the 
# script should find out immediately.

#
# Your Task:
# Write a script that:
#
#    Searches the active system processes for a specific keyword (like "WebLogic" or "JBoss").
#    Counts how many processes match that keyword.
#    If the count is 0, print an alert: "CRITICAL: WebLogic/JBoss process is down!"
#    If the count is 1 or more, print: "SUCCESS: Managed processes are running safely."
#
# Hint: You can find active processes using ps -ef. When you run ps -ef | grep WebLogic, the grep command 
# itself shows up in the process list! To exclude it, you can pipe your output into grep -v grep.

PS_USER=Weblogic
active_ps=$(ps -ef | grep $PS_USER | grep -v grep | wc -l)

#
# Note: active_ps=$(ps -ef | grep "[W]eblogic" | wc -l)
# if you want to skip grep -v grep

if [ "$active_ps" -eq 0 ]
then
    echo "CRITICAL: WebLogic/JBoss process is down!"
else
    echo "SUCCESS: Managed processes are running safely."
fi
