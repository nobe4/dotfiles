{
  pkgs,
  lib,
  options,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  # Required by devenv to update the nix store.
  nix.settings.trusted-users = [ "nobe4" ];

  # https://wiki.nixos.org/wiki/User_management
  # https://nixos.org/manual/nixos/stable/options#opt-users.users
  # https://nix-darwin.github.io/nix-darwin/manual/#opt-users.users
  users.users.nobe4 = {
    description = "nobe4";
    home = if isDarwin then "/Users/nobe4" else "/home/nobe4";
  }
  // lib.optionalAttrs (options.programs.zsh.enable == true) {
    shell = pkgs.zsh;
  }
  # Linux-only
  // lib.optionalAttrs (!isDarwin) {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      # TODO: how to manage ssh keys properly? one pre host, one per identity,
      # ...?
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIkBqUZ30Oh8l+Ifpb9ibWG4brDeC1a3cplV+h3e6/Ba"
    ];
  };
}
