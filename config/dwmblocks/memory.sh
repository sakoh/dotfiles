#!/bin/sh

while true; do
        echo "MEMORY  $(free -h | awk '/^Mem:/ {print $3 "/" $2}') "
        sleep 1;
done

