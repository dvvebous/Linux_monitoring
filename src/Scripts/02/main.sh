#!/bin/bash


source ./check.sh
source ./create.sh

startTime=$(date +%s)
result=$(Check $1 $2 $3)

if [[ -f './log.log' ]]; then
    rm -f log.log
fi

if [[ $result =~ ^[1]$ ]]; then
    touch log.log
    pathLogfile="$(pwd log.log)/log.log"
    echo $pathLogfile
    Date="_$(date +'%d%m%y')"
    SymbolsDirs=$1
    SymbolsFiles=$2
    SizeFiles=$3
    SizeFiles=${SizeFiles%"Mb"}
    IFS='.' read -a parts <<< "$SymbolsFiles"
    SymbolsName=${parts[0]}
    SymbolsEx=${parts[1]}
    while [[ $(checkMemory) == "1" ]]
    do
        path=$(sudo find / -type d \( ! -path "*bin*" -a ! -path "*sbin*" -a ! -path "*proc*" -a ! -path "*sys*" \) | shuf -n 1)
        cd $path
        countDirs=$((RANDOM % (100) + 1))
        createDirAndFiles $path $countDirs
    done
    endTime=$(date +%s)
    totalTime=$(($endTime - $startTime))
    startFormatted=$(date -d "@$startTime" +"%d_%b_%Y_%H:%M:%S")
    endFormatted=$(date -d "@$endTime" +'%d_%b_%Y_%H:%M:%S')
    echo "Start: $startFormatted" >> $pathLogfile
    echo "End: $endFormatted" >> $pathLogfile
    echo "Work time: $totalTime" >> $pathLogfile
else
    echo "$result"
fi
