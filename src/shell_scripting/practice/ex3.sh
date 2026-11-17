#!/bin/sh
read -p "enter the directory path:" dirp

if [ -d $dirp ]
then
    echo "$dirp exists!"
    for f in $dirp/*.*
    do
        du -ah $f
    done
fi