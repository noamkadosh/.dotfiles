{ config, pkgs, lib, ... }:

{
  home.stateVersion = "23.05";

  # https://github.com/malob/nixpkgs/blob/master/home/default.nix

  # Direnv, load and unload environment variables depending on the current directory.
  # https://direnv.net
  # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  home.packages = with pkgs; [
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
      exa
      fd
      ffmpeg_5
      flyctl
      fontforge
      fzf
      gh
      gitui
      gnupg
      gnused
      (writeShellScriptBin "gsed" '' exec ${gnused}/bin/sed "$@" '')
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
      (writeShellScriptBin "markdownlint" '' exec ${mdl}/bin/mdl "$@" '')
      # mongodb
      mprocs
      nmap
      nodePackages.snyk
      nodePackages.stylelint
      nodePackages.vercel
      openssl
      pkg-config
      # postgresql
      procs
      python3
      redis
      ripgrep
      rustup
      sd
      sheldon
      starship
      statix
      tealdeer
      tokei
      tree-sitter
      vim
      wget
      yarn
      zellij
      zoxide
      zsh
  ] ++ lib.optionals stdenv.isDarwin [
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

