#!/bin/bash

checkMemory() {
    free_space=$(df -Th / | awk 'NR==2 {print $5}' | sed 's/G//') 
    result=$(echo "$free_space > 1" | bc -l)
    echo $result
    if ! [[ $result == "1" ]]; then
      echo "STOP"
    fi
}

makeNewName() {
    oldName=$1
    syms=$2
    l=${#syms}
    newName="$oldName${syms:l-1:1}"
    echo $newName
}

makeBaseName() {
    len=4
    symbols=$1
    DirName=$1
    while [ "$len" -gt "${#DirName}" ]; do length=${#symbols} DirName="$DirName${symbols:length-1:1}"; done
    echo $DirName
}


createDirAndFiles() {
    local count=$((CountDirs))
    DirName="$(makeBaseName $SymbolsDirs)"
    while [ $count -gt 0 ]
    do
    echo "$DirName$Date --- $(date +'%d %b %Y %H:%M:%S')" >> log.log
    mkdir "$DirName$Date" && cd "$DirName$Date"
    makeFiles $DirName
    cd ../
    local count=$((count - 1))
    DirName=$(makeNewName $DirName $SymbolsDirs)
    done
}

makeFiles() {
    echo $1
    curDir=$1
    local count=$((CountFiles))
    BaseNameFile="$(makeBaseName $SymbolsName)"
    while [ $count -gt 0 ]
    do
    echo "$curDir$Date/$BaseNameFile$Date.$SymbolsEx --- $(date +'%d %b %Y %H:%M:%S') --- "$SizeFiles"Kb" >> ../log.log
    head -c "$sizeFiles"K < /dev/urandom > "$BaseNameFile$Date.$SymbolsEx"
    local count=$((count - 1))
    BaseNameFile=$(makeNewName $BaseNameFile $SymbolsName)
    if [[ $(checkMemory) == "STOP" ]]; then
        exit
    fi
    done
}