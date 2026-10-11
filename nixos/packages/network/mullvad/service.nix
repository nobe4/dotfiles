# mullvad as a service, auto-start and set settings.
{ pkgs, ... }:
{
  imports = [ ./default.nix ];

  environment.systemPackages = [
    (pkgs.makeAutostartItem {
      name = "mullvad-vpn";
      package = pkgs.mullvad-vpn;
    })
  ];

  services.mullvad-vpn = {
    enableEarlyBootBlocking = true;
  };

  # Keep the VPN running while Colmena switches configurations over SSH.
  # Needs a reboot to apply.
  systemd.services = {
    mullvad-daemon = {
      after = [ "time-set.target" ];
      restartIfChanged = false;
    };
    mullvad-early-boot-blocking.restartIfChanged = false;
  };

  # ref: https://wiki.nixos.org/wiki/Mullvad_VPN#Declarative_configuration
  environment.etc."mullvad-vpn/settings.json".text = builtins.toJSON (import ./settings.nix);
}
