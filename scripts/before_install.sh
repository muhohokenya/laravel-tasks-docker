#!/bin/bash

# Update the package list
sudo apt-get update
sudo apt-get upgrade -y

sudo apt install ruby-full -y

sudo apt install wget

cd /home/ubuntu

wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install

chmod +x ./install

sudo ./install auto

systemctl status codedeploy-agent
