#!/bin/bash

# Setup stable ppa and install
sudo add-apt-repository ppa:bit-team/stable \
&& sudo apt-get update \
&& sudo apt-get -y install backintime-qt4