{ pkgs, ... }:
let
  commit-mono = pkgs.callPackage ./commit.nix { };
  nerd = pkgs.callPackage ./nerd.nix { };
  nordwand-mono = pkgs.callPackage ./nordwand.nix { };
in
{
  fonts.packages = with pkgs; [
    noto-fonts
    commit-mono
    nerd
    nordwand-mono
  ];
}
