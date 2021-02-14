#!/bin/sh
sudo curl -fsSLo /etc/apt/sources.list https://github.com/chrissxYT/chrissx.de.conf.sh/raw/master/rpi.buster.sources.list
sudo rm -rf /etc/apt/sources.list.d
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y vim tmux
