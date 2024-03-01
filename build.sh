#!/bin/bash
source .env
export space="------------------------------------------------------------------------"

echo "$space"
cd /home/ubuntu/webelight
git pull origin main
docker build -t $DOCKER_IMAGE_NAME:$BUILD_NUMBER
docker push $DOCKER_IMAGE_NAME:$BUILD_NUMBER

