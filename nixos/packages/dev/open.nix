{ pkgs, ... }:
if pkgs.stdenv.isDarwin then
  pkgs.writeShellApplication {
    name = "open";
    text = ''/usr/bin/open "$@"'';
  }
else
  pkgs.writeShellApplication {
    name = "open";
    text = ''xdg-open "$@"'';
  }
