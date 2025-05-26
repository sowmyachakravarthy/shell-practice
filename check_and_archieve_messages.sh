#!/bin/bash

# Path to the messages file
LOG_FILE="/var/log/messages"

# Date in DDMMYYYY format
DATE=$(date +%d%m%Y)

# Get the usage percentage of /var (just the number)
VAR_USAGE=$(df /var | awk 'NR==2 {gsub("%",""); print $5}')

# Compressed file name
ARCHIVE_FILE="/tmp/messages_${DATE}.gz"

# Destination path
DEST_PATH="/var/log"

# Get file size in bytes
FILE_SIZE=$(stat -c%s "$LOG_FILE")

# Show file size
echo "Current /var/log/messages size: $FILE_SIZE bytes"

# Check if the var usage is greater than or equal to 90
if [ "$VAR_USAGE" -ge 90 ]; then
    echo "/var is above 90% full. Compressing messages file..."

    # Compress the messages file to /tmp
    gzip -c "$LOG_FILE" > "$ARCHIVE_FILE"

    # Nullify the original messages file (without deleting it)
    : > "$LOG_FILE"  # or use > "$LOG_FILE"

    # Move compressed file to /var/log/
    mv "$ARCHIVE_FILE" "$DEST_PATH/"

    echo "File moved to $DEST_PATH/messages_${DATE}.gz"

    # Optionally, empty the original file
    > "$LOG_FILE"
    echo "Original messages file cleared."
else
    echo "File is under threshold. No action needed."
fi