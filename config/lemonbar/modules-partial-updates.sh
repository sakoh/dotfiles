#!/usr/bin/bash

PANEL_FIFO=/tmp/panel-fifo

[ -e $PANEL_FIFO ] && rm $PANEL_FIFO 
mkfifo $PANEL_FIFO

Desktops() {
	while true; do
		DESKTOPS=$(python $HOME/.config/lemonbar/desktops.py)

		echo "DESKTOPS $DESKTOPS"
		sleep 0.5
	done 	
}

ActiveWindow() {
	while true; do
		len=$(echo -n "$(xdotool getwindowfocus getwindowname)" | wc -m)
		max_len=70
		if [ "$len" -gt "$max_len" ];then
			echo "ACTIVE_WINDOW $(xdotool getwindowfocus getwindowname | cut -c 1-$max_len)..."
		else
			echo "ACTIVE_WINDOW $(xdotool getwindowfocus getwindowname)" 
		fi
		sleep 1
	done
}

Clock() {
	while true; do
		TIME=$(date "+%H:%M:%S")
		echo -e "CLOCK %{B#81a1c1}%{F#2e3440} \uf017 ${TIME} %{B-}%{F-}" 
		sleep 1;
	done
}

Battery() {
	while true; do
        	BATPERC="$(acpi | awk '{print $4}' | sed 's/,//g')"
		BAT="$(acpi | awk '{print $4}' | sed 's/%,//g')"

		if [[ "$(acpi | awk '{print $3}')" == 'Charging,' ]]; then
        		ICON="\uf5e7"
		elif [[ $BAT -ge 90 ]]; then
			ICON="\uf240"
		elif [[ $BAT -ge 75 ]]; then	
			ICON="\uf241"
		elif [[ $BAT -ge 50 ]]; then
			ICON="\uf242"
		elif [[ $BAT -ge 25 ]]; then
			ICON="\uf243"
		else
			ICON="\uf244"
		fi

		echo -e "BATTERY %{B#a3be8c}%{F#2e3440} $ICON $BATPERC %{B-}%{F-}" 
		sleep 1
	done 
}

Sound() {
	while true; do
		BGCOLOR="#ebcb8b"
		FGCOLOR="#2e3440"
		NOTMUTED=$( amixer sget Master | grep "\[on\]" )
		VOL=$(awk -F"[][]" 'NR==6{ print $2 }' <(amixer sget Master) | sed 's/%//g')
		if [[ ! -z $NOTMUTED ]] ; then
			if [[ $VOL -ge 50 ]]; then
				echo -e "SOUND %{A:alacritty -e alsamixer:}%{B$BGCOLOR}%{F$FGCOLOR} \uf028 $VOL% %{B-}%{F-}%{A}" 
			elif [[$VOL -eq 0 ]]; then
				echo -e "SOUND %{A:alacritty -e alsamixer:}%{B$BGCOLOR}%{F$FGCOLOR} \uf026 $VOL% %{B-}%{F-}%{A}" 
			else
				echo -e "SOUND %{A:alacritty -e alsamixer:}%{B$BGCOLOR}%{F$FGCOLOR} \uf027 $VOL% %{B-}%{F-}%{A}" 
			fi
		else		
			echo -e "SOUND %{A:alacritty -e 'ls':}%{B$BGCOLOR}%{F$FGCOLOR} \uf026 Muted %{B-}%{F-}%{A}" 
		fi
		
		sleep 1;
	done
}

Wifi() {
	while true; do
		STATE=$(connmanctl state | awk 'NR == 1 {print $3}')
		BGCOLOR="#b48ead"	
		if [[ $STATE == "online" ]]; then
			echo "WIFI %{B$BGCOLOR}%{F#2e3440}  $(connmanctl services | awk 'NR == 1 {print $2}') %{B-}%{F-}" 
		else
			echo "WIFI %{B$BGCOLOR}%{F#2e3440}睊Not Connected %{B-}%{F-}" 
		fi
	
		sleep 10;
	done
}

Desktops > $PANEL_FIFO &
ActiveWindow > $PANEL_FIFO &
Sound > $PANEL_FIFO &
Wifi > $PANEL_FIFO &
Clock > $PANEL_FIFO &
Battery > $PANEL_FIFO &

while read -r line; do
	case $line in
		DESKTOPS*)
			fn_desktop="${line#DESKTOPS }"
			;;
		ACTIVE_WINDOW*)
			fn_active_window="${line#ACTIVE_WINDOW }"
			;;
		SOUND*)
			fn_sound="${line#SOUND }"
			;;
		WIFI*)
			fn_wifi="${line#WIFI }"
			;;
		CLOCK*)
			fn_clock="${line#CLOCK }"
			;;
		BATTERY*)
			fn_battery="${line#BATTERY }"
			;;
	esac
	printf "%s\n" "%{l}$fn_desktop  $(echo $fn_active_window | sed 's/ACTIVE_WINDOW//g' )  %{r}$fn_sound$fn_wifi$fn_clock$fn_battery" 
done < $PANEL_FIFO 

