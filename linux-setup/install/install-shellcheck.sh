#!/bin/bash

# Install required dependency
sudo apt install xz-utils

# Set version to install
scversion="stable" # or "v0.4.7", or "latest"

# Grab the versioned tar archive
wget "https://storage.googleapis.com/shellcheck/shellcheck-${scversion}.linux.x86_64.tar.xz"

# Unzip
tar --xz -xvf shellcheck-"${scversion}".linux.x86_64.tar.xz

# Copy to executable directory
cp shellcheck-"${scversion}"/shellcheck /usr/bin/

# List out installed version
shellcheck --version
