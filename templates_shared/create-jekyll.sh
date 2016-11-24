#!/bin/bash

echo 'Enter the desired name for your new Jekyll project:'
read PROJECT_NAME

echo '--------------------------------------------------------------'
echo "git clone https://github.com/brijeshb42/bitwiser $PROJECT_NAME"
git clone https://github.com/brijeshb42/bitwiser $PROJECT_NAME
wait

echo '---------------------------------------------------------'
echo 'git clone https://github.com/jhsu802701/jekyll-heroku.git'
git clone https://github.com/jhsu802701/jekyll-heroku.git
wait

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
echo '-----------------------'
echo 'Do not track _site/*.sh'
echo '_site/*.sh' >> $PROJECT_NAME/to_do.txt

echo '----------------------------------'
echo "cd $PROJECT_NAME && bundle install"
( cd $PROJECT_NAME && bundle install )
wait

( cd $PROJECT_NAME && sh build.sh )
wait

FILE_TODO=$PROJECT_NAME/to_do.txt
echo ''
echo "Creating $FILE_TODO"
echo 'TO DO LIST' > $FILE_TODO
echo 'sh credentials.sh' >> $FILE_TODO
echo 'git add .' >> $FILE_TODO
echo "git commit -m 'First commit'" >> $FILE_TODO
echo 'sh server.sh' >> $FILE_TODO
echo 'Create a repository for this Jekyll project on GitHub.' >> $FILE_TODO
echo 'Deploy this Jekyll project to Heroku.  Details are in heroku.sh.' >> $FILE_TODO

echo '-------------'
echo 'Resetting Git'
rm -rf $PROJECT_NAME/.git
( cd $PROJECT_NAME && git init )
wait

echo '*************'
echo 'THINGS TO DO:'
echo "$FILE_TODO"
