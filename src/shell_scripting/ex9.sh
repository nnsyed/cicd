#!/bin/sh

# Script 8: Backup and Compression (With Timestamps)Before deploying a new .war or .ear file, or
# modifying configuration domains in WebLogic/JBoss, you must always take a backup of the 
# existing directories.
#
# Write a script that:

# Defines a source directory to backup (e.g., SOURCE_DIR="/app/jboss/domains") and a backup destination directory 
# (e.g., BACKUP_DIR="/app/backups"). For testing, you can use any folders on your system.
#    Checks if the destination directory exists; if not, creates it (mkdir -p).
#    Generates a unique backup filename containing the current date and time in the format YYYYMMDD_HHMMSS (e.g., backup_20260906_163302.tar.gz).
#    Compresses the source directory into the backup folder using tar -czf.
# Hint: You can get the formatted timestamp using the command date +%Y%m%d_%H%M%S.

SOURCE_DIR=/home/nnsyed/t_work/shell-scripting/artifacts
BACKUP_DIR=/home/nnsyed/t_work/shell-scripting/backup
timestamp=$(date +"%Y%m%d_%H%M%S")

echo $timestamp
if [ ! -d $BACKUP_DIR ]
then
    mkdir $BACKUP_DIR
fi

for f in "$SOURCE_DIR"/*.jar "$SOURCE_DIR"/*.ear "$SOURCE_DIR"/*.war "$SOURCE_DIR"/*.gz
do
     #echo $f 
    filename=$(basename $f)
    #dest_filename="$BACKUP_DIR"/backup_"$timestamp"_"$filename"
    dest_filename="$BACKUP_DIR/backup_${timestamp}_${filename}"
    cp "$f" "$dest_filename"
done

