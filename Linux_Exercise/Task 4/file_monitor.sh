#!/bin/bash

# Variables
WATCH_DIR="/home/shtlp_0103/linux_tuts" 
LOG_FILE="/home/shtlp_0103/Assignment_3-Linux_and_Sql-/Linux_Exercise/Task 4/File_monitor.log"
DB_NAME="monitor_db"    
DB_USER="root"         
DB_PASS=""
MYSQL_BIN="/opt/lampp/bin/mysql"   # Path to XAMPP MySQL, adjust if needed

# Function to monitor and log new/modified files
monitor_files() {
    # Finding new/modified files in the last 10 minutes
    find "$WATCH_DIR" -type f -newermt "$(date -d '10 minutes ago')" | while read -r file; do
        FILE_NAME=$(basename "$file")
        FILE_SIZE=$(stat -c%s "$file")
        FILE_MOD_TIME=$(stat -c%y "$file")

        # Check if file has already been processed (check DB for file name and size)
        if ! $MYSQL_BIN -u "$DB_USER" -p"$DB_PASS" -D "$DB_NAME" -e "SELECT * FROM file_data WHERE file_name='$FILE_NAME' AND file_size=$FILE_SIZE;" | grep -q "$FILE_NAME"; then
            # Upload data to the SQL database
            if $MYSQL_BIN -u "$DB_USER" -p"$DB_PASS" -D "$DB_NAME" -e "INSERT INTO file_data (file_name, file_size, timestamp) VALUES ('$FILE_NAME', $FILE_SIZE, '$FILE_MOD_TIME');"; then
                # Log the action
                echo "[$(date)] New/modified file detected: $FILE_NAME, Size: $FILE_SIZE, Time: $FILE_MOD_TIME" >> "$LOG_FILE"
            else
                # Log if SQL insertion fails
                echo "[$(date)] ERROR: Failed to insert $FILE_NAME into the database" >> "$LOG_FILE"
            fi
        else
            # Log if duplicate detected
            echo "[$(date)] Duplicate file detected: $FILE_NAME, Size: $FILE_SIZE" >> "$LOG_FILE"
        fi
    done
}

# Function to find and log the largest file
find_largest_file() {
    LARGEST_FILE=$(find "$WATCH_DIR" -type f -exec ls -s {} + | sort -n | tail -n 1)
    echo "[$(date)] Largest file detected: $LARGEST_FILE" >> "$LOG_FILE"
}

# Main execution
monitor_files
find_largest_file
