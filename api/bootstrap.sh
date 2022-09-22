#!/bin/bash

# lazygit
function lazygit() {
    git add .
    git commit -a -m "`TZ=UTC date`"
    git push
}