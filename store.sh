#!/bin/bash

# https://store.docker.com/images/nginx

# Create Blog folder which has all posts and edited index file to push up to server
mkdir -p store
cd store
wget https://raw.githubusercontent.com/techmore/store/master/index.html

cd ..


# CREATE DOCKER FILE
cat <<EOF >> Dockerfile 
FROM nginx
COPY store /usr/share/nginx/html
RUN apt-get update && apt-get install -y \
 echo "deb http://deb.goaccess.io/ $(lsb_release -cs) main" | sudo tee -a /etc/apt/sources.list.d/goaccess.list \
 wget -O - http://deb.goaccess.io/gnugpg.key | sudo apt-key add - \
 apt-get update \
 apt-get install goaccess \
 run goaccess /etc/logs/nginx/access.log -o /usr/share/nginx/html/report.html --real-time-html
EOF

docker build -t some-content-nginx .
docker run --name store-nginx -d -p 8081:80 some-content-nginx
