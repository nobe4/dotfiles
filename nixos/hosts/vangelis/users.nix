{ ... }:
let
  ssh_keys = import ../../packages/ssh_keys.nix;
in
{
  users.users = {
    root.openssh.authorizedKeys.keys = [
      ssh_keys.nobe4_verdi
    ];

    nobe4 = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      openssh.authorizedKeys.keys = [ ssh_keys.nobe4_verdi ];
    };
  };

  # Don't require a password for sudo for nobe4.
  security.sudo.extraRules = [
    {
      users = [ "nobe4" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
