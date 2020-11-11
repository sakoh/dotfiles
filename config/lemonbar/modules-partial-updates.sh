#!/usr/bin/bash

#colors
RED="#bf616a"
GREEN="#a3be8c"
YELLOW="#ebcb8b"
MAGENTA="#b48ead"
CYAN="#88c0d0"
FROSTGREEN="#8fbcbb"

PANEL_FIFO=/tmp/panel-fifo

[ -e $PANEL_FIFO ] && rm $PANEL_FIFO
mkfifo $PANEL_FIFO

ActiveWindow() {
	while true; do
		echo "ACTIVEWINDOW $(xdotool getwindowfocus getwindowname)"
		sleep 1
	done
}

Desktops() {
	while true; do
		DESKTOPS=$(python $HOME/.config/lemonbar/desktops.py)

		echo "DESKTOPS $DESKTOPS"
		sleep 0.5
	done
}

Clock() {
	while true; do
		TIME=$(date -u "+%H:%M:%S")
		echo -e "CLOCK %{F$MAGENTA} \uf017 ${TIME} %{F-}"
		sleep 1;
	done
}

Battery() {
	while true; do
        	BATPERC="$(acpi | awk '/Battery 0:/ {print $4}' | sed 's/,//g')"
		BAT="$(acpi | awk '/Battery 0:/ {print $4}' | sed 's/%,//g')"

		if [[ "$(acpi | awk '/Battery 0:/ {print $3}')" == 'Charging,' ]]; then
        		ICON="\uf5e7"
			FGCOLOR=$GREEN
		elif [[ $BAT -ge 90 ]]; then
			ICON="\uf240"
			FGCOLOR=$GREEN
		elif [[ $BAT -ge 50 ]]; then
			ICON="\uf241"
			FGCOLOR=$GREEN
		elif [[ $BAT -ge 25 ]]; then
			ICON="\uf242"
			FGCOLOR=$YELLOW
		else
			ICON="\uf244"
			FGCOLOR=$RED
		fi

		echo -e "BATTERY %{A:$HOME/.config/rofi/scripts/power:}%{F$FGCOLOR} $ICON $BATPERC %{F-}%{A-} "
		sleep 2
	done
}

Sound() {
	while true; do
		NOTMUTED=$( amixer -c 1 sget Master | grep "\[on\]" )
		VOL=$(amixer -c 1 sget Master | awk -F'[][]' 'NR==5 {print $2}' | sed 's/%//g')
		if [[ ! -z $NOTMUTED ]] ; then
			OUTPUT="$VOL%"
			if [[ $VOL -ge 50 ]]; then
				FGCOLOR=$GREEN
				ICON="\uf028"
			elif [[$VOL -le 0 ]]; then
				FGCOLOR=$RED
				ICON="\uf026"
			else
				FGCOLOR=$YELLOW
				ICON="\uf027"
			fi
		else
			FGCOLOR=$RED
			OUTPUT="Muted"
			ICON="\uf026"
		fi

		echo -e "SOUND %{A:alacritty -e alsamixer:}%{F$FGCOLOR} $ICON $OUTPUT %{A}%{F-}"
		sleep 1;
	done
}

Wifi() {
	while true; do
		STATE=$(connmanctl state | awk 'NR == 1 {print $3}')
		FGCOLOR=$MAGENTA
		if [[ $STATE == "online" ]]; then
			echo "WIFI %{A:$HOME/.config/rofi/scripts/wifi:}%{F$FGCOLOR}  Connected %{F-}%{A}"
		else
			echo "WIFI %{A:$HOME/.config/rofi/scripts/wifi:}%{F$FGCOLOR} 睊Not Connected %{F-}%{A}"
		fi

		sleep 3;
	done
}

#CheckUpdates() {
	#while true; do
		#UPDATES=$(checkupdates | wc -l)
		#echo -e "CHECKUPDATES %{A:alacritty -e sudo xbps-install -Suv:}%{B$CYAN}%{F$FGCOLOR} \uf466 $UPDATES %{B-}%{F-}%{A}"
		#sleep 10;
	#done
#}

Memory() {
	while true; do
		echo -e "MEMORY %{F$FROSTGREEN} \uf538 $(free -h | awk '/^Mem:/ {print $3 "/" $2}') %{F-}"
		sleep 1;
	done
}

Temperature() {
	while true; do
		TEMP=$(sensors | awk '/temp1: / {print $2 }' | awk 'NR==2 {print}')
		OUTPUT=$(python $HOME/.config/lemonbar/temperature.py $TEMP)

		echo -e "TEMPERATURE $OUTPUT"
		sleep 0.5;
	done
}

Storage() {
	while true; do
		ICON="\uf1c0"
		AVAILABLE=$(df -h | awk '/nvme0n1p2/ {print $4}' | sed 's/G//g')
		SIZE=$(df -h | awk '/nvme0n1p2/ {print $2}')

		echo -e "STORAGE %{F$GREEN} $ICON $AVAILABLE/$SIZE %{F-}"
		sleep 2;
	done
}

Desktops > $PANEL_FIFO &
Sound > $PANEL_FIFO &
Wifi > $PANEL_FIFO &
Clock > $PANEL_FIFO &
Battery > $PANEL_FIFO &
#CheckUpdates > $PANEL_FIFO &
Memory > $PANEL_FIFO &
Temperature > $PANEL_FIFO &
Storage > $PANEL_FIFO &
ActiveWindow > $PANEL_FIFO &

while read -r line; do
	case $line in
		DESKTOPS*)
			fn_desktop="${line#DESKTOPS }"
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
		#CHECKUPDATES*)
			#fn_checkupdates="${line#CHECKUPDATES }"
			#;;
		MEMORY*)
			fn_memory="${line#MEMORY }"
			;;
		TEMPERATURE*)
			fn_temperature="${line#TEMPERATURE }"
			;;
		STORAGE*)
			fn_storage="${line#STORAGE }"
			;;
		ACTIVEWINDOW*)
			fn_active_window="${line#ACTIVEWINDOW}"
			;;
	esac
	printf "%s\n" "%{l}$fn_desktop $fn_active_window %{r}$fn_sound $fn_wifi $fn_temperature $fn_storage $fn_memory $fn_clock $fn_battery"
done < $PANEL_FIFO

