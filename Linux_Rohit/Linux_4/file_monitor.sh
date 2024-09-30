#!/usr/bin/bash

# Set the directory to monitor
MONITOR_DIR="/path/to/monitor"

# Log file
LOG_FILE="file_monitor.log"
touch $LOG_FILE

# SQL database details
DB_NAME="file_data.db"

# Ensure the SQL database and table exist
sqlite3 $DB_NAME <<EOF
CREATE TABLE IF NOT EXISTS files (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    filename TEXT UNIQUE,
    size INTEGER,
    timestamp DATETIME
);
EOF

# Function to upload new file data to the SQL database
upload_to_db() {
    local file=$1
    local size=$2
    local timestamp=$3

    # Check for duplicates in the database
    if ! sqlite3 $DB_NAME "SELECT filename FROM files WHERE filename='$file';" | grep -q "$file"; then
        # No duplicates found, proceed with the upload
        sqlite3 $DB_NAME <<EOF
INSERT INTO files (filename, size, timestamp)
VALUES ('$file', $size, '$timestamp');
EOF
        echo "$(date): Uploaded file - $file, Size: $size bytes, Timestamp: $timestamp" >> $LOG_FILE
    else
        # Log duplicate file detection
        echo "$(date): Duplicate file detected - $file, Size: $size bytes, Timestamp: $timestamp" >> $LOG_FILE
    fi
}

# Function to find the largest file by size
find_largest_file() {
    find $MONITOR_DIR -type f -exec ls -lh {} + | sort -k 5 -rh | head -n 1
}

# Monitor for new or modified files and process them
inotifywait -m -r -e create,modify --format "%w%f" $MONITOR_DIR | while read NEW_FILE
do
    if [ -f "$NEW_FILE" ]; then
        FILE_SIZE=$(stat -c%s "$NEW_FILE")
        FILE_TIMESTAMP=$(date -r "$NEW_FILE" +"%Y-%m-%d %H:%M:%S")

        # Upload file data to the database
        upload_to_db "$NEW_FILE" "$FILE_SIZE" "$FILE_TIMESTAMP"
    fi
done &

# Check for the largest file every 10 minutes and log it
while true; do
    LARGEST_FILE=$(find_largest_file)
    echo "$(date): Largest file found: $LARGEST_FILE" >> $LOG_FILE
    sleep 600  # 10 minutes
done
