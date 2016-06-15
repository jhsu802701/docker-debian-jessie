#!/bin/bash

# This script removes all Docker containers and images.

all_c=$(docker ps -aq)
docker rm $all_c
all_i=$(docker images -aq)
docker rmi $all_i

echo '----------------'
echo 'docker images -a'
docker images -a

echo '------------'
echo 'docker ps -a'
docker ps -a