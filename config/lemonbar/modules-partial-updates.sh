#!/usr/bin/bash

#colors
RED="#bf616a"
GREEN="#a3be8c"
YELLOW="#ebcb8b"
BLUE="#81a1c1"
MAGENTA="#b48ead"
CYAN="#88c0d0"

FGCOLOR="#2e3440"

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
		echo -e "ACTIVE_WINDOW $(xdotool getwindowfocus getwindowname) " 
		sleep 1
	done
}

Clock() {
	while true; do
		TIME=$(date "+%H:%M:%S")
		echo -e "CLOCK %{U$CYAN}%{F$CYAN} %{+u} \uf017 ${TIME} %{-u} %{U-}%{F-}  "
		sleep 1;
	done
}

Battery() {
	while true; do
        	BATPERC="$(acpi | awk '{print $4}' | sed 's/,//g')"
		BAT="$(acpi | awk '{print $4}' | sed 's/%,//g')"

		if [[ "$(acpi | awk '{print $3}')" == 'Charging,' ]]; then
        		ICON="\uf5e7"
			BGCOLOR=$GREEN
		elif [[ $BAT -ge 90 ]]; then
			ICON="\uf240"
			BGCOLOR=$GREEN
		elif [[ $BAT -ge 50 ]]; then	
			ICON="\uf241"
			BGCOLOR=$GREEN
		elif [[ $BAT -ge 25 ]]; then
			ICON="\uf242"
			BGCOLOR=$YELLOW
		else
			ICON="\uf244"
			BGCOLOR=$RED
		fi

		echo -e "BATTERY %{U$BGCOLOR}%{F$BGCOLOR} %{+u} $ICON $BATPERC %{-u} %{U-}%{F-} " 
		sleep 2
	done 
}

Sound() {
	while true; do
		NOTMUTED=$( amixer sget Master | grep "\[on\]" )
		VOL=$(awk -F"[][]" 'NR==6{ print $2 }' <(amixer sget Master) | sed 's/%//g')
		if [[ ! -z $NOTMUTED ]] ; then
			OUTPUT="$VOL%"
			if [[ $VOL -ge 50 ]]; then
				UGCOLOR=$GREEN
				ICON="\uf028"
			elif [[$VOL -le 0 ]]; then
				UGCOLOR=$RED
				ICON="\uf026"
			else
				UGCOLOR=$YELLOW
				ICON="\uf027"
			fi
		else	
			UGCOLOR=$RED
			OUTPUT="Muted"	
			ICON="\uf026"
		fi
		
		echo -e "SOUND %{A:alacritty -e alsamixer:}%{U$UGCOLOR}%{F$UGCOLOR} %{+u} $ICON $OUTPUT %{A} %{-u} %{U-}%{F-}"	
		sleep 1;
	done
}

Wifi() {
	while true; do
		STATE=$(connmanctl state | awk 'NR == 1 {print $3}')
		BGCOLOR=$MAGENTA	
		if [[ $STATE == "online" ]]; then
			echo "WIFI %{A:connman-gtk:}%{U$BGCOLOR}%{F$BGCOLOR} %{+u}  $(connmanctl services | awk 'NR == 1 {print $2}') %{-u} %{U-}%{F-}%{A}" 
		else
			echo "WIFI %{A:connman-gtk:}%{U$BGCOLOR}%{F$BGCOLOR} %{+u} 睊Not Connected %{-u} %{U-}%{F-}%{A}" 
		fi
	
		sleep 3;
	done
}

CheckUpdates() {
	while true; do
		UPDATES=$(pacman -Qu | wc -l)
		echo -e "CHECKUPDATES %{A:alacritty -e yay -Syu:}%{U$BLUE}%{F$BLUE} %{+u} \uf466 $UPDATES %{-u} %{U-}%{F-}%{A}"
		sleep 3600;
	done
}

Memory() {
	while true; do
		echo -e "MEMORY %{U$YELLOW}%{F$YELLOW} %{+u} \uf538 $(free -h | awk '/^Mem:/ {print $3 "/" $2}') %{-u} %{U-}%{F-}"
		sleep 1;
	done
}

Temperature() {
	while true; do
		echo -e "TEMPERATURE %{A:alacritty -e sensors:}%{U$RED}%{F$RED} %{+u} \uf2c7 $(sensors | awk 'NR==10 {print $2}') %{-u} %{U-}%{F-}%{A}"
		sleep 1;
	done
}

Desktops > $PANEL_FIFO &
ActiveWindow > $PANEL_FIFO &
Sound > $PANEL_FIFO &
Wifi > $PANEL_FIFO &
Clock > $PANEL_FIFO &
Battery > $PANEL_FIFO &
CheckUpdates > $PANEL_FIFO &
Memory > $PANEL_FIFO &
Temperature > $PANEL_FIFO &

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
		CHECKUPDATES*)
			fn_checkupdates="${line#CHECKUPDATES }"
			;;
		MEMORY*)
			fn_memory="${line#MEMORY }"
			;;
		TEMPERATURE*)
			fn_temperature="${line#TEMPERATURE }"
			;;
	esac
	printf "%s\n" "%{l}$fn_desktop  $(echo $fn_active_window | sed 's/ACTIVE_WINDOW//g' )  %{r}${fn_sound}${fn_wifi}${fn_temperature}${fn_memory}${fn_checkupdates}${fn_clock}${fn_battery}" 
done < $PANEL_FIFO 

