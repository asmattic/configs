#!/bin/bash

download_dir=$HOME/Downloads
cd download_dir

# Unzip to downloads folder
tar -xzvf forticlientsslvpn_linux_4.4.2323.tar.gz -C download_dir

# Ibus needs root to be the owner
sudo chown root /home/asmattic/.config/ibus/bus

cd forticlientsslvpn
# Run the server as root
sudo ./fortisslvpn.sh

# The server name will be vpn.accusoft.com
# TODO: Test that it's working

# Login settings
#
# Server:       https://vpn.accusoft.com
# Port:         443
# Username:     moldfield
# Password:     <accusoft pass>
#