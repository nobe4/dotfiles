{ pkgs, ... }:
if pkgs.stdenv.isDarwin then
  pkgs.writeShellApplication {
    name = "open";
    text = ''open "$@"'';
  }
else
  pkgs.writeShellApplication {
    name = "open";
    text = ''xdg-open "$@"'';
  }
