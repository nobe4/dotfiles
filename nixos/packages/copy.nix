{ pkgs, ... }:
if pkgs.stdenv.isDarwin then
  pkgs.writeShellApplication {
    name = "copy";
    text = "pbcopy";
  }
else if pkgs ? wl-clipboard then
  pkgs.writeShellApplication {
    name = "copy";
    runtimeInputs = [ pkgs.wl-clipboard ];
    text = "wl-copy";
  }
else
  builtins.throw "copy is not supported"
