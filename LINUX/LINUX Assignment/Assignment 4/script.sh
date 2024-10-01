#!/bin/bash

# Directory to monitor
MONITOR_DIR="/home/shtlp_0146/Desktop/sample_files"
# Log file location
LOG_FILE="/home/shtlp_0146/Desktop/file_monitor.log"

# MySQL database credentials
DB_HOST="localhost"
DB_USER="root"
DB_PASSWORD="Ashok@121201"
DB_NAME="file_monitor_db"

# Ensure the log file exists
touch "$LOG_FILE"

# Function to upload data to MySQL database from CSV
upload_csv_to_db() {
  local csv_file="$1"

  # Read the CSV file line by line
  while IFS=',' read -r id name place job; do
    # Skip the header line
    if [[ "$id" == "id" ]]; then
      continue
    fi

    # Log the file processing
    echo "$(date): Processing record ID '$id', Name: $name, Place: $place, Job: $job" >> "$LOG_FILE"

    # Check for duplicates by ID
    duplicate_check=$(mysql -u"$DB_USER" -p"$DB_PASSWORD" -D"$DB_NAME" -sse "SELECT COUNT(*) FROM files WHERE id='$id';")

    if [ "$duplicate_check" -eq 0 ]; then
      # Insert new record into the MySQL database
      mysql -u"$DB_USER" -p"$DB_PASSWORD" -D"$DB_NAME" -e "INSERT INTO files (id, name, place, job) VALUES ('$id', '$name', '$place', '$job');"
      echo "$(date): Uploaded record with ID '$id' to database." >> "$LOG_FILE"
    else
      echo "$(date): Duplicate ID '$id' detected, not uploaded." >> "$LOG_FILE"
    fi
  done < <(tail -n +2 "$csv_file")  # Skip the header line
}

# Function to upload new files to MySQL database
upload_to_db() {
  local file_path="$1"
  local file_size="$2"
  local file_timestamp="$3"

  # Check for duplicates
  duplicate_check=$(mysql -u"$DB_USER" -p"$DB_PASSWORD" -D"$DB_NAME" -sse "SELECT COUNT(*) FROM files WHERE file_name='$file_path';")

  if [ "$duplicate_check" -eq 0 ]; then
    # Insert new file details into the MySQL database
    mysql -u"$DB_USER" -p"$DB_PASSWORD" -D"$DB_NAME" -e "INSERT INTO files (file_name, file_size, timestamp) VALUES ('$file_path', $file_size, '$file_timestamp');"
    echo "$(date): Uploaded '$file_path' to database." >> "$LOG_FILE"
  else
    echo "$(date): Duplicate file '$file_path' detected, not uploaded." >> "$LOG_FILE"
  fi
}

# Create the MySQL database and table if they don't exist
mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
mysql -u"$DB_USER" -p"$DB_PASSWORD" -D"$DB_NAME" -e "CREATE TABLE IF NOT EXISTS files (id INT AUTO_INCREMENT PRIMARY KEY, file_name VARCHAR(255) UNIQUE, file_size BIGINT, timestamp DATETIME);"

# Monitor for new or modified files in the last 10 minutes
find "$MONITOR_DIR" -type f -newermt '-10 minutes' | while read -r file; do
  # Get file details
  file_size=$(stat -c%s "$file")
  file_timestamp=$(stat -c%y "$file")

  # Log the file processing
  echo "$(date): Processing file '$file', Size: $file_size bytes, Timestamp: $file_timestamp" >> "$LOG_FILE"

  # Upload to MySQL database
  upload_to_db "$file" "$file_size" "$file_timestamp"
done

# Process the CSV file
csv_file="$MONITOR_DIR/random_data.csv"
if [[ -f "$csv_file" ]]; then
  upload_csv_to_db "$csv_file"
fi

# Find and display the largest file
largest_file=$(find "$MONITOR_DIR" -type f -exec du -b {} + | sort -n | tail -1)
if [ -n "$largest_file" ]; then
  echo "$(date): Largest file: $largest_file" >> "$LOG_FILE"
fi
