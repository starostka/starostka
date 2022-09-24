# lazygit
function lazygit() {
    git add .
    git commit -a -m "`TZ=UTC date`"
    git push
}

conda install -c fastai nbdev

nbdev_install_quarto

quarto install tool tinytex