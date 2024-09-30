## Exercise 3: Monitoring and Killing Processes

1. Created a script named `monitor_kill_processes.sh` that:
   1. Continuously checks for processes whose names start with "Kill_Me".
   2. Terminates those processes.
   3. Logs the terminated process name, PID, and time in `killed_processes.log`.
2. Ran a dummy script named `create_process.sh` to spawn dummy processes with names starting with "Kill_Me" every 30 seconds for testing.
3. Set executable permissions for both scripts using `chmod +x`.
4. Ran the `monitor_kill_processes.sh` to monitor, kill, and log the processes, and ran `create_process.sh` to generate dummy processes for termination.
