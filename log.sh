#!/bin/bash

# Log system information

## Prompt
echo “$PS0”
echo “$PS1”
echo “$PS2”
echo “$PS3”
echo “$PS3”

## User
cat ~/.profile
cat ~/.bashrc
cat ~/.bash_profile
cat ~/.zshrc
cat ~/.zprofile

## System
cat /etc/motd

printenv
env
set

alias

## Git
# Ubuntu Linux Git Config File Locations
# Scope     Location and Filename	            Filename Only
# System    etc/gitconfig	                    gitconfig
# Global    home/<username>/.gitconfig or ~root/.gitconfig	 .gitconfig
# Local     <git-repo>/.git/config              config
# Worktree  <git-repo>/.git/config.worktree	    config.worktree

cat etc/gitconfig
cat ~/.gitconfig