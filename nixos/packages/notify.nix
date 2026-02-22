{ config, pkgs, ... }:
pkgs.writeShellScriptBin "notify" (
  if pkgs.stdenv.isDarwin then
    ''
      osascript -e "display notification \"$1\" with title \"notify\""
    ''
  else if config.programs.hyprland.enable then
    ''
      ${pkgs.libnotify}/bin/notify-send "$@"
    ''
  else
    ''
      echo "notify not supported"
      exit 1
    ''
)
