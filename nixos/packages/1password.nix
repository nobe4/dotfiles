{ pkgs, lib, ... }:

{

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
  }
  // lib.optionalAttrs (!pkgs.stdenv.isDarwin) {
    # TODO: how to make this dynamic?
    polkitPolicyOwners = [ "nobe4" ];
  };
}
