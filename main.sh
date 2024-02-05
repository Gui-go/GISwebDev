#!/bin/bash

cd ~/GISwebDev/

. ~/GISwebDev/env     # Environment variables

echo "Variable SERVER_IP set as $SERVER_IP"

sudo apt update -y
sudo apt upgrade -y

sudo apt install docker -y
sudo apt install docker-compose -y


sed -i "s/{{PUBLIC_IP}}/$SERVER_IP/g" nginx/init/nginx.conf
sed -i "s/{{PUBLIC_IP}}/$SERVER_IP/g" nginx/web/index.html

sudo docker-compose up --build


