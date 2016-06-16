#!/bin/bash

DOCKER_IMAGE='<DOCKER_IMAGE>'

sh remove_dangling.sh

sh remove_containers.sh $DOCKER_IMAGE

sh copy_new.sh $DOCKER_IMAGE
