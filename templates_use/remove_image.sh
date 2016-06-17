#!/bin/bash

DOCKER_IMAGE=$1

echo '----------------------------------------------'
echo "Removing old containers based on $DOCKER_IMAGE"
for i in $(docker ps -a | grep $DOCKER_IMAGE | grep 'changed' | awk '{print $1}')
do
  docker kill $i; wait;
  docker rm -f $i; wait;
done;

echo '---------------------------------'
echo "docker ps -a | grep $DOCKER_IMAGE"
docker ps -a | grep $DOCKER_IMAGE

echo '--------------------------------'
echo "Removing images of $DOCKER_IMAGE"
for i in $(docker images -a | grep $DOCKER_IMAGE | awk '{print $3}')
  do
  docker kill $i; wait;
  docker rmi -f $i; wait;
done;

echo '-------------------------------------'
echo "docker images -a | grep $DOCKER_IMAGE"
docker images -a | grep $DOCKER_IMAGE