{ lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./users.nix
  ];

  deployment = {
    targetHost = "51.83.202.194";
    targetUser = lib.mkForce "root";
  };

  # Was true during bootstrap
  #  boot.initrd.systemd.enable = false;
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  networking = {
    hostName = "vangelis";

    # network is managed by OVH
    networkmanager.enable = false;

    interfaces.ens3 = {
      useDHCP = true;

      ipv6.addresses = [
        {
          address = "2001:41d0:601:1100::223";
          prefixLength = 128;
        }
      ];

      ipv6.routes = [
        {
          address = "2001:41d0:601:1100::";
          prefixLength = 64;
        }
      ];
    };

    defaultGateway6 = {
      address = "2001:41d0:601:1100::1";
      interface = "ens3";
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  system.stateVersion = "26.05";
}
