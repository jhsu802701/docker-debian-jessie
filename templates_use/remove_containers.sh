#!/bin/bash

DOCKER_IMAGE=$1
CONTAINER='<CONTAINER>'

echo '----------------------------------------------'
echo "Removing old containers based on $DOCKER_IMAGE"
for i in $(docker ps -a | grep $DOCKER_IMAGE | grep $CONTAINER | awk '{print $1}')
do
  docker kill $i; wait;
  docker rm -f $i; wait;
done;

echo '---------------------------------'
echo "docker ps -a | grep $DOCKER_IMAGE"
docker ps -a | grep $DOCKER_IMAGE