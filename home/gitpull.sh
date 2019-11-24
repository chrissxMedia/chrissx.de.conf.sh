#!/bin/sh
while true
do
        cd /var/www/html
        git pull
        cd /var/gopher
        git pull
        cd /var/www/zerm
        git pull
        sleep 60
done
