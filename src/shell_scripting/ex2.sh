#!/bin/sh
read -p "enter the directory path:" dirp
if [ -d "$dirp" ]
then 
        echo "Directory $dirp exists. Ready for deployment"
else
        echo "Error: Directory $dirp not found!"
        exit 1
fi
