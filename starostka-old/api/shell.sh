# Lazy Git (add, commit with current date and push)
function lazygit() {
    git add .
    git commit -a -m "`TZ=UTC date`"
    git push
}