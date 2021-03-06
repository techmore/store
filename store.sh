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
RUN apt-get -y update && apt-get install -y 
EOF

docker build -t some-content-nginx .
docker run --name store-nginx -d -p 8081:80 some-content-nginx
