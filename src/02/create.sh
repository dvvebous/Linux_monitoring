#!/bin/bash

checkMemory() {
    free_space=$(df -Th -k / | awk 'NR==2 {print $5}') 
    result=$(echo "$free_space > 1048576" | bc -l)
    if ! [[ $result == "1" ]]; then
      echo "0"
    else
        echo "1"
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
    while [ $count -gt 0 ] && [[ $(checkMemory) == "1" ]]
    do
    echo "$PWD/$DirName$Date --- $(date +'%d %b %Y %H:%M:%S')" >> $pathLogfile
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
    while [ $count -gt 0 ] && [[ $(checkMemory) == "1" ]]
    do
        sudo touch "$PWD/$BaseNameFile$Date.$SymbolsEx"
        echo "$PWD/$BaseNameFile$Date.$SymbolsEx --- $(date +'%d %b %Y %H:%M:%S') --- "$SizeFiles"Mb" >> $pathLogfile
        # sudo sh -c "head -c "$sizeFiles"M < /dev/urandom > $BaseNameFile$Date.$SymbolsEx"
        sudo dd if=/dev/zero of=$BaseNameFile$Date.$SymbolsEx bs=1024 count=$(($SizeFiles * 1024))
        local count=$((count - 1))
        BaseNameFile=$(makeNewName $BaseNameFile $SymbolsName)
    done
}