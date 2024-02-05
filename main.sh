#!/bin/bash

sudo apt update -y
sudo apt upgrade -y

sudo apt install docker
sudo apt install docker-compose

# cd GISwebDev/

sed -i "s/{{SERVER_IP}}/20.4.22.56/g" nginx/init/nginx.conf
sed -i "s/{{SERVER_IP}}/20.4.22.56/g" nginx/web/index.html

sudo docker-compose up --build












