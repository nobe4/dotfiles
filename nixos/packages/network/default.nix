# Define all things network related.
{ pkgs, ... }:
{
  users.users.nobe4.packages = with pkgs; [
    dnsutils
    unixtools.route
    unixtools.netstat
  ];

  networking = {
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };

    # TODO: nixos comes with baked-in iptable rules, which I may want to change later.
    firewall = {
      allowedTCPPorts = [
        8080
        1313 # default for hugo
      ];
    };
  };
}
