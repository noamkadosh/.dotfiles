#!/bin/sh

# Volta
curl https://get.volta.sh | bash

volta install node
volta install pnpm

# Nix
source nix/install.sh

# Rust
rustup default stable

# Cargo
source cargo/install.sh

# Zellij
source zellij/install.sh

# VSCode
source vscode/install.sh

# Bat
bat cache --build

# Obsidian
ln -s "$HOME/.config/obsidian" "$HOME/obsidian"

# Editor Config
ln -s "$HOME/.config/editorconfig" "$HOME/.editorconfig"
