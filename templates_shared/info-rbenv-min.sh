#!/bin/bash

sh info-dev.sh

echo '----------------'
echo 'python --version'
python --version

echo '---------------'
echo 'redis-server -v'
redis-server -v

echo '----------------'
echo 'sqlite3 -version'
sqlite3 -version

echo '--------------'
echo 'psql --version'
psql --version

echo '---------'
echo 'nodejs -v'
nodejs -v

echo '----------'
echo 'type rbenv'
type rbenv

echo '--------------'
echo 'rbenv versions'
rbenv versions