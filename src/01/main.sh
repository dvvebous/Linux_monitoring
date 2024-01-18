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
makeBaseDirName() {

    #НА
    len=$1
    symbols=$2
    DirName=$2
    while [ "$len" -gt "${#DirName}" ]
    do
    length=${#symbols}
    DirName="$DirName${symbols:length-1:1}"
    done
    echo $DirName
}

resultCheck=$(Check $1 $2 $3 $4 $5 $6)
if [[ $resultCheck =~ ^[1]$ ]]; then
    cd $1
    BaseDirName=$(makeBaseDirName $2 $3)
    echo $BaseDirName
else
    echo "$resultCheck"
fi


