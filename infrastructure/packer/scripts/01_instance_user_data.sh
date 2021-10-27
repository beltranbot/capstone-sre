#!/bin/bash

# load environment variables
set -a; source /etc/environment; set +a;

### install codedeploy agent
sudo yum update -y
sudo yum install ruby -y
sudo yum install wget -y
cd /home/ec2-user
# todo: update url to use the correct one for your aws region
wget https://aws-codedeploy-us-east-2.s3.us-east-2.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
# verify that agent was correctly installed
sudo service codedeploy-agent status

### install node
curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash -
sudo yum install -y nodejs

### install pm2
sudo npm install pm2 -g
