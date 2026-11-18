let
  system = "x86_64-linux";
  unfree = import ./utils/unfree.nix;

  # nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/nixos-26.05.tar.gz
  nixos-26_05 =
    import
      (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/nixos-26.05.tar.gz";
        sha256 = "1956vsp8b0nj2hg9llwk5ad4diz9dw2159camzfydvy2z40wpr8k";
      })
      {
        inherit system;
        config.allowUnfreePredicate = unfree.stable;
      };

  # nix-prefetch-url --unpack https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz
  nixos-unstable =
    import
      (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz";
        sha256 = "1zbwxnk9kghl14jk25k2xvjg8m4ncdq1x1w19lclpra1csgdcan9";
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
  vangelis = { ... }: { };

  # lasso   NAS, not nix
}
