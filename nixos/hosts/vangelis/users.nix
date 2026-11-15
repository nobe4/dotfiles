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

    tpoulet = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ ssh_keys.tpoulet_all ];
    };
  };

  # Don't require a password for sudo for nobe4.
  # Required for colmena deploys.
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
