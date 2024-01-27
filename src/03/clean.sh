#!/bin/bash

logFileClearing() {
    echo "Start removal"
    logs="$(cat ../02/log.log | awk -F'  ' '{print $1}'))"
    reg='^\/'
    for i in $logs:
    do
        if [[ $i =~ $reg ]]
        then
            sudo rm -rf $i
        fi
    done
    echo "Done removal"
    echo -e "After deleting free space: \n$(df -h /)"
}

dateTimeClearing() {
    if [[ -n $2 ]] && [[ -n $3 ]]; then
        $START_TIME="$2"
        $END_TIME="$3"
    else
        echo "Input should be like: $(date '+%Y-%m-%d %H:%M:%S')"
        read -p "Enter the beginning of the search range for files to delete, date and time: " START_TIME
        read -p "Enter the end of the file search range to delete, date: " END_TIME
    fi
    echo -e "deleting files created from "$START_TIME" to "$END_TIME"...\n"
    sudo bash -c "find / -newermt '$START_TIME' -not -newermt '$END_TIME' 2>/dev/null | xargs rm -r 2>/dev/null"
    echo "Done removal"
    echo -e "After deleting free space: \n$(df -h /)"
}

nameMaskClearing() {
    echo "Input slould be like: foldername_$(date '+%d%m%y') or filename.ext_$(date '+%d%m%y')"
    read -p "Enter the namemask: " nameMask
    regMask='.*_[0-3]?[0-9][0-1]?[0-9][0-9]{2}.*'
    if [[ $nameMask =~ $regMask ]]; then
        sudo find / -name "$nameMask" -exec rm -rf {} \; 2>/dev/null
        sudo find / -name "$nameMask" -exec rm -f {} \; 2>/dev/null
        echo "Done"
        echo -e "After deleting free space: \n$(df -h /)"
    else
        echo "The wrong mask, check format"
    fi

}