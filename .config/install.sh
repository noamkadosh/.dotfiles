#!/bin/sh

# Volta
curl https://get.volta.sh | bash

volta install node
volta install pnpm

# Nix
source ~/.config/nix/install.sh

# Rust
rustup default stable

# Zellij
source ~/.config/zellij/install.sh

# VSCode
source ~/.config/vscode/install.sh

# Bat
bat cache --build

# Bob-nvim
cargo install bob-nvim
bob use nightly

curl -fLo ~/.config/vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
