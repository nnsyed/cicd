#!/bin/sh

#Script 13: Thread Dump Automator
#When a WebLogic or JBoss server hangs, stops responding, or hits 100% CPU usage, the very first troubleshooting step an administrator takes is generating JVM Thread Dumps. To see a trend, you must take multiple #dumps separated by a brief pause (e.g., 3 dumps spaced 10 seconds apart).
#Your Task:
#Write a script that:
#
#    Accepts a Java Process ID (PID) as a command-line argument.
#    Checks if the PID was provided and is an active process.
#    Uses a loop to run the JDK utility jstack <PID> exactly 3 times.
#    Redirects the output of each run to a unique file named threaddump_<PID>_1.txt, threaddump_<PID>_2.txt, etc.
#    Introduces a 5-second delay between each execution.
# Hint: You can implement the 5-second delay using the sleep 5 command.
# Give it a shot, make sure your shebang matches your syntax, and paste your code below! Let me know if you would like me to clarify how to structure the iteration loop counter.
read -p "enter the process_id of the java_process:" j_pid

#for i in $(ps -ef | awk 'NR>1 {print $2}')
#do
#done
data=$(ps -ef | grep -v grep | awk '{print $2}' | grep -w "$j_pid" )

if [ "$data" -eq "$j_pid" ]
then
     echo "$j_pid is a valid process"
     for i in {1..3}
     do
        jstack "$j_pid" > /tmp/threaddump_"$j_pid"_"$i".txt
        sleep 5
     done
else
     echo "$j_pid is NOT a valid process"
     exit 2
fi

