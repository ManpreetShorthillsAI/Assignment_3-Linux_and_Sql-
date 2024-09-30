#!/bin/bash

MONITOR_DIR="$HOME/Desktop"
LOG_FILE="file_monitor.log"
DB_FILE="data.db"

sqlite3 $DB_FILE "CREATE TABLE IF NOT EXISTS files (name TEXT, size INTEGER, timestamp TEXT);"

inotifywait -m -r -e create,modify --format '%w%f' "$MONITOR_DIR" | while read NEW_FILE; do
    file_size=$(stat -c%s "$NEW_FILE")
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    if ! sqlite3 $DB_FILE "SELECT COUNT(*) FROM files WHERE name='$NEW_FILE';" | grep -q 0; then
        echo "Duplicate detected: $NEW_FILE" >> $LOG_FILE
        continue
    fi

    sqlite3 $DB_FILE "INSERT INTO files (name, size, timestamp) VALUES ('$NEW_FILE', $file_size, '$timestamp');"
    echo "Processed: $NEW_FILE, Size: $file_size bytes, Time: $timestamp" >> $LOG_FILE
done
