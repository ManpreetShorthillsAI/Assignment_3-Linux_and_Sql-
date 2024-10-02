## Exercise 3: Monitoring and Killing Processes
1. Created a script called monitor_kill_processes.sh that:
   <ul>
  <li>Continuously monitors for processes with names starting with "Kill_Me."</li>

  <li>Terminates those processes.</li>

  <li>Logs the process name, PID, and termination time in killed_processes.log.</li></ul>

3. Used a dummy script called create_process.sh to generate dummy processes with names beginning with "Kill_Me" every 30 seconds for testing purposes.
   
4. Assigned executable permissions to both scripts using chmod +x.
   
5. Executed monitor_kill_processes.sh to monitor, kill, and log processes, and ran create_process.sh to create dummy processes for termination.
