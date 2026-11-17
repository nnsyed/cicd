#!/bin/bash

read -p "Enter your name:" username
read -sp "Enter your password:" password
echo ""
read -p "Enter database SID:" database

echo "You entered connect String:" $username/$password@$database
