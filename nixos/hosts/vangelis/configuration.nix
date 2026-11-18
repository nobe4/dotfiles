{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./users.nix
    ./network.nix
    ./ssh.nix
    ./services/traefik.nix
    ./services/drop.nix
    ./services/linote.nix
  ];

  deployment = {
    targetHost = "51.83.202.194";
    # First deploy needs to use root before nobe4 is trusted.
    # targetUser = lib.mkForce "root";
  };

  # Allow nobe4 to update the nix store and decrypt age secrets at deploy.
  nix.settings.trusted-users = [
    "root"
    "nobe4"
  ];
  age.identityPaths = [ "/home/nobe4/.ssh/id_ed25519" ];

  # True during bootstrap to force the grub selection.
  # boot.initrd.systemd.enable = false;
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  environment.systemPackages = with pkgs; [
    unixtools.netstat
    vim
  ];

  system.stateVersion = "26.05";
}
