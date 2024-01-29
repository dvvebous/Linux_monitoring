#!/bin/bash

hour=0
minute=0
second=0
response_codes=(200 201 400 401 403 404 500 501 502 503)
methods=("GET" "POST" "PUT" "PATCH" "DELETE")
agents=("Mozilla/5.0 (Windows NT 6.3; WOW64; rv:36.0) Gecko/20100101 Firefox/36.0"
"Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/53.0.2785.116 Safari/537.36"
"Opera/9.80 (Windows NT 6.2; WOW64) Presto/2.12.388 Version/12.17"
"Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/534.57.2 (KHTML, like Gecko) Version/5.1.7 Safari/534.57.2"
"Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; .NET4.0C; .NET4.0E; rv:11.0) like Gecko"
"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2486.0 Safari/537.36 Edge/40.15254.603"
"Mozilla/5.0 (iPhone; CPU iPhone OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25"
"Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5376e Safari/8536.25"
"Mozilla/5.0 (iPod; CPU iPhone OS 16_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/107.0.5304.66 Mobile/15E148 Safari/604.1")
months=("Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec")
years=("2023" "2022")
rm -f *.log
generate_ip() {
    echo "$((RANDOM % 255 + 1)).$((RANDOM % 256)).$((RANDOM % 256)).$((RANDOM % 256))"
}
generate_hour() {    
    printf ":%02d:%02d:%02d +0300" "$hour" "$minute" "$second"
}

generate_date() {
    day=$((RANDOM % 32 + 1))
    month=${months[$((RANDOM % ${#months[@]}))]}
    year=${years[$((RANDOM % ${#years[@]}))]}
    printf "$day/$month/$year"
}

generate_user_agent() {
    rand_index=$((RANDOM % ${#agents[@]}))
    echo "${agents[$rand_index]}"
}

for ((i = 1; i <= 5; i++)); do
    num_entries=$((RANDOM % 901 + 100))
    filename="access_log_$i.log"
    dmy=$(generate_date)
    for ((j = 1; j <= num_entries; j++)); do
        ip=$(generate_ip)
        code=${response_codes[$((RANDOM % ${#response_codes[@]}))]}
        method=${methods[$((RANDOM % ${#methods[@]}))]}
        dateGen="$dmy$(generate_hour)"
        second=$(($second+1))
        if [ $second -eq 60 ]; then
            second=0
            minute=$((minute + 1))
        fi
        if [ $minute -eq 60 ]; then
            minute=0
            hour=$((hour + 1))
        fi
        agent=$(generate_user_agent)
        url="/page/$j"
        byteSend=$((RANDOM % 100000))
        echo "$ip - - [$dateGen] \"$method $url HTTP/1.1\" $code $byteSend \"-\" \"$agent\"" >> "$filename"
    done
done
