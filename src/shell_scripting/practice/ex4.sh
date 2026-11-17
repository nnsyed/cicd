#!/bin/bash
#
# Command line arguments

if [ "$#" -eq 4 ]
then
    echo "all the required arguments passed in to the script"

    for ar in "$@"
    do
      echo "argument $ar"
    done
fi