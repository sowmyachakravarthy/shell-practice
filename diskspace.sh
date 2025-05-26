#!/bin/bash

# List of servers to check (you can replace this with an actual file or command)
server_list="servers.txt"

# Output file to store results
output_file="df_check_results.txt"

# Clear the output file
> "$output_file"

# Loop through each server
while read -r server; do
    echo "Checking $server..." >> "$output_file"
    
    ssh -o BatchMode=yes -o ConnectTimeout=5 "$server" "
        df -hP | awk '\$5+0 > 90 {print \"'$server' ->\", \$0}'
    " >> "$output_file" 2>>errors.log

done < "$server_list"

echo "Disk usage check completed. Results saved to $output_file"