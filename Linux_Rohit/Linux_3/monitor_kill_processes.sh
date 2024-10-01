#!/usr/bin/bash

# Log file to record terminated processes
LOG_FILE="killed_processes.log"

# Ensure log file exists
touch $LOG_FILE

# Infinite loop to continuously monitor the system for new processes
while true; do
    # Find processes whose name starts with "Kill_Me"
    for pid in $(pgrep -f "^Kill_Me"); do
        # Get the process name for the current PID
        process_name=$(ps -p $pid -o comm=)
        
        # Log the termination time, process name, and PID
        echo "$(date): Terminating process - Name: $process_name, PID: $pid" >> $LOG_FILE
        
        # Terminate the process
        kill -9 $pid
    done
    
    # Sleep for a few seconds before checking again
    sleep 5
done

