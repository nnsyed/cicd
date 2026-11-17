#!/bin/sh
read -p "enter the directory path " dirp
if [ -d $dirp ]
then
    for f in $dirp/*.log
    do
        if [ -f $f ]
        then
             echo "$f"
        fi
    done
fi
