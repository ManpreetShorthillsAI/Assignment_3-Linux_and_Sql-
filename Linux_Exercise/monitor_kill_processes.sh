#!/bin/bash

# Log file to record terminated processes
LOGFILE="killed_processes.log"

# Start an infinite loop to monitor processes
while true; do
    # Find and list processes starting with "Kill_Me_Please_"
    for pid in $(pgrep '^Kill_Me_Please_'); do
        # Get the process name for the given PID
        pname=$(ps -p $pid -o comm=)
        
        # Log the process name, PID, and kill timestamp to the log file
        echo "Killed process $pname with PID $pid at $(date)" >> $LOGFILE

        # Kill the process
        kill $pid

        # Optional: Print to console for real-time feedback
        echo "Killed process $pname with PID $pid"
    done

    # Wait for 10 seconds before checking again
    sleep 10
done
