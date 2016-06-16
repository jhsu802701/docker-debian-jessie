#!/bin/bash

# Check for regular user login
if [ ! $( id -u ) -ne 0 ]; then
  echo 'You must be a regular user to run this script.'
  exit 2
fi

echo '------------------------------'
echo 'BEGIN removing dangling images'
docker rmi $(docker images -q -f dangling=true)
echo 'FINISHED removing dangling images'
echo '---------------------------------'