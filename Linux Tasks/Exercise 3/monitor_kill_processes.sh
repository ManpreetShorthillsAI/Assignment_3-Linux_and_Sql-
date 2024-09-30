#!/bin/bash
LOG_FILE="killed_processes.log"

monitor_processes() {
  while true; do
    ps aux | grep "^.*Kill_Me" | grep -v grep | while read -r process; do
      PID=$(echo $process | awk '{print $2}')          # Extract the PID
      PROC_NAME=$(echo $process | awk '{print $11}')    # Extract the process name

      kill -9 $PID
      
      echo "$(date): Terminated $PROC_NAME with PID $PID" >> "$LOG_FILE"
      
      echo "Terminated $PROC_NAME with PID $PID and logged in $LOG_FILE"
    done
    
    sleep 10
  done
}

monitor_processes

