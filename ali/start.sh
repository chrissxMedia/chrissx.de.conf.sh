#!/bin/sh

service postfix start
service dovecot start
service opendkim start

while true ; do
        sleep 10
done
