#!/bin/bash

Check() {
    if [ "$#" -ne 6 ]; then
    #Формулировка кала  
    echo "Not enough or too many arguments"
    elif ! [[ -d $1 ]]; then
        echo -e "Not correct path: $1"
    elif ! [[ $2 =~ [0-9]+$ ]]; then
        echo -e "The number of subfolders must be a number. Your input: $2"
    elif ! [[ $3 =~ ^[a-zA-Z]{1,7}$ ]]; then
        echo -e "The parameter must consist of a list of letters of the English alphabet and no more than 7 characters. Your input: $3"
    elif ! [[ $4 =~ [0-9]+$ ]]; then
        echo -e "The number of files in each created folder must be a number. Your input: $4"
    elif ! [[ $5 =~ ^[a-zA-Z]{1,7}.[a-zA-Z]{1,3}$ ]]; then
        echo -e "the list must consist of letters of the English alphabet used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension). Your input: $5"
    # Можно ввести ноль и тогда пройдет
    elif ! [[ $6 =~ ^[1-9]{1}[0-9]{1,2}kb$|(1[0]{2})kb$ ]] ; then
        echo -e "File size (in kilobytes, but not more than 100). Your input: $6"
    else
         echo "1"
    fi

}