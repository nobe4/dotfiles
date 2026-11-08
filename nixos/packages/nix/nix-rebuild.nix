{ config, pkgs, ... }:
pkgs.writeShellApplication {
  name = "xr";
  text =
    if pkgs.stdenv.isDarwin then
      "sudo darwin-rebuild switch"
    else
      "colmena --config ${config.dotfiles}/nixos/hive.nix apply-local --sudo";
}
