#!/bin/bash

DOCKER_IMAGE=$1

echo '----------------------------------------------'
echo "Removing old containers based on $DOCKER_IMAGE"
for i in $(docker ps -a | grep $DOCKER_IMAGE | grep 'changed' | awk '{print $1}')
do
  docker kill $i; wait;
  docker rm $i; wait;
done;

echo '---------------------------------'
echo "docker ps -a | grep $DOCKER_IMAGE"
docker ps -a | grep $DOCKER_IMAGE