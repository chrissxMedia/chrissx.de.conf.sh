#!/bin/sh
sudo apt install curl
sudo curl -fsSLo /etc/apt/sources.list https://github.com/chrissxYT/chrissx.ga.conf.sh/raw/master/rpi.buster.sources.list
sudo rm -rf /etc/apt/sources.list.d
