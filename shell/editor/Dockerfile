# Docker file for base image. (Focus on neovim and tools)
#
# @author Benjamin Starostka Jakobsen

# Adjustable image configuration using arguments
ARG USERNAME="developer"

# Debian image as base (unstable for newest software).
FROM debian:stable
LABEL maintainer=benjamin.starostka@gmail.com

# Set image locale.
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV TZ=Europe/Copenhagen

# Expose some ports to host by default.
EXPOSE 8080 8081 8082 8083 8084 8085

# Define which Neovim COC extensions should be installed.
# ARG COC='coc-css coc-eslint coc-html coc-json coc-sh coc-sql coc-tsserver coc-yaml'

# Lazygit variables
# ARG LG='lazygit'
# ARG LG_GITHUB='https://github.com/jesseduffield/lazygit/releases/download/v0.29/lazygit_0.29_Linux_x86_64.tar.gz'
# ARG LG_ARCHIVE='lazygit.tar.gz'

# Update repositories and install software:
RUN apt-get update && apt-get install -y sudo curl zsh git unzip python3 python3-pip nodejs npm neovim
# RUN apt install -y fzf ripgrep tree xclip tzdata ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config

# Cooperate Neovim with Python 3.
RUN pip3 install pynvim
# Cooperate NodeJS with Neovim.
RUN npm i -g neovim

# Create developer user (non root: keep host volume safe!)
RUN useradd -rm \
    -d /home/user -s /bin/zsh -g root \
    -G sudo -u 1001 user -p "$(openssl passwd -1 password)"

# Create directory for Neovim configuration files.
# RUN mkdir -p /home/.config/nvim

# Copy Neovim configuration files.
# COPY ./config/ /root/.config/nvim/

# Create directory for projects (there should be mounted from host).
RUN mkdir -p /srv/workspace

# Set default location after container startup.
WORKDIR /srv/workspace

# Change to dev user (everything below is done for user instead of root)
USER user

# Default to zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || true

# Avoid container exit.
CMD ["zsh"]