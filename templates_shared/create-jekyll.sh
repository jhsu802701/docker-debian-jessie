#!/bin/bash

echo 'Enter the desired name for your new Jekyll project:'
read PROJECT_NAME

echo '--------------------------------------------------------------'
echo "git clone https://github.com/brijeshb42/bitwiser $PROJECT_NAME"
git clone https://github.com/brijeshb42/bitwiser $PROJECT_NAME
wait

echo '---------------------------------------------------------'
echo 'git clone https://github.com/jhsu802701/jekyll-deploy.git'
git clone https://github.com/jhsu802701/jekyll-deploy.git
wait

echo '--------------------------------'
echo "cp jekyll-deploy/* $PROJECT_NAME"
cp jekyll-deploy/* $PROJECT_NAME

echo '--------------------'
echo 'rm -rf jekyll-deploy'
rm -rf jekyll-deploy

echo '--------------------'
echo 'Updating _config.yml'
sed -i.bak "s|paginate|#paginate|g" $PROJECT_NAME/_config.yml # Disable pagination
echo "gems: ['kramdown']" >> $PROJECT_NAME/_config.yml

echo '-------------------'
echo 'Updating .gitignore'
echo '.bitballoon' >> $PROJECT_NAME/.gitignore

echo '-----------------------------------'
echo '( cd $PROJECT_NAME && sh build.sh )'
( cd $PROJECT_NAME && sh build.sh )
wait

echo '-------------'
echo 'Resetting Git'
rm -rf $PROJECT_NAME/.git
( cd $PROJECT_NAME && git init )
wait

echo '************************************'
echo 'Your new project has been created at'
echo "$PWD/$PROJECT_NAME"
echo
echo 'For further instructions, go to'
echo "Go to $PROJECT_NAME/README-to_do.txt"
