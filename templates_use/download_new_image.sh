#!/bin/bash

# Check for regular user login
if [ ! $( id -u ) -ne 0 ]; then
  echo 'You must be a regular user to run this script.'
  exit 2
fi

DOCKER_IMAGE='<DOCKER_IMAGE>'

echo '**********************************************************************'
echo "If $DOCKER_IMAGE does not download, these are the likely reasons:"
echo '1. It is not available.  Check Docker Hub to be sure.'
echo '2. You have downstream images that depend on your current image.  Use the nuke.sh script to remove all local Docker images.'
echo
echo 'Press Enter to continue.'
read -p '************************' continue

sh remove_containers.sh $DOCKER_IMAGE
sh remove_image.sh $DOCKER_IMAGE
sh remove_dangling.sh
sh remove_none.sh
sh copy_new.sh $DOCKER_IMAGE