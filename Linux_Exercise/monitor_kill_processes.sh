#!/bin/bash
 
LOG_FILE="killed_processes.log"
 
echo "Monitoring and killing processes starting with 'Kill_Me'..."
 
while true

do

  # Find processes starting with "Kill_Me"

  processes=$(ps aux | grep "^.*Kill_Me" | grep -v grep | awk '{print $2, $11}')
 
  if [[ ! -z "$processes" ]]; then

    while read -r pid pname

    do

      # Log the process details before killing

      echo "$(date): Terminating process $pname with PID $pid" >> $LOG_FILE
 
      # Kill the process

      kill -9 $pid
 
      echo "Killed process $pname with PID $pid"

    done <<< "$processes"

  fi
 
  # Sleep for 10 seconds before checking again

  sleep 10

done

 