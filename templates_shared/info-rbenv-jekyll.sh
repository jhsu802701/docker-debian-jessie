#!/bin/bash

sh info-dev.sh

echo '-------'
echo 'ruby -v'
ruby -v

echo '---------'
echo 'jekyll -v'
jekyll -v

echo '------------------'
echo 'gem list "^jekyll$"'
gem list "^jekyll$"
