#!/bin/sh
#this script sets up new Pis with the required packages and configs.
#nano sucks, but it does not automatically insert comments
sudo raspi-config
sudo adduser --gecos "" aa
sudo adduser --gecos "" chrissx
sudo adduser --gecos "" babaex
sudo adduser --gecos "" postmaster
sudo adduser --gecos "" hostmaster
sudo adduser --gecos "" webmaster
sudo adduser --gecos "" list
sudo adduser --gecos "" abuse
sudo adduser --gecos "" info
sudo adduser --gecos "" admin
echo "foo1pw
foo1pw
" | sudo adduser --gecos "" foo1
echo "foo2pw
foo2pw
" | sudo adduser --gecos "" foo2
echo "foo3pw
foo3pw
" | sudo adduser --gecos "" foo3
echo "foo4pw
foo4pw
" | sudo adduser --gecos "" foo4
echo "foo5pw
foo5pw
" | sudo adduser --gecos "" foo5
echo "foo6pw
foo6pw
" | sudo adduser --gecos "" foo6
echo "foo7pw
foo7pw
" | sudo adduser --gecos "" foo7
echo "foo8pw
foo8pw
" | sudo adduser --gecos "" foo8
echo "foo9pw
foo9pw
" | sudo adduser --gecos "" foo9
sudo sh -c "echo \"#insert cert here\" > /etc/letsencrypt/live/chrissx.ga/cert.pem"
sudo nano /etc/letsencrypt/live/chrissx.ga/cert.pem
sudo sh -c "echo \"#insert key here\" > /etc/letsencrypt/live/chrissx.ga/privkey.pem"
sudo nano /etc/letsencrypt/live/chrissx.ga/privkey.pem
echo -----------------------------------------------------------
echo |4096 dhparams and installing packages will take some time|
echo -----------------------------------------------------------
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install openssl apache2 postfix postfix-pcre dovecot-core default-jre vim tmux libapache2-modsecurity dovecot-imapd dkim-filter
sudo service postfix restart
sudo openssl dhparam -out /etc/ssl/private/dhparam.pem 4096
sudo sh -c "echo \"chrissx.ga\" > /etc/mailname"
sudo sh -c "echo \"#insert main.cf here\" > /etc/postfix/main.cf"
sudo nano /etc/postfix/main.cf
sudo sh -c "echo \"#insert master.cf here\" > /etc/postfix/master.cf"
sudo nano /etc/postfix/master.cf
sudo sh -c "echo \"#insert header_checks here\" > /etc/postfix/header_checks"
sudo nano /etc/postfix/header_checks
sudo postmap -q "string" regexp:/etc/postfix/header_checks
sudo newaliases
sudo nano /etc/aliases
sudo postmap -q "string" hash:/etc/aliases
sudo service postfix restart
echo "#insert ip.sh here" > ip.sh
nano ip.sh
sudo chmod +x ip.sh
echo "#insert temp.sh here" > temp.sh
nano temp.sh
sudo chmod +x temp.sh
echo "#insert update.sh here" > update.sh
vim update.sh
sudo chmod +x update.sh
sudo sh -c "echo \"#insert dovecot.conf here\" > /etc/dovecot/dovecot.conf"
sudo nano /etc/dovecot/dovecot.conf
sudo service dovecot restart
sudo vim /etc/apache2/apache2.conf
sudo sh -c "echo \"#insert 000-default.conf here\" > /etc/apache2/sites-enabled/000-default.conf"
sudo nano /etc/apache2/sites-enabled/000-default.conf
sudo sh -c "echo \"#insert default-ssl.conf here\" > /etc/apache2/sites-enabled/default-ssl.conf"
sudo nano /etc/apache2/sites-enabled/default-ssl.conf
sudo a2enmod ssl
sudo a2enmod headers
sudo service apache2 restart
echo Set up new server.
