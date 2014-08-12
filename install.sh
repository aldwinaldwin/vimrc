#!/bin/bash

echo -e "A backup will be made of your .vimrc if it exists under your home directory ..."

read -p "Do you wnat to continue? (Y/n) " -n 1 -r answer
echo
if [[ $answer =~ ^[Yy]$ || -z $answer ]] ; then
    NOW=$(date +"%Y%m%d%H%M%S")
    if [ -f ~/.vimrc ] ; then
        mv ~/.vimrc ~/.vimrc_$NOW
    else
        echo "No ~/.vimrc was there ..."
    fi
    cp .vimrc ~/.vimrc
    echo "New .vimrc placed in your home directory ... Thank you ... Bye!"
else
  echo "ok, mayby later then ... bye bye!"
fi

