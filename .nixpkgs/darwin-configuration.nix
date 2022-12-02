{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.alacritty
      pkgs.avrdude
      pkgs.bandwhich
      pkgs.bat
      pkgs.bottom
      pkgs.cargo
      pkgs.coreutils
      pkgs.curl
      pkgs.du-dust
      pkgs.exa
      pkgs.fd
      pkgs.flyctl
      pkgs.fzf
      pkgs.gh
      pkgs.go
      pkgs.grex
      pkgs.hyperfine
      pkgs.kubectl
      pkgs.linode-cli
      pkgs.lua
      pkgs.neovim
      pkgs.nodejs-18_x
      pkgs.nodePackages.pnpm
      pkgs.nodePackages.vercel
      # "unfree" packge issue
      # export NIXPKGS_ALLOW_UNFREE=1
      pkgs.obsidian
      pkgs.procs
      pkgs.ripgrep
      pkgs.rustup
      pkgs.sd
      # phantom "unsupported platform" issue 
      # export NIXPKGS_ALLOW_UNSUPPORTED_SYSTEM=1
      pkgs.sheldon
      pkgs.starship
      pkgs.tealdeer
      pkgs.tokei
      pkgs.tree-sitter
      pkgs.vim
      pkgs.yarn
      pkgs.zellij
      pkgs.zoxide
      pkgs.zsh  
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
