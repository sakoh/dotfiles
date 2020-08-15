#!/usr/bin/bash

#Format the bar
#Format(){
#	echo -n "%{B}#000000"
#}

Desktops() {
	DESKTOPS=$(python $HOME/.config/lemonbar/desktops.py)
	
	echo -n " $DESKTOPS "	
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

Clock() {
	TIME=$(date "+%H:%M:%S")
	echo -n " \uf017 ${TIME}" 
}

Battery() {
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

	echo -n "$ICON $BATPERC";
}

Sound() {
	NOTMUTED=$( amixer sget Master | grep "\[on\]" )
	VOL=$(awk -F"[][]" 'NR==6{ print $2 }' <(amixer sget Master) | sed 's/%//g')
	if [[ ! -z $NOTMUTED ]] ; then
		if [[ $VOL -ge 50 ]]; then
			echo -n "\uf028 $VOL%"
		elif [[$VOL -eq 0 ]]; then
			echo -n "\uf026 $VOL%"
		else
			echo -n "\uf027 $VOL%"
		fi
	else
		echo -n "\uf026 Muted" 
	fi
}

Wifi() {
	STATE=$(connmanctl state | awk 'NR == 1 {print $3}')
	
	if [[ $STATE == "online" ]]; then
		echo -n " $(connmanctl services | awk 'NR == 1 {print $2}')"
	else
		echo -n "睊Not Connected"
	fi
}

while true; do
        echo -e "%{l}$(Desktops) $(ActiveWindow) %{r}$(Sound) $(Wifi)  $(Clock)  $(Battery)  "
        sleep 0.1;
done

