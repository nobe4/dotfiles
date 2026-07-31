{ pkgs, ... }:
let
  commit-mono = pkgs.callPackage ./commit.nix { };
  nerd = pkgs.callPackage ./nerd.nix { };
in
{
  fonts.packages = with pkgs; [
    noto-fonts
    commit-mono
    nerd
  ];
}
