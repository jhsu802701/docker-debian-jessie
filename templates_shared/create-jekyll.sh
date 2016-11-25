#!/bin/bash

echo 'Enter the desired name for your new Jekyll project:'
read PROJECT_NAME

echo '--------------------------------------------------------------'
echo "git clone https://github.com/brijeshb42/bitwiser $PROJECT_NAME"
git clone https://github.com/brijeshb42/bitwiser $PROJECT_NAME
wait

echo '---------------------------------------------------------'
echo 'git clone https://gitlab.com/jhsu802701/jekyll-gitlab.git'
git clone https://gitlab.com/jhsu802701/jekyll-gitlab.git
wait


echo '--------------------------------'
echo "cp jekyll-gitlab/* $PROJECT_NAME"
cp jekyll-gitlab/* $PROJECT_NAME

echo '--------------------'
echo 'rm -rf jekyll-gitlab'
rm -rf jekyll-gitlab

echo '--------------------'
echo 'Updating _config.yml'
sed -i.bak "s|paginate|#paginate|g" $PROJECT_NAME/_config.yml # Disable pagination
echo "gems: ['kramdown']" >> $PROJECT_NAME/_config.yml

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
echo "Go to $PROJECT_NAME/README-to_do.md"
