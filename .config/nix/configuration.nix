{
  pkgs,
  lib,
  ...
}: {
  system = {
    stateVersion = 5;
    # Keyboard
    keyboard.enableKeyMapping = true;
    keyboard.remapCapsLockToEscape = true;
  };

  # This is needed since stateVersion is set to 5 (the GID for v5 is 350)
  # see https://github.com/LnL7/nix-darwin/blob/7840909b00fbd5a183008a6eb251ea307fe4a76e/CHANGELOG#L1
  ids.gids.nixbld = 30000;

  # Nix configuration
  nix = {
    settings = {
      substituters = [
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      trusted-users = [
        "@admin"
      ];
    };
    configureBuildUsers = true;
    # Enable experimental nix command and flakes
    package = pkgs.nixFlakes;

    extraOptions =
      ''
        auto-optimise-store = true
        experimental-features = nix-command flakes
      ''
      + lib.optionalString (pkgs.system == "aarch64-darwin") ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';
  };

  users.users = {
    noam = {
      home = "/Users/noam";
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  programs.nix-index.enable = true;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;
}
