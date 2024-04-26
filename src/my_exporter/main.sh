#!/bin/bash

while true; do
    avg_load=$(awk '{ print $1 }' /proc/loadavg )
    memAvailable=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
    memAvailable=$(echo "scale=2; $memAvailable / 1024 / 1024" | bc -l)
    rom=$(df / | awk ' /^\/dev/ { print $4 }'| sed 's/[A-Za-z]*$//')
    rom=$(echo "scale=2; $rom / 1024 / 1024" | bc -l )
    echo $rom
    echo -e  "# HELP avg_cpu_load" > metrics
    echo -e  "# TYPE avg_cpu_load gauge" >> metrics
    echo -e  "avg_load $avg_load" >> metrics
    echo -e  "# HELP free_RAM" >> metrics
    echo -e  "# TYPE free_RAM gauge" >> metrics
    echo -e  "free_RAM $memAvailable" >> metrics
    echo -e  "# HELP free_ROM" >> metrics
    echo -e  "# TYPE free_ROM gauge" >> metrics
    echo -e  "free_ROM $rom" >> metrics
    sleep 5
done