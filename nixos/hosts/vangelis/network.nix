{ ... }:
{
  networking = {
    hostName = "vangelis";
    firewall.allowedTCPPorts = [
      80
      443
    ];

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
}
