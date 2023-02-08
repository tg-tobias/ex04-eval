#!/bin/bash

# usage: /newdocument.sh [target_dir]

TARGET_DIR="$1"
if [ -z $1 ]; then
   TARGET_DIR='new'
fi

while true; do
   mkdir -p $TARGET_DIR
   if (( "$(ls --almost-all $TARGET_DIR | wc -m)" > 0 )); then
      echo "Directory is not empty"
      read -p "Enter a empty direcotry: " TARGET_DIR
   else
      break
   fi
done

cp -r `ls --almost-all | grep -v -E '(.git|new|out)'` $TARGET_DIR
cd $TARGET_DIR

# ask for git repository options
read -p "Init as git repository?[Y/n]" makeGitRepo
if [[ "$makeGitRepo" =~ ^(|Y|y|Yes|yes)$ ]]; then
   git init
   read -p "Use custom git user for this repository?[Y/n]" customGitUser
   if [[ "$customGitUser" =~ ^(|Y|y|Yes|yes)$ ]]; then
      read -p "Enter git user.name: " customGitUserName
      read -p "Enter git user.email: " customGitUserEmail
      git config user.name "$customGitUserName"
      git config user.email "$customGitUserEmail"
   fi
   git add .
   git commit -m "Init new latex document from cosmictemplates"
   echo "Add a git remote manually."
fi
