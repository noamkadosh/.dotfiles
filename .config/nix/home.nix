{
  pkgs,
  lib,
  inputs,
  ...
}: let
  unstable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
    };
  };
in {
  programs = {
    home-manager.enable = true;
    # Direnv, load and unload environment variables depending on the current directory.
    # https://direnv.net
    # https://rycee.gitlab.io/home-manager/options.html#opt-programs.direnv.enable
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  home = {
    stateVersion = "24.05";
    packages = with pkgs;
      [
        _1password
        # _1password-gui
        act
        unstable.aider-chat
        alejandra
        argparse
        avrdude
        awscli2
        bandwhich
        # unstable.bartender
        bat
        blackbox
        bottom
        cachix
        cloudflared
        comma
        coreutils
        curl
        delta
        unstable.deno
        # docker
        # docker-compose
        du-dust
        unstable.eza
        unstable.fastfetch
        fd
        ffmpeg_5
        # firefox-devedition
        flyctl
        fontforge
        fzf
        unstable.ggshield
        gh
        gnupg
        gnused
        (writeShellScriptBin "gsed" ''exec ${gnused}/bin/sed "$@" '')
        go
        grex
        hadolint
        home-manager
        hyperfine
        jq
        kubectl
        unstable.lazydocker
        unstable.lazygit
        unstable.lazysql
        linode-cli
        luarocks
        luajit
        mdcat
        mermaid-cli
        mdl
        (writeShellScriptBin "markdownlint" ''exec ${mdl}/bin/mdl "$@" '')
        # mongodb
        mprocs
        nmap
        # unstable.ollama
        openssl
        unstable.obsidian
        # pgadmin
        pkg-config
        unstable.postgresql
        procs
        redis
        ripgrep
        rojo
        rustup
        sd
        unstable.sheldon
        nodePackages.snyk
        starship
        statix
        stow
        tealdeer
        tokei
        tree-sitter
        vim
        vscode
        unstable.wezterm
        wget
        xclip
        xquartz
        yarn
        unstable.yazi
        unstable.zellij
        zoxide
        zsh
      ]
      ++ lib.optionals stdenv.isDarwin [
        cocoapods
        m-cli # useful macOS CLI commands
      ];
  };

  # NOTE: python packages not needed anymore, but leaving it for reference
  # imports = [
  #   ./python.nix
  # ];

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
