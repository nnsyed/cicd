#!/bin/sh
read -p "Enter the directory path:" dirp

if [ -d $dirp ]
then
    echo "directory $dirp exists"

    #
    # -s summary
    # -h human-readable
    #
    dsize=`du -sh $dirp`
    echo "Its size is :$dsize"
fi


