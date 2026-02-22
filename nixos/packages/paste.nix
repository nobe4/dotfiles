{ config, pkgs, ... }:
pkgs.writeShellScriptBin "paste" (
  if pkgs.stdenv.isDarwin then
    ''
      pbpaste
    ''
  else if config.programs.hyprland.enable then
    ''
      ${pkgs.wl-clipboard}/bin/wl-paste
    ''
  else
    ''
      echo "paste not supported"
      exit 1
    ''
)
