#!/bin/sh

while true; do
        echo "CPU  $(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+    $5)} END {print usage "%"}') "
        sleep 1
done
