#!/bin/zsh

# Nix
source nix/install.sh

# Rust
rustup default stable

# VSCode
source vscode/install.sh

# Volta
curl https://get.volta.sh | bash