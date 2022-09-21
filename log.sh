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