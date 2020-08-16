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
	echo -n "%{B#81a1c1}%{F#2e3440} \uf017 ${TIME} %{B-}%{F-}" 
}

Battery() {
        BATPERC="$(acpi | awk '{print $4}' | sed 's/,//g')"
	BAT="$(acpi | awk '{print $4}' | sed 's/%,//g')"

	if [[ "$(acpi | awk '{print $3}')" == 'Charging,' ]]; then
        	ICON="\uf5e7"
		BGCOLOR="#a3be8c"
	elif [[ $BAT -ge 90 ]]; then
		ICON="\uf240"
		BGCOLOR="#a3be8c"
	elif [[ $BAT -ge 75 ]]; then	
		ICON="\uf241"
		BGCOLOR="#ebcb8b"
	elif [[ $BAT -ge 50 ]]; then
		ICON="\uf242"
		BGCOLOR="#ebcb8b"
	elif [[ $BAT -ge 25 ]]; then
		ICON="\uf243"
		BGCOLOR="#ebcb8b"
	else
		ICON="\uf244"
		BGCOLOR="#bf616a"	
	fi

	echo -n "%{B$BGCOLOR}%{F#2e3440} $ICON $BATPERC %{B-}%{F-}";
}

Sound() {
	NOTMUTED=$( amixer sget Master | grep "\[on\]" )
	VOL=$(awk -F"[][]" 'NR==6{ print $2 }' <(amixer sget Master) | sed 's/%//g')
	if [[ ! -z $NOTMUTED ]] ; then
		if [[ $VOL -ge 50 ]]; then
			echo -n "%{B#a3be8c}%{F#2e3440} \uf028 $VOL% %{B-}%{F-}"
		elif [[$VOL -eq 0 ]]; then
			echo -n "%{B#ebcb8b}%{F#2e3440} \uf026 $VOL% %{B-}%{F-}"
		else
			echo -n "%{B#ebcb8b}%{F#2e3440} \uf027 $VOL% %{B-}%{F-}"
		fi
	else
		echo -n "%{B#a3be8c}%{F#2e3440} \uf026 Muted " 
	fi
}

Wifi() {
	STATE=$(connmanctl state | awk 'NR == 1 {print $3}')
	
	if [[ $STATE == "online" ]]; then
		echo -n "%{B#88c0d0}%{F#2e3440}  $(connmanctl services | awk 'NR == 1 {print $2}') %{B-}%{F-}"
	else
		echo -n "%{B#88c0d0}%{F#2e3440}睊Not Connected %{B-}%{F-}"
	fi
}

while true; do
        echo -e "%{l}$(Desktops) $(ActiveWindow) %{r}$(Sound)$(Wifi)$(Clock)$(Battery)"
        sleep 0.1;
done

