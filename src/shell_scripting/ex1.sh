#!/usr/bin/sh
echo hello world
echo how are you doing ?
read -p "enter your username: " username
read -sp "enter your password: " password

echo "hello, $username!"
echo "your password is $password"