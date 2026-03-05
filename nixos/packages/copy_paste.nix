{ pkgs, ... }:
(
  if pkgs.stdenv.isDarwin then
    [
      (pkgs.writeShellApplication {
        name = "copy";
        text = "pbcopy";
      })
      (pkgs.writeShellApplication {
        name = "paste";
        text = "pbpaste";
      })
    ]
  else if pkgs ? wl-clipboard then
    [
      (pkgs.writeShellApplication {
        name = "copy";
        runtimeInputs = [ pkgs.wl-clipboard ];
        text = "wl-copy";
      })
      (pkgs.writeShellApplication {
        name = "paste";
        runtimeInputs = [ pkgs.wl-clipboard ];
        text = "wl-paste";
      })
    ]
  else
    builtins.throw "copy/paste is not supported"
)
