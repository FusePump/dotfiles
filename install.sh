#!/bin/bash
#
# Dotfles install script
#

# Constants
BACKUP_DIR="backup" # backup directory
DOTFILES=( "vimrc" "bashrc" "bash_aliases" "vim" ) # list of dotfiles without dots

cd "$(dirname "$0")" # move to the current folder

git pull # update repo

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

# Delete dotfiles
function delete() {
  # delete dotfiles
  for i in "${DOTFILES[@]}"
  do
    if [ -d "$HOME/.$i" -o -f "$HOME/.$i" ]; then # if file exists
      rm -rf $HOME/.$i
    fi
  done
}

# Install dotfiles 
function install() {
  echo 'Creating symlinks'
  for i in "${DOTFILES[@]}"
  do
    ln -s $(dirname "$0")/$i $HOME/.$i
  done
  echo 'All symlinks created'
}

backup # backup dotfiles first
delete # delete dotfiles
install # delete dotfiles

unset backup
unset delete
unset install
source ~/.bashrc
