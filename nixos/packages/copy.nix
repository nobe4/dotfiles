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
  builtins.throw "copy is not supported"
