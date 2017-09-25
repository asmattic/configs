#!/bin/bash

# TODO: Check if pip is installed

# Install pip 
# TODO: check if -y or something needs to be included
wget https://bootstrap.pypa.io/get-pip.py \
&& sudo python get-pip.py \
&& sudo apt-get update

# Check pip version
pip --version

# Update pip
sudo pip install -U pip

# install Sphinx
sudo pip install Sphinx

# install the read the docs theme
sudo pip install sphinx_rtd_theme

# Needed to build Sphinx latexpdf
sudo apt -y install texlive-latex-base texlive-formats-extra latexmk

sudo apt-get update