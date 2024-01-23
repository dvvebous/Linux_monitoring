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
    len=5
    symbols=$1
    DirName=$1
    while [ "$len" -gt "${#DirName}" ]; do length=${#symbols} DirName="$DirName${symbols:length-1:1}"; done
    echo $DirName
}

createDirAndFiles() {
    cd $1
    local count=$(($2))
    DirName="$(makeBaseName $SymbolsDirs)"
    while [ $count -gt 0 ]
    do
    echo "$PWD/$DirName$Date" >> $pathLogfile
    sudo mkdir "$DirName$Date" && cd "$DirName$Date"
    makeFiles $DirName
    cd ../
    local count=$((count - 1))
    DirName=$(makeNewName $DirName $SymbolsDirs)
    done
}

makeFiles() {
    curDir=$1
    local count=$((RANDOM % (100) + 1))
    BaseNameFile="$(makeBaseName $SymbolsName)"
    while [ $count -gt 0 ]
    do
    echo "$PWD/$DirName$Date/$curDir$Date/$BaseNameFile$Date.$SymbolsEx"
    echo "$PWD/$DirName$Date/$curDir$Date/$BaseNameFile$Date.$SymbolsEx" >> $pathLogfile
    head -c "$sizeFiles"M < /dev/urandom > "$BaseNameFile$Date.$SymbolsEx"
    local count=$((count - 1))
    BaseNameFile=$(makeNewName $BaseNameFile $SymbolsName)
    if [[ $(checkMemory) == "STOP" ]]; then
        exit
    fi
    done
}