#!/bin/bash

DOCKER_IMAGE=$1
CONTAINER='<CONTAINER>'

is='/bin/bash' # Initial script to run
hs=$PWD/shared # Host machine shared directory
ds='/home/winner/shared' # Docker shared directory

echo '-------------------------------------------------------'
echo "Creating Docker container $CONTAINER from $DOCKER_IMAGE"
docker create -i -t -u='winner' --name $CONTAINER \
  #PORT_SPECIFICATIONS_HERE \
  -e HOME=/home/winner -e USERNAME=winner \
  -v $hs:$ds $DOCKER_IMAGE $is
wait

echo '-------------------------------------------------------'
echo "Starting Docker container $CONTAINER from $DOCKER_IMAGE"
docker start -i $CONTAINER