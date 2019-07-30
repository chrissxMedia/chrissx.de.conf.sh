#!/bin/sh
sudo echo "Got root."
openssl dhparam -out tmp.pem 4096
sudo rm /etc/ssl/private/dhparams.pem
sudo mv tmp.pem /etc/ssl/private/dhparams.pem
