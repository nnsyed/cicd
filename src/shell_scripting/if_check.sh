#!/bin/bash

fruits=(apples oranges peaches mangos)
grades=(100 90 81 75 68 51)

for f in "${fruits[@]}"
do
   # valid if [ "$f" == "mangos" ] || [ "$f" == "oranges" ]
   # valid posix: if [ "$f" = "mangos" || "$f" = "oranges" ]

   if [[ "$f" == "mangos" || "$f" == "oranges" ]] # double brackets for bash/zsh
   then
       echo "$f is my favorite fruit"
   else
       echo "It is ok thank you"
   fi 
done

#
# looping though grades

for g in "${grades[@]}"
do
   echo "processing score $g"
   if (( $g >= 90 ))
   then
       echo "$g: A Grade"
   elif (( $g >= 80 ))
   then
       echo "$g: B Grade"
   elif (( $g >= 70 ))
   then
       echo "$g: C Grade"
   elif (( $g >= 60 ))
   then
       echo "$g: D Grade"
   else
        echo you suck!!!
   fi
done



for g in "${grades[@]}"
do
   echo "processing score $g"
   if [[ "$g" -ge 90 ]]
   then
       echo "$g: A Grade"
   elif [[ "$g" -ge 80 ]]
   then
       echo "$g: B Grade"
   elif [[ "$g" -ge 70 ]]
   then
       echo "$g: C Grade"
   elif [[ "$g" -ge 60 ]]
   then
       echo "$g: D Grade"
   else
        echo you suck!!!
   fi
done