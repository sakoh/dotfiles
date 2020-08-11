#!/usr/bin/bash

#Format the bar
#Format(){
#	echo -n "%{B}#000000"
#}

Desktops() {
	echo -n $(python $HOME/.config/lemonbar/desktops.py)	
}

ActiveWindow() {
	len=$(echo -n "$(xdotool getwindowfocus getwindowname)" | wc -m)
	max_len=70
	if [ "$len" -gt "$max_len" ];then
		echo -n "$(xdotool getwindowfocus getwindowname | cut -c 1-$max_len)..."
	else
		echo -n "$(xdotool getwindowfocus getwindowname)"
	fi
}

Clock(){
	TIME=$(date "+%H:%M:%S")
	echo -n " \uf017 ${TIME}" 
}

Battery() {
        BATPERC="$(cat /sys/class/power_supply/BAT0/capacity)"
	case $BATPERC in
	9[0-9]|100)
	ICON="\uf240" ;;
	6[0-9]|7[0-9]|8[0-9])
	ICON="\uf241" ;;
	3[0-9]|4[0-9]|5[0-9])
	ICON="\uf242" ;;
	1[0-9|2[0-9])
	ICON="\uf243" ;;
	0|[0-9])
	ICON="\u244" ;;
	*)
	esac
        echo -n "$ICON $BATPERC%"
}

Sound() {
	NOTMUTED=$( amixer -c 1 sget Master | grep "\[on\]" )
	if [[ ! -z $NOTMUTED ]] ; then
		VOL=$(awk -F"[][]" '/dB/ { print $2 }' <(amixer -c 1 sget Master) | sed 's/%//g')
		if [ $VOL -ge 85 ] ; then
			echo -n "\uf028 ${VOL}%"
		elif [ $VOL -ge 50 ] ; then
			echo -n "\uf027 ${VOL}%"
		else
			echo -n "\uf026 ${VOL}%"
		fi
	else
		echo -n "\uf026 M"
	fi
}

while true; do
        echo -e " %{l}$(Desktops) %{c}$(ActiveWindow) %{r}$(Sound)  $(Clock)  $(Battery)  "
        sleep 0.1;
done
