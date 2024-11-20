#!/bin/bash

# Configuration
MONITOR_DIR="/home/shtlp_0070/Desktop/Assignment3/Assignment_3-Linux_and_Sql-/Linux/linux_task4/sample_files"  # Directory to monitor
DB_NAME="file_monitor_db"               # Database name
DB_USER="root"                          # Database user
DB_PASSWORD="root"                      # Database password
LOG_FILE="/home/shtlp_0070/Desktop/Assignment3/Assignment_3-Linux_and_Sql-/Linux/linux_task4/file_monitor.log"  # Log file path

# Create the log file if it doesn't exist
touch "$LOG_FILE"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> "$LOG_FILE"
}

# Function to upload new files to the database
upload_file() {
    local file_path="$1"
    local file_name=$(basename "$file_path")
    local file_size=$(stat -c%s "$file_path")
    local file_timestamp=$(date -r "$file_path" '+%Y-%m-%d %H:%M:%S')

    # Check for duplicate entry
    if ! mysql -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "SELECT * FROM files WHERE file_name='$file_name';" | grep -q "$file_name"; then
        # Insert file details into the database
        mysql -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "INSERT INTO files (file_name, file_size, file_timestamp) VALUES ('$file_name', '$file_size', '$file_timestamp');"
        log_message "Uploaded: $file_name (Size: $file_size bytes, Timestamp: $file_timestamp)"
    else
        log_message "Duplicate detected: $file_name (Size: $file_size bytes, Timestamp: $file_timestamp)"
    fi
}

# Create the database and table if they do not exist
mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u "$DB_USER" -p"$DB_PASSWORD" -D "$DB_NAME" -e "
CREATE TABLE IF NOT EXISTS files (
    id INT AUTO_INCREMENT PRIMARY KEY,
    file_name VARCHAR(255) UNIQUE,
    file_size BIGINT,
    file_timestamp DATETIME
);"

# Monitor the directory for new files
inotifywait -m -r -e create,modify --format '%w%f' "$MONITOR_DIR" | while read NEW_FILE
do
    # Process the new or modified file
    upload_file "$NEW_FILE"
done &

# Find the largest file
while true; do
    LARGEST_FILE=$(find "$MONITOR_DIR" -type f -exec du -b {} + | sort -n | tail -1)
    if [ -n "$LARGEST_FILE" ]; then
        LARGEST_FILE_NAME=$(basename "$LARGEST_FILE")
        LARGEST_FILE_SIZE=$(echo "$LARGEST_FILE" | awk '{print $1}')
        log_message "Largest file: $LARGEST_FILE_NAME (Size: $LARGEST_FILE_SIZE bytes)"
    fi
    sleep 300  # Check every 5 minutes
done
