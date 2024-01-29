#!/bin/bash 

listPanelBlock=("VISITORS" "REQUESTS" "REQUESTS_STATIC" "NOT_FOUND" 
"HOSTS" "OS" "BROWSERS" "VISIT_TIMES" "VIRTUAL_HOSTS" 
"REFERRERS" "REFERRING_SITES" "KEYPHRASES" "STATUS_CODES"
"REMOTE_USER" "CACHE_STATUS" "GEO_LOCATION" "MIME_TYPE" "TLS_TYPE")
# str="$(IFS=,; echo "${listPanelBlock[*]}")"
# for ((i=0; i<=17; i++ )); do
#     echo -e "--ignore-panel=${listPanelBlock[$i]} " >> 1.txt
# done
str="--ignore-panel=VISITORS --ignore-panel=REQUESTS --ignore-panel=REQUESTS_STATIC --ignore-panel=NOT_FOUND --ignore-panel=HOSTS --ignore-panel=OS --ignore-panel=BROWSERS --ignore-panel=VISIT_TIMES --ignore-panel=VIRTUAL_HOSTS --ignore-panel=REFERRERS --ignore-panel=REFERRING_SITES --ignore-panel=KEYPHRASES --ignore-panel=REMOTE_USER --ignore-panel=CACHE_STATUS --ignore-panel=GEO_LOCATION --ignore-panel=MIME_TYPE --ignore-panel=TLS_TYPE"
if [[ "$1" = "1" ]]; then
    goaccess -p goaccess_conf/goaccess1.conf ../04/*.log -o 1.html 
elif [[ "$1" = "2" ]]; then
    goaccess -p goaccess_conf/goaccess2.conf ../04/*.log -o 2.html 
elif [[ "$1" = "3" ]]; then
    goaccess -p goaccess_conf/goaccess3.conf ../04/*.log -o 3.html 
elif [[ "$1" = "4" ]]; then
     goaccess -p goaccess_conf/goaccess4.conf ../04/*.log -o 4.html 
else
    addon=3
fi
# echo "$addon"
# addon="--sort-panel=STATUS_CODE,BY_DATA,DESC" 
# goaccess  ../04/access_log_1.log "$str" --enable-panel=STATUS_CODE --sort-panel="STATUS_CODE,BY_DATA,ASC" --log-format=COMBINED -o "$1".html
# #goaccess  ../04/access_log_1.log "$str" --enable-panel=STATUS_CODE "$addon"  --log-format=COMBINED  -o "$1".html