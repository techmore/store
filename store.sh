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
EOF

docker build -t some-content-nginx .
docker run --name some-nginx -d -p 8081:80 store-nginx
