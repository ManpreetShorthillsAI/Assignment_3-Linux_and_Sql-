#!/usr/bin/bash

# Directory to monitor
MONITOR_DIR="/home/shtlp_0038/Desktop/monitor"

# MySQL database credentials
DB_USER="root"
DB_PASS="Palak030102"
DB_NAME="file_monitor_db"
LOG_FILE="file_monitor.log"

# Function to initialize the MySQL database and table if not already created
initialize_db() {
    mysql -u $DB_USER -p$DB_PASS -e "
    CREATE DATABASE IF NOT EXISTS $DB_NAME;
    USE $DB_NAME;
    CREATE TABLE IF NOT EXISTS files (
        file_name VARCHAR(255) UNIQUE,
        file_size BIGINT,
        timestamp DATETIME
    );"
}

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

# Function to find the largest file in the directory
find_largest_file() {
    find "$MONITOR_DIR" -type f -exec du -h {} + | sort -rh | head -n 1
}

# Function to upload file contents to the database and check for duplicates
upload_to_database() {
    local file_path=$1
    local file_name=$(basename "$file_path")
    local file_size=$(stat -c%s "$file_path")
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')

    # Check if the file is already in the database
    local duplicate=$(mysql -u $DB_USER -p$DB_PASS -D $DB_NAME -se "SELECT COUNT(*) FROM files WHERE file_name = '$file_name';")

    if [[ "$duplicate" -eq 0 ]]; then
        # Insert file into the database
        mysql -u $DB_USER -p$DB_PASS -D $DB_NAME -e "INSERT INTO files (file_name, file_size, timestamp) VALUES ('$file_name', $file_size, '$timestamp');"
        log_message "Processed $file_name (size: $file_size bytes, timestamp: $timestamp). No duplicate found."
    else
        log_message "Duplicate detected: $file_name."
    fi
}

# Monitor for new or modified files using inotifywait
monitor_directory() {
    inotifywait -m -r -e create,modify "$MONITOR_DIR" --format '%w%f' | while read NEW_FILE
    do
        log_message "New or modified file detected: $NEW_FILE"

        # Upload new file to the database and check for duplicates
        upload_to_database "$NEW_FILE"

        # Find the largest file in the directory
        largest_file=$(find_largest_file)
        log_message "Largest file in the directory: $largest_file"
    done
}

# Initialize the database
initialize_db

# Start monitoring the directory
monitor_directory

