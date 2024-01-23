#!/bin/bash


source ./check.sh
source ./create.sh


result=$(Check $1 $2 $3)
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

    path=$(sudo find / -type d \( ! -path "*bin*" -a ! -path "*sbin*" ! -path "*proc*" ! -path "*sys*" \) | shuf -n 1)
    cd $path
    countDirs=$((RANDOM % (100) + 1))
    createDirAndFiles $path $countDirs
    done
else
    echo "$result"
fi
