{ pkgs, ... }:
if pkgs.stdenv.isDarwin then
  pkgs.writeShellApplication {
    name = "notify";
    text = ''
      osascript -e "display notification \"$1\" with title \"notify\""
    '';
  }
else if pkgs ? libnotify then
  pkgs.writeShellApplication {
    name = "paste";
    runtimeInputs = [ pkgs.libnotify ];
    text = ''
      notify "$@"
    '';
  }
else
  builtins.throw "notify not supported"
