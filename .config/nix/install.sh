#!/bin/zsh

# https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050

# Install nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# Emable nix-command and flakes to bootstrap 
cat <<EOF > ~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF

# Change nix path to the dotfiles path
# export NIX_PATH="$HOME/.config/nix/.nix-defexpr/channels:darwin-config=$HOME/.config/nix/.nixpkgs/darwin-configuration.nix:/nix/var/nix/profiles/per-user/root/channels"

# Until this is addressed https://github.com/LnL7/nix-darwin/issues/149
sudo mv /etc/nix/nix.conf /etc/nix/.nix-darwin.bkp.nix.conf

# Build configuration
nix build ./.config/nix#darwinConfigurations.Noam.system
./result/sw/bin/darwin-rebuild switch --flake ~/.config/nix

# Might be useful to install x86 packages in the nix profile manually
nix profile install nixpkgs#legacyPackages.x86_64-darwin.haskellPackages.stack
