#!/bin/bash


source ./check.sh


result=$(Check $1 $2 $3)
if [[ $result =~ ^[1]$ ]]; then
    echo "NICE"
else
    echo "$result"
fi
