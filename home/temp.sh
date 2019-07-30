#!/bin/sh
#I know watch exists but I don't care.
while true
do
	echo $(echo $(echo $(/opt/vc/bin/vcgencmd measure_temp) | awk -F = '{print $2}') | awk -F \' '{print $1}')°C
	sleep 1s
done
