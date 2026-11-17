#!/bin/sh
# note: 
# - Number of command line arguments are using $#
# - looping through the command line argument using #@
# Interview Pro-TipIn production, always wrap variables like $0 and $@ in double quotes ("$0", "$@") 
# to prevent word splitting if an argument happens to contain a space.

if [ $# -eq 2 ]
then
    echo required number of arguments passed to the script $0
    for i in "$@"
    do 
        echo $i
    done
    echo first argument "$1"
    echo second argument "$2"

else
    echo invalid number of arguments passed to the script $0
fi
