#!/bin/bash

while true; do
	ICON=""
	AVAILABLE=$(df -h | awk 'NR==5 {print $4}' | sed 's/G//g')
	SIZE=$(df -h | awk 'NR==5 {print $2}')

	echo "STORAGE $ICON $AVAILABLE/$SIZE "
	sleep 2;
done

