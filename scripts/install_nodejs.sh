#!/bin/bash
curl -sL https://rpm.nodesource.com/setup_22.x | sudo bash -
yum install -y gcc-c++ make
yum install -y nodejs
npm install -y -g forever
cd /var/www/html/
npm install