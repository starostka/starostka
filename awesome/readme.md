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

## Quick download from Github Release and install

gh --repo quarto-dev/quarto-cli release download --pattern '*.deb'
sudo dpkg -i $(ls quarto-*.deb)
rm $(ls quarto-*.deb)


## Add Quarto support for Deepnote, SageMaker etc.

curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y

QUARTO_VERSION="v1.1.251"
sudo mkdir -p /opt/quarto/${QUARTO_VERSION}
sudo curl -o quarto.tar.gz -L \
    "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz"
sudo tar -zxvf quarto.tar.gz \
    -C "/opt/quarto/${QUARTO_VERSION}" \
    --strip-components=1
sudo rm quarto.tar.gz

- Below does not work yet but is preferred vs above

gh --repo quarto-dev/quarto-cli release download --pattern '*.deb'
sudo dpkg -i $(ls quarto-*.deb)
rm $(ls quarto-*.deb)