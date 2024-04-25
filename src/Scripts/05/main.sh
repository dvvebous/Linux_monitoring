#!/bin/bash

if [[ "$#" -ne 1 ]]; then
    echo "NEED option information"
fi

if [[ "$1" = "1" ]]; then
    awk '{arr[$9] = arr[$9] $0 "\n"} END {for (i in arr) print arr[i] }' ../04/*.log > 1.txt
elif [[ "$1" = "2" ]]; then
    awk '{arr[$1]++} END {for (i in arr) print i}' ../04/*.log > 2.txt
elif [[ "$1" = "3" ]]; then
    awk '$9 ~ /^4/ || $9 ~ /^5/' ../04/*.log > 3.txt
elif [[ "$1" = "4" ]]; then
    awk '$9 ~ /^4/ || $9 ~ /^5/' ../04/*.log |  awk '{arr[$1]++} END {for (i in arr) print i}' > 4.txt
else
    echo 2
fi