#!/bin/sh
while true ; do
        cd /var/www/html
        git pull
        cd /var/gopher
        git pull
        cd /var/www/zerm
        git pull
        cd /var/www/apt
        git pull
        cd /var/www/ampless
        git pull
        sleep 300
done
