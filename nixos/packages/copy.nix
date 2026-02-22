{ config, pkgs, ... }:
pkgs.writeShellScriptBin "copy" (
  if pkgs.stdenv.isDarwin then
    ''
      pbcopy
    ''
  else if config.programs.hyprland.enable then
    ''
      ${pkgs.wl-clipboard}/bin/wl-copy
    ''
  else
    ''
      echo "copy not supported"
      exit 1
    ''
)
