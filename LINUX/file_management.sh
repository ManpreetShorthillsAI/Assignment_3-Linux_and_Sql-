#!/bin/bash

mkdir -p sorted_files

mv sample_files/* sorted_files/


largest_file=$(find sorted_files -type f -exec ls -s {} + | sort -n -r | head -n 1 | awk '{print $2}')


echo "The largest file is: $largest_file"
