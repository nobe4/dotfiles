{ pkgs, ... }:
let
  commit-mono = pkgs.callPackage ./font.commit.nix { };
in
{
  fonts.packages = with pkgs; [
    hack-font
    font-awesome
    commit-mono
  ];
}
