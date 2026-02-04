{ pkgs, lib, ... }:
let
  darwin = pkgs.stdenv.isDarwin;
in
{
  # Required by devenv to update the nix store.
  nix.settings.trusted-users = [ "nobe4" ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  # https://wiki.nixos.org/wiki/User_management
  # https://nixos.org/manual/nixos/stable/options#opt-users.users
  # https://nix-darwin.github.io/nix-darwin/manual/#opt-users.users
  users.users.nobe4 = {
    description = "nobe4";
    shell = pkgs.zsh;
    home = if darwin then "/Users/nobe4" else "/home/nobe4";
  }
  # Linux-only
  // lib.optionalAttrs (!darwin) {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

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
