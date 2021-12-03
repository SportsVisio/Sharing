#!/usr/bin/env bash

# GPG key for docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add docker to apt-get
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

# Install utilities
sudo apt-get install -y build-essential unzip git mysql-client

# Install GStreamer util / plugins for streaming into KVS
list=$(apt-cache --names-only search ^gstreamer1.0-* | awk '{ print $1 }' | grep -v gstreamer1.0-hybris)
sudo apt-get install $list

# Set Timezone if needed
#sudo timedatectl set-timezone America/New_York

# Install node 12
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Docker
sudo apt-get install -y docker-ce

# Setup docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)"  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# setup permissions for vagrant to access docker (runs on tcp owned by root)
#sudo groupadd docker
sudo usermod -aG docker vagrant

# global NPM packages
sudo npm install -g typescript nodemon eslint serverless

# Fix npm permissions issues (un-privileged provisioner)
sudo npm i -g npm
sudo chown -R $USER:$(id -gn $USER) /home/vagrant/.config
sudo chown -R 1000:1000 "/home/vagrant/.npm"

cd /var/www/
npm install

# Copy environment files from example if it doesn't already exist
cp -n /var/www/.env.example /var/www/.env

