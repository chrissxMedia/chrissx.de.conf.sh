#!/bin/sh
sudo curl -fsSLo /etc/apt/sources.list https://github.com/chrissxYT/chrissx.ga.conf.sh/raw/master/rpi.buster.sources.list
sudo rm -rf /etc/apt/sources.list.d
sudo apt update
sudo apt upgrade
sudo apt install vim tmux openssl
