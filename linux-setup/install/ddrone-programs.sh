#!/bin/bash

# Installing aircrack

required_programs=(
    "build-essential"
    "libssl-dev"
    "libnl-3-dev"
    "pkg-config"
    "libnl-genl-3-dev"
    "ethtool"
    "rfkill"
)
# Install required programs
for i in "${required_programs[@]}"
do
    sudo apt-get -y install "${i}"
done

# Update and install aircrack suite
sudo apt-get update &&
wget http://download.aircrack-ng.org/aircrack-ng-1.2-rc4.tar.gz &&
tar -zxvf aircrack-ng-1.2-rc4.tar.gz &&
cd aircrack-ng-1.2-rc4 &&
sudo make &&
sudo make prefix=/usr install &&
sudo airodump-ng-oui-update

# TODO: Install tshark, figure out how to get through yes/no screen