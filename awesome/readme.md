# Awesome
This directory contains cool shell commands to be used in devops and containers.

## Add, Commit & Push all changes (Deepnote)

git add . && git commit -a -m "Quick Update" && git push -f

## Lazy git command (add, commit with current date and push)

function lazygit() {
    git add .
    git commit -a -m "`TZ=UTC date`"
    git push
}

## Make repos notebook friendly using nbdev hooks

pip install -U nbdev
nbdev_install_hooks