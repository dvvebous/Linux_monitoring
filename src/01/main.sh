#!/bin/bash

# 1. Проверки на количество аргументов, правильность пути, на количество символов в названиях и расширениях файлов, на размер файлов
# 2. Логи по созданным файлам
# 3. Условие на 1 Гб

# Нужно обойти ограничение в 255 символов на название файлов

source ./check.sh
source ./create.sh

resultCheck=$(Check $1 $2 $3 $4 $5 $6)
if [[ $resultCheck =~ ^[1]$ ]]; then
    Date="_$(date +'%d%m%y')"
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


