# Defines all nix-related options.
{ ... }:
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  ln = [
    [
      "$DOTFILE_FOLDER/nixos/"
      "$HOME/.config/nixos"
    ]
  ];
}
