#!/usr/bin/bash
 
# Log file for killed processes
LOG_FILE="killed_processes.log"
 
# Create or clear the log file at the start
> "$LOG_FILE"
 
echo "Monitoring for processes that start with 'Kill_Me'. Press [Ctrl+C] to stop."
 
# Infinite loop to monitor processes
while true; do
    # Find processes that start with "Kill_Me"
    for pid in $(pgrep "^Kill_Me"); do
        # Get the process name
        process_name=$(ps -p "$pid" -o comm=)
 
        # Log the details
        echo "$(date +'%Y-%m-%d %H:%M:%S') - Killed process: $process_name (PID: $pid)" >> "$LOG_FILE"
        # Kill the process
        kill "$pid"
        echo "Killed process: $process_name (PID: $pid)"
    done
 
    # Sleep for a short duration to avoid high CPU usage
    sleep 5
done
