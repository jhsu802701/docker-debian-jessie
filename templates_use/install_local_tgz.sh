#!/bin/bash

# Check for regular user login
if [ ! $( id -u ) -ne 0 ]; then
  echo 'You must be a regular user to run this script.'
  exit 2
fi

DOCKER_IMAGE='<DOCKER_IMAGE>'
ABBREV='<ABBREV>'
TGZ_FILE='$ABBREV.tgz'

echo '*******************************************************'
echo "If $TGZ_FILE cannot be installed as a Docker container,"
echo 'then it does not exist or is not compatible.'
echo 'An alternative is to use the download_new_image.sh script to'
echo 'acquire it.'
echo '***********'

sh remove_containers.sh $DOCKER_IMAGE
sh remove_image.sh $DOCKER_IMAGE

cat $TGZ_FILE | docker import - $DOCKER_IMAGE
wait

sh copy_new.sh $DOCKER_IMAGE