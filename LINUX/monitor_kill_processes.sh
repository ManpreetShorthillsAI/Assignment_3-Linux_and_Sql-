#!/bin/bash

LOG_FILE="killed_processes.log"

while true; do
    # List all processes starting with "Kill_Me_Please"
    for pid in $(pgrep -f '^Kill_Me_Please'); do
        # Get the process name
        process_name=$(ps -p $pid -o comm=)
        # Get the current timestamp
        timestamp=$(date +"%Y-%m-%d %H:%M:%S")

        # Kill the process
        kill -9 $pid

        # Log the terminated process
        echo "Terminated: $process_name, PID: $pid at $timestamp" >> $LOG_FILE
    done
    sleep 5  # Check every 5 seconds
done

