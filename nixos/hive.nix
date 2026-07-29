let
  nixos-26_05 = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-26.05.tar.gz";
    sha256 = "1parjl7b3gbmsyj05172pyi3ymz8xqv7bhaa9dca9x1p91cg8fv2";
  }) { system = "x86_64-linux"; };

in
{
  meta = {
    nixpkgs = nixos-26_05;

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
