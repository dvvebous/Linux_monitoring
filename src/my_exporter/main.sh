#!/bin/bash

while true; do
    avg_load=$(awk '{ print $1 }' /proc/loadavg )
    memAvailable=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
    memAvailable=$(echo "scale=2; $memAvailable / 1024 / 1024" | bc -l)
    rom=$(df / | awk ' /^\/dev/ { print $4 }'| sed 's/[A-Za-z]*$//')
    rom=$(echo "scale=2; $rom / 1024 / 1024" | bc -l )
    echo -e  "# HELP avg_cpu_load" > /var/www/html/metrics
    echo -e  "# TYPE avg_cpu_load gauge" >> /var/www/html/metrics
    echo -e  "avg_load $avg_load" >> /var/www/html/metrics
    echo -e  "# HELP free_RAM" >> /var/www/html/metrics
    echo -e  "# TYPE free_RAM gauge" >> /var/www/html/metrics
    echo -e  "free_RAM $memAvailable" >> /var/www/html/metrics
    echo -e  "# HELP free_ROM" >> /var/www/html/metrics
    echo -e  "# TYPE free_ROM gauge" >> /var/www/html/metrics
    echo -e  "free_ROM $rom" >> /var/www/html/metrics
    sleep 5
done