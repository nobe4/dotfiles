# Define all things network related.
{ pkgs, ... }:
{

  users.users.nobe4.packages = with pkgs; [
    dnsutils
    unixtools.route
    winbox4
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

  # ref: https://nixos.wiki/wiki/Mullvad_VPN
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn; # enables the GUI
  };

  programs.winbox = {
    package = pkgs.winbox4;
    enable = true;
    openFirewall = true;
  };
}
