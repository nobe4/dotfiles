let
  nixos-25_11 = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-25.11.tar.gz";
    sha256 = "0ln4yw7z3g9lb0x081hc0pd2j1wsx2qqf6bgmwwvdbkcl4bcy1dp";
  }) { system = "x86_64-linux"; };

  nixos-26_05 = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-26.05.tar.gz";
    sha256 = "1parjl7b3gbmsyj05172pyi3ymz8xqv7bhaa9dca9x1p91cg8fv2";
  }) { system = "x86_64-linux"; };

in
{
  meta = {
    nixpkgs = nixos-26_05;

    nodeNixpkgs = {
      brahms = nixos-26_05;
      verdi = nixos-25_11;
    };
  };

  defaults =
    { name, lib, ... }:
    {
      networking.hostName = name;
      deployment = {
        targetHost = lib.mkDefault (name + ".local");
        targetUser = "nobe4";
      };
      imports = [ ./hosts/${name}/configuration.nix ];
    };

  verdi =
    { ... }:
    {
      deployment = {
        # must use colmena apply-local
        allowLocalDeployment = true;
        targetHost = null;
      };
    };

  brahms = { ... }: { };
}
