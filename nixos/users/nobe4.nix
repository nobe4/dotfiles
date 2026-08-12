{
  pkgs,
  lib,
  config,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
  keys = import ../packages/ssh_keys.nix;
in
{
  time.timeZone = "Europe/Berlin";

  # Required by devenv to update the nix store.
  nix.settings.trusted-users = [ "nobe4" ];

  # https://wiki.nixos.org/wiki/User_management
  # https://nixos.org/manual/nixos/stable/options#opt-users.users
  # https://nix-darwin.github.io/nix-darwin/manual/#opt-users.users
  users.users.nobe4 = {
    description = "nobe4";
    home = if isDarwin then "/Users/nobe4" else "/home/nobe4";
  }
  // lib.optionalAttrs config.programs.zsh.enable {
    shell = pkgs.zsh;
  }
  # Linux-only
  // lib.optionalAttrs (!isDarwin) {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [ keys.nobe4_verdi ];
  };
}
