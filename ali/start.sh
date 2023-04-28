#!/bin/sh
set -uxe

service postfix start
service dovecot start
service opendkim start

while true ; do
        sleep 10
        service postfix status
        service dovecot status
        service opendkim status
done
