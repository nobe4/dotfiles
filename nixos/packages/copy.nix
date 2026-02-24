{ config, pkgs, ... }:
if pkgs.stdenv.isDarwin then
  pkgs.writeShellApplication {
    name = "copy";
    text = "pbcopy";
  }
else if config.programs.hyprland.enable then
  pkgs.writeShellApplication {
    name = "copy";
    runtimeInputs = [ pkgs.wl-clipboard ];
    text = "wl-copy";
  }
else
  pkgs.writeShellApplication {
    name = "copy";
    text = ''
      echo "copy not supported"
      exit 1
    '';
  }
