#!/bin/bash

# This script tests your Jekyll installation.

sh /home/winner/shared/info.sh

jekyll new my-awesome-site
cat /home/winner/shared/ports.txt
echo '**********************'
echo 'OPEN YOUR WEB BROWSER.'
echo 'GO TO THE FOLLOWING URL:'
echo 'http://<IP Address>:4000'
echo "If Docker is installed directly in your host OS, use the IP address 'localhost'."
echo "If you are using Docker Machine, use Docker Machine's dedicated IP address (probably 192.168.99.100)."
echo '*************************************************************************'
cd my-awesome-site && jekyll serve --host 0.0.0.0
