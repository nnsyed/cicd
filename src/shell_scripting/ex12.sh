#!/bin/sh

# WebLogic Managed Servers or JBoss Server Instances listen on specific TCP ports (e.g., 7001 for WebLogic Admin, 8080 for JBoss HTTP). Instead of just checking # if the Java process is alive, a great administrator verifies if the server is actually listening on its network port.
# Your Task:
# Write a script that:
#
#    Loops through a defined list of ports (e.g., 7001 7002 8080).
#    Uses a networking tool like netstat, ss, or nc (netcat) to check if that local port is active and in a LISTEN state.
#    If the port is listening, print: "Port [PORT]: ONLINE".
#    If the port is not listening, print: "Port [PORT]: OFFLINE - Action Required!".
#
# Hint: You can use ss -lnt or netstat -an and pipe it into grep to search for the specific port number.
# Give it a shot and paste your code below! If you aren't sure of the exact network flags, try writing out the loop framework and 
# we can fill in the rest together

ports=(7001 7002 8080)

for p in "${ports[@]}"
do
  #port_active=$(ss -lnt | grep -w $p | wc -l )
  port_active=$(netstat -an | grep -w $p | wc -l )
  if [ "$port_active" -gt 1 ]
  then
      echo "Port [$p]: ONLINE"
  else
      echo "Port [$p]: OFFLINE - Action Required!"
  fi
  
done
