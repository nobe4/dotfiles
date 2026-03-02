{ pkgs, lib, ... }:

{
  allowedUnfree = [
    "1password"
    "1password-cli"
    "1password-gui"
  ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
  }
  // lib.optionalAttrs (!pkgs.stdenv.isDarwin) {
    # TODO: how to make this dynamic?
    polkitPolicyOwners = [ "nobe4" ];
  };
}
