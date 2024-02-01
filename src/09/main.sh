#!/bin/bash

while true; do
#CPU load
# cpu0=$(awk '/^cpu / {print $2 }' /proc/stat)
# nice0=$(awk '/^cpu / {print $3 }' /proc/stat)
# system0=$(awk '/^cpu / {print $4 }' /proc/stat)
# i0=$(awk '/^cpu / {print $5 }' /proc/stat)
# sleep 5
# cpu1=$(awk '/^cpu / {print $2 }' /proc/stat)
# nice1=$(awk '/^cpu / {print $3 }' /proc/stat)
# system1=$(awk '/^cpu / {print $4 }' /proc/stat)
# i1=$(awk '/^cpu / {print $5 }' /proc/stat)
# cpud=$(($cpu1-$cpu0))
# niced=$(($nice1-$nice0))
# systemd=$(($system1-$system0))
# id=$(($i1-$i0))
# total=$(($cpud+$niced+$systemd+$id))

avg_load=$(awk '{ print $1 }' /proc/loadavg )
echo $avg_load
#memAvailable
memAvailable=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
memAvailable=$(echo "scale=2; $memAvailable / 1024 / 1024" | bc -l)
#Rom
rom=$(df -h / | awk ' /^\/dev/ { print $4 }'| sed 's/[A-Za-z]*$//')

    echo -e "<html>" >> /var/www/html/index.html
    echo -e "  <head>" >> /var/www/html/index.html
    echo -e "  </head>" >> /var/www/html/index.html
    echo -e "  <body" >> /var/www/html/index.html
    echo -e  "<p>#  HELP avg_cpu_load</p>" >> /var/www/html/index.html
    echo -e  "<p># TYPE avg_cpu_load gauge </p>" >> /var/www/html/index.html
    echo -e  "<p>avg_load $avg_load</p>" >> /var/www/html/index.html
    echo -e  "<p>#HELP free_RAM</p>" >> /var/www/html/index.html
    echo -e  "<p>#TYPE free_RAM gauge</p>" >> /var/www/html/index.html
    echo -e  "<p>nfree_RAM $$memAvailable</p>" >> /var/www/html/index.html
    echo -e  "<p># HELP free_ROM take </p>" >> /var/www/html/index.html
    echo -e  "<p># TYPE free_ROM gauge</p>" >> /var/www/html/index.html
    echo -e  "<p>free_ROM $rom</p>" >> /var/www/html/index.html
    echo -e "  </body>" >> /var/www/html/index.html
    echo -e "</html>" >> /var/www/html/index.html
sleep 5
done
