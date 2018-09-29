#!/bin/sh
#I know watch exists but I don't care.
while true
do
	wget -q -O - http://ipinfo.io/ip
	sleep 1m
done
