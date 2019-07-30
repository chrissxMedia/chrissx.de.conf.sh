#!/bin/sh
#this script sets up new Pis with the required packages and configs.
#nano sucks, but it does not automatically insert #s
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
sudo sh -c "echo \"#insert cert here\" > /etc/letsencrypt/live/zerm.chrissx.ga/cert.pem"
sudo nano /etc/letsencrypt/live/zerm.chrissx.ga/cert.pem
sudo sh -c "echo \"#insert key here\" > /etc/letsencrypt/live/zerm.chrissx.ga/privkey.pem"
sudo nano /etc/letsencrypt/live/zerm.chrissx.ga/privkey.pem
sudo sh -c "echo \"#insert cert here\" > /etc/letsencrypt/live/zm.chrissx.ga/cert.pem"
sudo nano /etc/letsencrypt/live/zm.chrissx.ga/cert.pem
sudo sh -c "echo \"#insert key here\" > /etc/letsencrypt/live/zm.chrissx.ga/privkey.pem"
sudo nano /etc/letsencrypt/live/zm.chrissx.ga/privkey.pem
echo -----------------------------------------------------------
echo |4096 dhparams and installing packages will take some time|
echo -----------------------------------------------------------
sudo apt -y update
sudo apt -y upgrade
sudo apt -y install curl openssl apache2 postfix postfix-pcre \
        dovecot-core default-jre vim tmux dovecot-imapd dkim-filter \
        python-certbot-apache
sudo service postfix restart
sudo openssl dhparam -out /etc/ssl/private/dhparam.pem 4096
sudo sh -c "echo chrissx.ga > /etc/mailname"
cd
git clone https://github.com/chrissxyt/chrissx.ga.conf.sh
cd chrissx.ga.conf.sh
cd postfix
sudo cp main.cf /etc/postfix/main.cf
sudo cp master.cf /etc/postfix/master.cf
sudo cp header_checks /etc/postfix/header_checks
sudo postmap -q "string" regexp:/etc/postfix/header_checks
sudo sh -c 'echo "bar1: pi
bar2: pi
bar3: pi
bar4: pi
bar5: pi
bar6: pi
bar7: pi
bar8: pi
bar9: pi" > /etc/aliases'
sudo postmap -q "string" hash:/etc/aliases
sudo service postfix restart
cd ../home
cp * ~
cd ../dovecot
sudo cp dovecot.conf /etc/dovecot/dovecot.conf
sudo service dovecot restart
cd ../apache2
sudo cp apache2.conf /etc/apache2/apache2.conf
sudo cp 000-default.conf /etc/apache2/sites-enabled/000-default.conf
sudo cp default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf
sudo a2enmod ssl
sudo a2enmod headers
sudo service apache2 restart
echo Set up new server.
