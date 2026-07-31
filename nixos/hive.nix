let
  system = "x86_64-linux";
  unfree = import ./utils/unfree.nix;

  nixos-26_05 =
    import
      (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/nixos-26.05.tar.gz";
        sha256 = "1parjl7b3gbmsyj05172pyi3ymz8xqv7bhaa9dca9x1p91cg8fv2";
      })
      {
        inherit system;
        config.allowUnfreePredicate = unfree.stable;
      };

  nixos-unstable =
    import
      (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz";
        sha256 = "1850ky2d8lvv2m60grz5dlfr4d03s4b6kj4vbpba7lff0hlvg13s";
      })
      {
        inherit system;
        config.allowUnfreePredicate = unfree.unstable;
      };
in
{
  meta = {
    nixpkgs = nixos-26_05;
  };

  defaults =
    { name, lib, ... }:
    {
      _module.args.pkgs-unstable = nixos-unstable;
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
