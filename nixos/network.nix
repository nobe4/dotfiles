# Define all things network related.
{ pkgs, ... }:
{
  allowedUnfree = [
    "winbox"
  ];

  users.users.nobe4.packages = with pkgs; [
    dnsutils
    winbox4
  ];

  networking = {
    hostName = "verdi";

    # TODO: nixos comes with baked-in iptable rules, which I may want to change later.
    firewall = {
      allowedTCPPorts = [
        8080
        1313 # default for hugo
      ];
    };

    wireless.iwd = {
      # Do the config with iwctl
      enable = true;
      settings = {
        Settings.AutoConnect = true;
      };
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
