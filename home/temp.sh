#!/bin/sh
watch "echo $(/opt/vc/bin/vcgencmd measure_temp | awk -F = '{print $2}' | awk -F \' '{print $1}')°C"
