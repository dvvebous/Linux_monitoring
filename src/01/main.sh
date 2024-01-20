#!/bin/bash

# 1. Проверки на количество аргументов, правильность пути, на количество символов в названиях и расширениях файлов, на размер файлов
# 2. Логи по созданным файлам
# 3. Условие на 1 Гб

# Нужно обойти ограничение в 255 символов на название файлов

source ./check.sh

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
    echo "$DirName$Date" >> log.log
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
    echo "$curDir$Date/$BaseNameFile$Date.$SymbolsEx" >> ../log.log
    head -c "$sizeFiles"K < /dev/urandom > "$BaseNameFile$Date.$SymbolsEx"
    local count=$((count - 1))
    BaseNameFile=$(makeNewName $BaseNameFile $SymbolsName)
    if [[ $(checkMemory) == "STOP" ]]; then
        exit
    fi
    done
}

resultCheck=$(Check $1 $2 $3 $4 $5 $6)
if [[ $resultCheck =~ ^[1]$ ]]; then
    Date="_$(date +%D | sed 's/\///' | sed 's/\///')"
    Path=$1
    CountDirs=$2
    SymbolsDirs=$3
    CountFiles=$4
    SymbolsFiles=$5
    SizeFiles=$6
    SizeFiles=${SizeFiles%"kb"}
    IFS='.' read -a parts <<< "$SymbolsFiles"
    SymbolsName=${parts[0]}
    SymbolsEx=${parts[1]}
    cd $1
    createDirAndFiles
else
    echo "$resultCheck"
fi


