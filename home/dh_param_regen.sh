#!/bin/sh
openssl dhparam -out tmp.pem 4096
sudo mv -f tmp.pem /etc/ssl/private/dhparams.pem
