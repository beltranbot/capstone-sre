#!/bin/bash
# load environment variables
set -a; source /etc/environment; set +a;

cd ~/aws-codedeploy
pm2 startOrReload ecosystem.config.js 
