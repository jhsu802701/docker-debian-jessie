#!/bin/bash

echo '-------------------------'
echo "Removing images of <none>"
for i in $(docker images -a | grep '<none>' | awk '{print $3}')
do
  docker kill $i; wait;
  docker rmi $i; wait;
done;