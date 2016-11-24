#!/bin/bash

echo 'Enter the desired name for your new Jekyll project:'
read PROJECT_NAME

echo '--------------------------------------------------------------'
echo "git clone https://github.com/brijeshb42/bitwiser $PROJECT_NAME"
git clone https://github.com/brijeshb42/bitwiser $PROJECT_NAME

echo '---------------------------------------------------------'
echo 'git clone https://github.com/jhsu802701/jekyll-heroku.git'
git clone https://github.com/jhsu802701/jekyll-heroku.git

echo '-------------------------'
echo 'rm -rf jekyll-heroku/.git'
rm -rf jekyll-heroku/.git

echo '--------------------------------'
echo "cp jekyll-heroku/* $PROJECT_NAME"
cp jekyll-heroku/* $PROJECT_NAME

echo '--------------------'
echo 'rm -rf jekyll-heroku'
rm -rf jekyll-heroku 

echo '-------------------------------------'
echo "Disabling pagination in $PROJECT_NAME"
sed -i.bak "s|paginate|#paginate|g" $PROJECT_NAME/_config.yml

echo '-------------------------'
echo 'Track the _site directory'
BLANK=''
sed -i.bak "s|_site|$BLANK|g" $PROJECT_NAME/.gitignore

echo '----------------------------------'
echo "cd $PROJECT_NAME && bundle install"
( cd $PROJECT_NAME && bundle install )

( cd $PROJECT_NAME && sh build.sh )

echo '-------------'
echo 'Resetting Git'
rm -rf $PROJECT_NAME/.git
( cd $PROJECT_NAME && git init )

echo '***********'
echo 'NEXT STEPS:'
echo "1. cd $PROJECT_NAME"
echo '2. sh credentials.sh'
echo '3. git add .'
echo "4. git commit -m 'First commit'"
echo '5. sh server.sh'
echo '6. Create a repository for this Jekyll project on GitHub.'
echo '7. Deploy this Jekyll project to Heroku.  Details are in heroku.sh.'
