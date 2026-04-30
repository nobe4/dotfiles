# Inspired by https://codeberg.org/AndrewKvalheim/configuration/src/commit/11794e595144500a6c2be706e42ed698b1788bb8/packages/nixpkgs-issue-55674.nix
# See https://discourse.nixos.org/t/use-nixpkgs-config-allowunfreepredicate-in-multiple-nix-file/36590
# Pending https://github.com/NixOS/nixpkgs/issues/55674
{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.allowedUnfree = lib.mkOption {
    type = with lib.types; listOf str;
    default = [ ];
    description = "List of unfree packages allowed to install";
  };

  options.allowedUnstableUnfree = lib.mkOption {
    type = with lib.types; listOf str;
    default = [ ];
    description = "List of unfree packages from nixos-unstable allowed to install";
  };

  config.nixpkgs.config.allowUnfreePredicate =
    package: builtins.elem (lib.getName package) config.allowedUnfree;

  # Load nixos-unstable once with the allowed unfree packages
  config._module.args.pkgs-unstable = import <nixos-unstable> {
    system = pkgs.stdenv.system;
    config.allowUnfreePredicate =
      pkg: builtins.elem (builtins.parseDrvName pkg.pname).name config.allowedUnstableUnfree;
  };
}
