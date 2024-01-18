#!/bin/bash

# 1. Проверки на количество аргументов, правильность пути, на количество символов в названиях и расширениях файлов, на размер файлов
# 2. Логи по созданным файлам
# 3. Условие на 1 Гб

source ./check.sh

# echo "$1"
# echo "$2"
# echo "$3"
# echo "$4"
# echo "$5"
# echo "$6"
makeBaseName() {
    len=4
    symbols=$1
    DirName=$1
    while [ "$len" -gt "${#DirName}" ]; do length=${#symbols} DirName="$DirName${symbols:length-1:1}"; done
    echo $DirName
}


createDirAndFiles() {
    countDir=$1
    DirName=$2
    lastSymbol=$3
    while [ countDir -gt 0]
    do
    #Надо добавить еще дату от к названию папки
    mkdir $DirName && cd $DirName
    makeFiles $4 $5 $6

    countDir-=1
    done
}

makeFiles() {
    countFiles=$1
    symbolsFiles=$2
    sizeFiles=$3
    BaseNameFile=$(makeBaseName $symbolsFiles)
    while [ countFiles -gt 0]
    do
    head -c "$sizeFiles" < /dev/urandom > $BaseNameFile
    done
}

resultCheck=$(Check $1 $2 $3 $4 $5 $6)
if [[ $resultCheck =~ ^[1]$ ]]; then
    cd $1
    BaseDirName=$(makeBaseName $3)

else
    echo "$resultCheck"
fi


