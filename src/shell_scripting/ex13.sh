#!/bin/sh
#Log Rotator / Purger
# WebLogic and JBoss applications generate massive quantities of logs (stdout, .log, .out, .trc). 
# If left alone, they will consume all disk space. Administrators write cron-purging scripts to 
# clean up files older than a certain number of days.
# Your Task:
# Write a script that:
#    Targets a specific log directory (e.g., LOG_DIR="/app/oracle/logs").
#    Uses the find command to locate all files inside that directory ending in .log or .out that have not been modified in the last 7 days.
#    For safety during this practice round, instead of deleting them right away with -exec rm, have the script print out the list of files it intends to delete.
#    Print a final message stating: "Log cleanup check complete."
#
# Hint: Look into the find command's -mtime parameter. To find files older than 7 days, you use -mtime +7.

LOG_DIR=/home/nnsyed/t_work/shell-scripting/logs
echo "The following files will be deleted in the next cleanup...."
find "$LOG_DIR" -type f \( -name "*.log" -o -name "*.out" \) -mtime +7 -print0 | while IFS= read -r -d '' file; do
    echo "$file"
done
echo "Log cleanup check complete."
