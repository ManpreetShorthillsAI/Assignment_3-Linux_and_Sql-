#!/bin/bash

# Log file for killed processes, now located in the current working directory
LOG_FILE="killed_processes.log"

# Function to kill matching processes and log the details
kill_processes() {
  # Get the list of processes matching the pattern
  ps -e -o pid,args --sort=start_time | grep "Kill_Me_Please_" | grep -v "grep" | while read -r PID PROC_NAME
  do
    # Capture the current timestamp
    KILL_TIME=$(date +"%Y-%m-%d %H:%M:%S")
    
    # Log the process details before killing
    echo "Killing process: $PROC_NAME, PID: $PID at $KILL_TIME" >> "$LOG_FILE"
    
    # Kill the process
    kill "$PID"
    
    # Log the kill result
    if [ $? -eq 0 ]; then
      echo "Process $PROC_NAME with PID $PID killed successfully at $KILL_TIME" >> "$LOG_FILE"
    else
      echo "Failed to kill process $PROC_NAME with PID $PID at $KILL_TIME" >> "$LOG_FILE"
    fi
  done
}

# Ensure the log file is created in the working directory
touch "$LOG_FILE"
chmod 644 "$LOG_FILE"

# Infinite loop to continuously check for and kill processes
while true
do
  kill_processes
  
  # Check again every 30 seconds
  sleep 30
done
