#!/bin/bash
Check() {
    SizeFiles=$3
    SizeFiles=${SizeFiles%"Mb"}
    if [ "$#" -ne 3 ]; then
    #Формулировка кала  
    echo "Not enough or too many arguments"
    elif ! [[ $1 =~ ^[a-zA-Z]{1,7}$ ]]; then
        echo -e "The parameter must consist of a list of letters of the English alphabet and no more than 7 characters. Your input: $1"
    elif ! [[ $2 =~ ^[a-zA-Z]{1,7}.[a-zA-Z]{1,3}$ ]]; then
        echo -e "the list must consist of letters of the English alphabet used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension). Your input: $5"
    # Можно ввести ноль и тогда пройдет
    elif ! [[ $((SizeFiles)) -lt 100 ]] ; then
        echo -e "The file size must be less than 100 Mb. Your input: $3"
    else
         echo "1"
    fi
}