#!/bin/bash

sh info-rbenv-min.sh

echo '-------'
echo 'ruby -v'
ruby -v

echo '--------'
echo 'rails -v'
rails -v

echo '--------------'
echo 'rbenv versions'
rbenv versions

echo '------------------'
echo 'gem list "^rails$"'
gem list "^rails$"

echo '---------------------'
echo 'gem list "^nokogiri$"'
gem list "^nokogiri$"

echo '---------------'
echo 'gem list "^pg$"'
gem list "^pg$"

echo '------------------------'
echo 'gem list "^mailcatcher$"'
gem list "^mailcatcher$"
