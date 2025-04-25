#!/bin/bash

BAT=$(echo /sys/class/power_supply/BAT*)
BAT_STATUS="$BAT/status"
BAT_CAP="$BAT/capacity"
LOW_BAT_PERCENT=20
LOW_BAT_SHUTDOWN=2

AC_PROFILE="performance"
BAT_PROFILE="balanced"
LOW_BAT_PROFILE="power-saver"

# wait a while if needed
[[ -z $STARTUP_WAIT ]] || sleep "$STARTUP_WAIT"

# start the monitor loop
prev=0

while true; do
	# read the current state
	if [[ $(cat "$BAT_STATUS") == "Discharging" ]]; then
		bat=$(cat "$BAT_CAP")
		if [[ $bat -le $LOW_BAT_SHUTDOWN ]]; then
			echo shutting down...
			notify-send -t 30000 power-monitor "shutting down..." &
			sleep 10
			poweroff
		elif [[ $bat -gt $LOW_BAT_PERCENT ]]; then
			profile=$BAT_PROFILE
		else
		  echo "low power $bat"
		  notify-send -t 30000 power-monitor "low power $bat" &
			profile=$LOW_BAT_PROFILE
		fi
	else
		profile=$AC_PROFILE
	fi

	# set the new profile
	if [[ $prev != "$profile" ]]; then
		echo setting power profile to $profile
		notify-send -t 5000 power-monitor $profile &
		powerprofilesctl set $profile
	fi

	prev=$profile

	# wait for the next power change event
	inotifywait -qq "$BAT_STATUS" "$BAT_CAP"
done
