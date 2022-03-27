#!/bin/bash

while true; do
        VOL=$(pamixer --get-volume)

        if [[ $VOL -ge 50 ]]; then
                #FGCOLOR=$GREEN
                ICON=""
        elif [[$VOL -le 0 ]]; then
                #FGCOLOR=$RED
                ICON=""
        else
                #FGCOLOR=$YELLOW
                ICON=""
        fi

        echo "SOUND $ICON $VOL% "
        sleep 1;
done
