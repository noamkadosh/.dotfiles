{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfree = true;
    config.allowUnsupportedSystem = true;
  };
in {
  home.stateVersion = "23.05";

  # https://github.com/malob/nixpkgs/blob/master/home/default.nix

  programs.home-manager.enable = true;
  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = with pkgs;
    [
      _1password
      act
      alejandra
      argparse
      avrdude
      bandwhich
      bat
      blackbox
      bottom
      cachix # adding/managing alternative binary caches hosted by Cachix
      coreutils
      curl
      delta
      # docker
      # docker-compose
      du-dust
      unstable.eza
      fd
      ffmpeg_5
      flyctl
      fontforge
      fzf
      gh
      gitui
      gnupg
      gnused
      (writeShellScriptBin "gsed" ''exec ${gnused}/bin/sed "$@" '')
      go
      grex
      hadolint
      hyperfine
      kubectl
      linode-cli
      luarocks
      luajit
      mdcat
      mdl
      (writeShellScriptBin "markdownlint" ''exec ${mdl}/bin/mdl "$@" '')
      # mongodb
      mprocs
      nmap
      openssl
      pkg-config
      # postgresql
      procs
      python3
      redis
      ripgrep
      rustup
      sd
      unstable.sheldon
      skhd
      nodePackages.snyk
      starship
      statix
      nodePackages.stylelint
      tealdeer
      tokei
      tree-sitter
      nodePackages.vercel
      vim
      wget
      xclip
      xplr
      xquartz
      yabai
      yarn
      zellij
      zoxide
      zsh
    ]
    ++ lib.optionals stdenv.isDarwin [
      cocoapods
      m-cli # useful macOS CLI commands
    ];

  # Misc configuration files --------------------------------------------------------------------{{{

  # https://docs.haskellstack.org/en/stable/yaml_configuration/#non-project-specific-config
  home.file.".stack/config.yaml".text = lib.generators.toYAML {} {
    templates = {
      scm-init = "git";
      params = {
        author-name = "Noam Kadosh"; # config.programs.git.userName;
        author-email = "noamkadosh91@gmail.com"; # config.programs.git.userEmail;
        github-username = "noamkadosh";
      };
    };
    nix.enable = true;
  };
}
