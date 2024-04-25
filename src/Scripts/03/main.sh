#!/bin/bash

source ./clean.sh
echo -e "Current free space: \n$(df -h /)"
if [[ "$1" = "1" ]]; then
   logFileClearing
elif [[ "$1" = "2" ]]; then
    dateTimeClearing
elif [[ "$1" = "3" ]]; then
    nameMaskClearing
else
    echo "Check the parameter at startup, the parameter can be a number from 1 to 3"
fi

