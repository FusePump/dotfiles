#!/bin/bash
#
# Dotfles install script
#

# Constants
BACKUP_DIR="backup" # backup directory
DOTFILES=( "vimrc" "bashrc" "bash_aliases" "vim" ) # list of dotfiles without dots

cd "$(dirname "$0")" # move to the current folder

git pull # update repo

# Install dotfiles 
function install() {
  rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av . ~
}

# Backup dotfiles
function backup() {
  echo 'Backing dotfiles...'
  if [ ! -d "$BACKUP_DIR" ]; then
    # if backup folder doesn't exist create it
    mkdir $BACKUP_DIR
  fi

  # copy dotfles into backup folder
  for i in "${DOTFILES[@]}"
  do
    if [ -d "$HOME/.$i" -o -f "$HOME/.$i" ]; then # if file exists
      cp -r -L $HOME/.$i $BACKUP_DIR/$i
    else
      echo $i" doesn't exist"
    fi
  done

  echo 'Dotfiles backed up to '$BACKUP_DIR
}

backup # backup dotfiles first

unset backup
unset install
source ~/.bashrc
