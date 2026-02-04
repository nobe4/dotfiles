{ pkgs, ... }:
let
  commit-mono = pkgs.callPackage ./commit.nix { };
  nerd = pkgs.callPackage ./nerd.nix { };
in
{
  fonts.packages = with pkgs; [
    # font-awesome
    noto-fonts
    commit-mono
    nerd
  ];
}
