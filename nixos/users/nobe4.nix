{
  pkgs,
  lib,
  config,
  ...
}:
let
  notify = import ../packages/notify.nix { inherit pkgs config; };
in
with pkgs.stdenv;
{
  # Required by devenv to update the nix store.
  nix.settings.trusted-users = [ "nobe4" ];

  # https://wiki.nixos.org/wiki/User_management
  # https://nixos.org/manual/nixos/stable/options#opt-users.users
  # https://nix-darwin.github.io/nix-darwin/manual/#opt-users.users
  users.users.nobe4 = {
    description = "nobe4";
    shell = pkgs.zsh;
    home = if isDarwin then "/Users/nobe4" else "/home/nobe4";

    packages = [
      notify
    ];
  }
  # Linux-only
  // lib.optionalAttrs (!isDarwin) {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  imports = [
    ../packages/shell
  ];

  ln = [
    [
      "$DOTFILE_FOLDER/.zshrc"
      "$HOME/.zshrc"
    ]
    [
      "$DOTFILE_FOLDER/.zprofile"
      "$HOME/.zprofile"
    ]
    [
      "$DOTFILE_FOLDER/.bashrc"
      "$HOME/.bashrc"
    ]
  ];
}
