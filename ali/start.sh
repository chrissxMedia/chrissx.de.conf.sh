#!/bin/sh
set -uxe

service postfix start
service dovecot start
service opendkim start

while true ; do
        sleep 10
        service postfix status >/dev/null 2>/dev/null || service postfix status
        service dovecot status >/dev/null 2>/dev/null || service dovecot status
done
