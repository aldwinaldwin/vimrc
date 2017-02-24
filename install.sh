#!/bin/bash

# if git/wget/curl doesnt exist, ask to install...

echo -e "A backup will be made of your .vimrc if it exists under your home directory ..."

read -p "Do you wnat to continue? (Y/n) " -n 1 -r answer
echo
if [[ $answer =~ ^[Yy]$ || -z $answer ]] ; then
    NOW=$(date +"%Y%m%d%H%M%S")
    if [ -f ~/.vimrc ] ; then
        mv ~/.vimrc ~/.vimrc_$NOW
	if [ -d ~/.vim ] ; then
	    mv ~/.vim ~/.vim_$NOW
        else
            echo "No ~/.vim was there ..."
	fi
    else
        echo "No ~/.vimrc was there ..."
    fi
    cp .vimrc ~/.vimrc

# Placing Wombat for 256 color xterms created by David Liang
mkdir -p ~/.vim/colors
wget -O ~/.vim/colors/wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400

# Pathogen : manage your plugins
mkdir -p ~/.vim/autoload ~/.vim/bundle
#curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
wget -O ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# Vim-Powerline : better-looking, more functional vim statuslines
git clone https://github.com/Lokaltog/vim-powerline.git ~/.vim/bundle/vim-powerline/

git clone https://github.com/davidhalter/jedi-vim.git ~/.vim/bundle/jedi-vim/
pushd ~/.vim/bundle/jedi-vim/
git submodule update --init
popd

    echo "New .vimrc and .vim placed in your home directory ... Thank you ... Bye!"
else
  echo "ok, mayby later then ... bye bye!"
fi

