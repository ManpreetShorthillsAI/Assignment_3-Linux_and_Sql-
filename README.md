# Assignment_3-Linux_and_Sql-

Linux Exercise:
1.File Permissions
# Create the file
touch example.txt

# Change the permissions so only the owner has read and write access
chmod 600 example.txt

# Verify the permissions
ls -l example.txt
# Expected output: -rw------- 1 username group 0 date time example.txt
----------------------------------------------------------------------------------

2. Process Management:
# View running processes
ps aux

# Identify the PID of a running process (e.g., terminal or bash)
# Example: If you find the process you want to terminate, note its PID

# Terminate the process using its PID (replace <PID> with the actual process ID)
kill <PID>

# Verify the process has been terminated
ps aux | grep <PID>  # If nothing is returned, the process has been terminated successfully

-------------------------------------------------------------------------------------

3. Write a shell script that continuously monitors the system for new processes.

# Process Monitoring and Termination Script

## Description

This project contains two shell scripts that demonstrate the process of monitoring and terminating specific system processes whose names start with `Kill_Me`. It includes:

1. `create_dummy_processes.sh` - A script that spawns dummy processes every 30 seconds, simulating processes with names starting with `Kill_Me`.
2. `monitor_kill_processes.sh` - A script that monitors the system for any processes starting with `Kill_Me`, terminates them, and logs the details (name, PID, and kill time) to a file named `killed_processes.log`.

---

## Files

- `create_dummy_processes.sh`: Script that continuously creates processes named `Kill_Me_Please_*`.
- `monitor_kill_processes.sh`: Script that monitors and terminates processes starting with `Kill_Me` and logs the details.
- `killed_processes.log`: Log file containing the details of all terminated processes.

---

## Setup

1. Clone or download the repository to your local machine.

2. Open the project folder in **VS Code** or your terminal.

3. Make the scripts executable by running the following commands in the terminal:
   ```bash
   chmod +x create_dummy_processes.sh
   chmod +x monitor_kill_processes.sh

   ----------------------------------------------------------------------------------------











