# Defines all nix-related options.
{ lib, pkgs, ... }:
let
  darwin = pkgs.stdenv.isDarwin;
in
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";
  }
  // lib.optionalAttrs (!darwin) { dates = "weekly"; }
  // lib.optionalAttrs darwin { interval = "weekly"; };

  ln = [
    [
      "$DOTFILE_FOLDER/nixos/"
      "$HOME/.config/nixos"
    ]
  ];
}
