#!/bin/bash

# Initial server setup for sudo privlages of non-sudo user
# https://www.digitalocean.com/community/articles/initial-server-setup-with-ubuntu-16-04

# Install Apache
sudo apt-get update
sudo apt-get -y apache2

# Configure Apache
sudo apache2ctl configtest

# Set ServerName in Apache
sudo nano /etc/apache2/apache2.conf

# Find IP address of server
# https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-16-04#how-to-find-your-server-39-s-public-ip-address

# Inside the apache2.conf file, append
################ /etc/apache2/apache2.conf ################
ServerName <server_domain_or_IP>

# Close and save apache2.conf

# Check for errors
sudo apache2ctl configtest

# If output of prev command is "Syntax OK"
sudo systemctl restart apache2

# Adjust firewall to allow web traffic
# List out Apache firewall application profile
sudo ufw app list

# Output
#
# Available applications:
#   Apache
#   Apache Full
#   Apache Secure
#   OpenSSH

# Look at "Apache Full" and you should see that it enables traffic to ports 80 and 443
sudo ufw app info "Apache Full"

# Output
#
# Profile: Apache Full
# Title: Web Server (HTTP,HTTPS)
# Description: Apache v2 is the next generation of the omnipresent Apache web
# server.

# Ports:
#   80,443/tcp

# Allow traffic in "Apache Full"
sudo ufw allow in "Apache Full"

# Find server IP address
ip addr show eth0 | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'

# Test by visiting public IP address
http://<your_public_ip_address>

# Install mysql
sudo apt-get -y install mysql-server

# Run security script for mysql
mysql_secure_installation

# Validate password plugin
VALIDATE PASSWORD PLUGIN

# Validate password plugin will ask if you want to change the password
#
# Change the password for root ? ((Press y|Y for Yes, any other key for No) : n


# Install PHP
sudo apt-get install php libapache2-mod-php php-mcrypt php-mysql

# Edit the way Apache will serve files when a directory is requested
sudo nano /etc/apache2/mods-enabled/dir.conf

# It will look like this
################ /etc/apache2/mods-enabled/dir.conf ################

# <IfModule mod_dir.c>
#     DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm
# </IfModule>

# Move index.php to the begining so Apache will look for that type of file first
################ /etc/apache2/mods-enabled/dir.conf ################

# <IfModule mod_dir.c>
#     DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
# </IfModule>

# Restart Apache so changes take effect
sudo systemctl restart apache2

# Check on status of Apache
sudo systemctl status apache2

# Install PHP modules

# To see the available options for PHP modules and libraries, you can pipe the results of apt-cache search into less, a pager which lets you scroll through the output of other commands:
apt-cache search php- | less

# To get more information about any of the listed packages
apt-cache show <package_name>

# Test PHP processing on webserver
sudo nano /var/www/html/info.php

# put this code in that file 
# <?php
# phpinfo();
# ?>

# Go to that page to see the output
# http://<your_server_IP_address>/info.php

# After seeing it work, rm that file as to not expose server info
sudo rm /var/www/html/info.php

echo -e "Completed LAMP installation and testing"

# https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-16-04
# https://letsencrypt.org/


# https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-virtual-hosts-on-ubuntu-16-04
# Virtual hosts

sudo mkdir -p /var/www/example.com/public_html
sudo mkdir -p /var/www/test.com/public_html

# Grant permissions

sudo chown -R $USER:$USER /var/www/example.com/public_html
sudo chown -R $USER:$USER /var/www/test.com/public_html

# Set write permissions to server directory
sudo chmod -R 755 /var/www

# Create the first virtual host file
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/example.com.conf

# Edit the conf file
sudo nano /etc/apache2/sites-available/example.com.conf

# Should look something like this

# <VirtualHost *:80>
#     ServerAdmin webmaster@localhost
#     DocumentRoot /var/www/html
#     ErrorLog ${APACHE_LOG_DIR}/error.log
#     CustomLog ${APACHE_LOG_DIR}/access.log combined
# </VirtualHost>

# Change the ServerAdmin to your email address
ServerAdmin <server_admin_email>@example.com

# Edit some of the other configurations
ServerName example.com
ServerAlias www.example.com

# Change the DocumentRoot to point to the directory created earlier
DocumentRoot /var/www/example.com/public_html

# This file should now look something like this
################ /etc/apache2/sites-available/example.com.conf ################
# <VirtualHost *:80>
#     ServerAdmin admin@example.com
#     ServerName example.com
#     ServerAlias www.example.com
#     DocumentRoot /var/www/example.com/public_html
#     ErrorLog ${APACHE_LOG_DIR}/error.log
#     CustomLog ${APACHE_LOG_DIR}/access.log combined
# </VirtualHost>

####################################
# Repeat the VirtualHost steps for the other site created (test.com)
####################################

# We can use the `a2ensite` tool to enable each of our sites like this:
sudo a2ensite example.com.conf
sudo a2ensite test.com.conf

# Next, disable the default site defined in 000-default.conf
sudo a2dissite 000-default.conf

# Restart apache to have changes take effect
sudo systemctl restart apache2

# OR the same apache restart can happen this way as well
sudo service apache2 restart # The systemctl way is recommended 


# Hosts edit (optional)
################ sudo nano /etc/hosts ################
127.0.0.1   localhost
127.0.1.1   guest-desktop
111.111.111.111 example.com
111.111.111.111 test.com