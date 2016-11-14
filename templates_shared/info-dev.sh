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

echo '-------------'
echo 'git --version'
git --version

echo '----------------'
echo 'python --version'
python --version

echo '-----------'
echo 'npm version'
npm version

echo '-------'
echo 'node -v'
node -v

echo '---------------'
echo 'redis-server -v'
redis-server -v

echo '----------------'
echo 'sqlite3 -version'
sqlite3 -version

echo '--------------'
echo 'psql --version'
psql --version

echo '----------'
echo 'type rbenv'
type rbenv

echo '--------------'
echo 'rbenv versions'
rbenv versions
