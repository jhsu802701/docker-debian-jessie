#!/bin/bash

# This script tests your Hyde installation by running the Hyde Starter Kit.

sh /home/winner/shared/info.sh

git clone git://github.com/merlinrebrovic/hyde-starter-kit.git
cd /home/winner/shared/hyde-starter-kit && hyde gen
echo '*************************************************'
echo 'You can view the Hyde Starter kit page at the URL'
echo 'http://localhost:8080/'
echo "NOTE: If you are using Docker Machine, replace 'localhost'"
echo "with Docker Machine's IP address."
echo '*********************************'
cd /home/winner/shared/hyde-starter-kit && hyde serve -a 0.0.0.0