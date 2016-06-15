#!/bin/bash

sh info-min.sh

echo '-----------------------'
echo 'puppet master --version'
puppet master --version

echo '------------'
echo 'chef-solo -v'
chef-solo -v

echo '-----------------'
echo 'ansible --version'
ansible --version

echo '--------------'
echo 'heroku version'
heroku version