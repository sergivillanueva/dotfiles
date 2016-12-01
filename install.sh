#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles

dir=~/.dotfiles # dotfiles directory
files="ackrc bash bash_profile bashrc bin gemrc gitconfig gitignore gvimrc.after inputrc irbrc janus.rake railsrc tmux.conf vimrc.local" # list of files/folders to symlink in homedir

# create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done
