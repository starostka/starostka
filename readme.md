# Welcome
Personal monolithic repository

NOTE: dotfiles are kept in their own repository and controlled with chezmoi.

## subtree
git remote add -f starostka https://github.com/Starostka/starostka.git

**Short form**
git subtree add --prefix starostka starostka main --squash
git subtree pull --prefix starostka starostka main --squash
git subtree push --prefix starostka starostka main

**Long form**
git subtree add --prefix starostka https://github.com/Starostka/starostka.git main --squash
git subtree pull --prefix starostka https://github.com/Starostka/starostka.git main --squash
git subtree push --prefix starostka https://github.com/Starostka/starostka.git main

## hooks
todo: clean notebook files with nbdev and environment metadata such as deepnotes added image cells

## system
This directory contains nix system configurations.

## apps
This directory contains apps backed by nix and ready to use using jetpack-io/devbox or toast