#!/bin/zsh

# Nix
source nix/install.sh

# Rust
rustup default stable

# VSCode
source vscode/install.sh

# Bob-nvim
cargo install bob-nvim
bob use nightly

# Volta
curl https://get.volta.sh | bash
