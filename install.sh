#!/bin/sh
#------------------------------------------------------------------------------
#          FILE:  install.sh
#   DESCRIPTION:  Script to clone and install all dotfiles from github
#        AUTHOR:  Adam Walz <adam@adamwalz.net>
#       VERSION:  1.0.1
#------------------------------------------------------------------------------

DOTFILES_DIR="$HOME/Developer/setup/dotfiles"
PREZTO_DIR="${ZDOTDIR:-$HOME}/.zprezto"
SSH_DIR="$HOME/.ssh"

if [ ! -d "$DOTFILES_DIR" ]; then
    git clone git@github.com:adamwalz/dotfiles.git $DOTFILES_DIR
fi

if [ ! -d "$PREZTO_DIR" ]; then
    git clone --recursive git@github.com:adamwalz/prezto.git $PREZTO_DIR
fi

if [ ! -d "$SSH_DIR" ]; then
    git clone https://github.com/adamwalz/SSH.git $SSH_DIR
fi

if [[ "$SHELL" != *zsh ]]; then
    chsh -s /bin/zsh
fi

rake install -f $DOTFILES_DIR/Rakefile
