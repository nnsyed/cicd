#!/bin/bash

# backup 

SOURCE_DIR=/home/nnsyed/t_work/shell-scripting/data/artifacts
BACKUP_DIR=/home/nnsyed/t_work/shell-scripting/data/backup
timestamp=$(date +"%y%m%d_%H%M%S")

#files=$(find  $SOURCE_DIR -type f \( -name "*.ear" -o -name "*.war" -o -name "*.gz" \) )
#echo $files
for f in "$SOURCE_DIR"/*.jar "$SOURCE_DIR"/*.ear "$SOURCE_DIR"/*.war "$SOURCE_DIR"/*.gz
do
   filename=$(basename $f)
   echo "copying $f to $BACKUP_DIR/$backup_$timestamp_$filename"
   echo "cp $f $BACKUP_DIR/$backup_$timestamp_$filename"
done