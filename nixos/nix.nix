# Defines all nix-related options.
{ lib, pkgs, ... }:
# TODO: use this instead of custom let in
with pkgs.stdenv;
{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    }
    // lib.optionalAttrs (!isDarwin) { dates = "weekly"; }
    // lib.optionalAttrs isDarwin {
      interval = {
        Weekday = 7;
        Hour = 0;
        Minute = 0;
      };
    };
  };

  ln = [
    [
      "$DOTFILE_FOLDER/nixos/"
      "$HOME/.config/nixos"
    ]
  ];
}
