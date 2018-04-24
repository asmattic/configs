#!/bin/bash

# This script is for Ubuntu 16.04 LTS
# Written: 04/23/2018

# Install Microsoft keys and feed
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg &&
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list' &&
# Install .NET framework
sudo apt-get -y install apt-transport-https &&
sudo apt-get update &&
sudo apt-get -y install dotnet-sdk-2.1.105

# TODO: Prompt user to see if they want to create a sample 
#       app and where they want it installed
# dotnet new console -o myApp
# cd myApp

# To run the app from the directory it's in (most likely)
# dotnet run