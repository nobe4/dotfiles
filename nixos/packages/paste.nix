{ pkgs, ... }:
if pkgs.stdenv.isDarwin then
  pkgs.writeShellApplication {
    name = "paste";
    text = "pbpaste";
  }
else if pkgs ? wl-clipboard then
  pkgs.writeShellApplication {
    name = "paste";
    runtimeInputs = [ pkgs.wl-clipboard ];
    text = "wl-paste";
  }
else
  builtins.throw "paste is not supported"
