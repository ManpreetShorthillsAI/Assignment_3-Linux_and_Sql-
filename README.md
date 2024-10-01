# Assignment_3-Linux_and_Sql-
##<details>
<summary> Table of Contents</summary>
<p>1. **File Permissions**
           2. **Process Management**</p>
         </details>

###Task 1: File Permissions
**Objective**
           - Create a file named example.txt.
           - Change its permissions so that only the owner has read and write access, and the group and others have no permissions.
**Steps**
* Create the file:
           * touch example.txt
Change permissions: Modify the file permissions using the chmod command to allow the owner to read and write, but revoke permissions for the group and others.
chmod 600 example.txt
600 Permission Breakdown:
Owner: Read (r) and Write (w).
Group: No permissions.
Others: No permissions.
Verify the permissions: Use the ls -l command to verify that the permissions are set correctly:

bash
Copy code
ls -l example.txt
The expected output should be:

diff
Copy code
-rw------- 1 user user 0 Oct 1 12:00 example.txt
Explanation
The chmod 600 example.txt command ensures that only the file owner can read and modify the file. No other users (group or others) have access to the file.
Task 2: Process Management
Objective
View and manage processes.
Identify a running process and terminate it using its Process ID (PID).
Verify the process termination.
Steps
View running processes: To view the current running processes, use the following command:

bash
Copy code
ps aux
This displays all the active processes with details such as PID, user, and resource usage.

Identify the PID: Identify the PID of the process you want to terminate. For example, let's say we want to terminate a running bash process.

Terminate the process: Use the kill command followed by the PID to terminate the process:

bash
Copy code
kill <PID>
Replace <PID> with the actual PID number of the process.
Verify process termination: Run the following command to check if the process was successfully terminated:

bash
Copy code
ps aux | grep <PID>
If the process was terminated, you should no longer see it listed.

Explanation
The ps aux command shows all processes, and kill sends a termination signal to the specified PID. To forcefully terminate a process, you can use kill -9 <PID>.
