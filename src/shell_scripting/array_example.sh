#!/bin/bash

#
# looping through fruits
fruits=(apples oranges peaches mangos)
for f in "${fruits[@]}"
do
   echo $f
done

#
# looping though grades
grades=(100 90 98 50)

for g in "${grades[@]}"
do
   echo $g
done 


# Explicit Declaration:
declare -a myfruits=(anannas chiku sitaphal kavit)

for f in {1..4}
do
   echo ${myfruits[$f]}
done


#
# Quick Sheet: Accessing Array Elements (Bash)
#
# Goal                 			Syntax            Example Output (using fruits)
# -------------------------------------------------------------------------------------
# Read a specific item		${array[index]}		${fruits[1]} → oranges
# Read all items		"${array[@]}		"apples oranges peaches mangos
# Get total count of items	"${#array[@]}"		4
# Get all indices/keys		"${!array[@]}"		0 1 2 3

#
# Implicit Assignment (Most Common):
fruits=(apples oranges peaches mangos)

#
# Explicit Declaration:
declare -a fruits=(apples oranges peaches mangos)

# Index-by-Index Assignment:
fruits[0]="apples"
fruits[1]="oranges"

echo $fruits[0]
echo $fruits[1]
echo $fruits[2]
echo $fruits[3]

# Associative Arrays / Key-Value Pairs (Bash 4.0+)
declare -A user_ages
user_ages=([alice]=25 [bob]=30 [charlie]=35)

echo "${user_ages[alice]}" # Outputs: 25

echo "$user_ages[0]"
