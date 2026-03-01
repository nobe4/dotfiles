{ pkgs, ... }:
if pkgs.stdenv.isDarwin then
  pkgs.writeShellApplication {
    name = "xr";
    text = ''
      sudo darwin-rebuild "$@"
    '';
  }
else
  pkgs.writeShellApplication {
    name = "xr";
    text = ''
      if [ $# -eq 1 ] && [ "$1" = "switch" ]; then
        echo "'switch' detected, injecting '--install-bootloader'"
        set -- "$@" --install-bootloader
      fi

      sudo nixos-rebuild "$@"
    '';
  }
