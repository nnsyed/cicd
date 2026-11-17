#!/bin/sh
#
#
# Array and if check

nums=(9 10 20 30 40 50 60)
fruits=(apples oranges mangos peaches grapes)


for f in "${fruits[@]}"
do
  if [ "$f" == "mangos" ] || [ "$f" == "grapes" ]
  then
      echo "$f is my favorite fruit"
  else
      echo $f
  fi
done


for i in "${nums[@]}"
do
  if [ $(($i%2)) -eq 0 ]
  then
        echo $i is even
  fi

  if [ "$i" -ge 10 ]
  then
     echo $i is greater than or equal to 10
  fi
done