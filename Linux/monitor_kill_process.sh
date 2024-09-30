#!/bin/bash
 
# Linux Training Assignment-3
# Make this script executable by giving appropriate file permissions.
 
LOGFILE="killed_processes.log"
 
# Function to create a dummy process
create_process() {
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")  # Generate a unique timestamp
    PROCESS_NAME="Kill_Me_Please_$TIMESTAMP"
    
    exec -a "$PROCESS_NAME" sleep 1000 &  # Spawn the process in the background
    
    PID=$!
    
    echo "Started $PROCESS_NAME with PID $PID"
}
 
# Function to monitor and kill processes starting with "Kill_Me_Please"
monitor_and_kill_processes() {
    while true; do
        # Find processes that start with "Kill_Me_Please"
        for pid in $(pgrep -f "^Kill_Me_Please"); do
            # Get the process name
            process_name=$(ps -p $pid -o comm=)
            # Get the current time
            current_time=$(date '+%Y-%m-%d %H:%M:%S')
            
            # Log the killed process information
            echo "Terminating process: $process_name (PID: $pid) at $current_time" >> $LOGFILE
            
            # Kill the process
            kill $pid
        done
        
        sleep 5  # Check every 5 seconds for new processes
    done
}
 
# Run the process creation in the background
(while true; do create_process; sleep 30; done) &
 
# Run the monitoring function
monitor_and_kill_processes
 