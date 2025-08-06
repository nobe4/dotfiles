{ pkgs, ... }:
let
  commit-mono = pkgs.callPackage ./font.commit.nix { };
in
{
  fonts.packages = with pkgs; [
    font-awesome
    commit-mono
  ];
}
