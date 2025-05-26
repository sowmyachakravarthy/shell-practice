#!/bin/bash

# Path to the messages file
LOG_FILE="/var/log/messages"

# Date in DDMMYYYY format
DATE=$(date +%d%m%Y)

# Compressed file name
ARCHIVE_FILE="/tmp/messages_${DATE}.gz"

# Destination path
DEST_PATH="/var/log"

# Get file size in bytes
FILE_SIZE=$(stat -c%s "$LOG_FILE")

# Show file size
echo "Current /var/log/messages size: $FILE_SIZE bytes"

# Check if the file is not empty
if [ "$FILE_SIZE" -gt 0 ]; then
    echo "File is consuming high space. Compressing and moving..."

    # Compress the messages file to /tmp
    gzip -c "$LOG_FILE" > "$ARCHIVE_FILE"

    # Move compressed file to /var/log/
    mv "$ARCHIVE_FILE" "$DEST_PATH/"

    echo "File moved to $DEST_PATH/messages_${DATE}.gz"

    # Optionally, empty the original file
    > "$LOG_FILE"
    echo "Original messages file cleared."
else
    echo "File is empty. No action needed."
fi