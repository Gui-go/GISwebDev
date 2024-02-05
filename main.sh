#!/bin/bash

cd ~/GISwebDev/

source ./env


sudo apt update -y
sudo apt upgrade -y

sudo apt install docker
sudo apt install docker-compose


sed -i "s/{{PUBLIC_IP}}/$SERVER_IP/g" nginx/init/nginx.conf
sed -i "s/{{PUBLIC_IP}}/$SERVER_IP/g" nginx/web/index.html

sudo docker-compose up --build












