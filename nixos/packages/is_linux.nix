{ pkgs, ... }:
with pkgs.stdenv;
{
  users.users.nobe4.packages = with pkgs; [
    (mkDerivation {
      name = "is_linux";
      buildCommand = ''
        mkdir -p $out/bin

        echo "exit ${if isDarwin then "1" else "0"}" > $out/bin/is_linux
        echo "exit ${if isDarwin then "0" else "1"}" > $out/bin/is_macos

        chmod +x $out/bin/*
      '';
    })

  ];
}
