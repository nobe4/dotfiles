{ pkgs, config, ... }:
let
  keys = import ../packages/ssh_keys.nix;
in
{
  age.secrets = {
    wifi-nwf-psk.file = ../../secrets/wifi-nwf-psk.age;
    nobe4-password.file = ../../secrets/bach-nobe4-password.age;
  };

  imports = [
    (import ../../packages/age.nix { inherit pkgs; }).module
    ../../packages/mdns.nix
  ];

  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible = {
      enable = true;
      configurationLimit = 2;
    };
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 2d";
  };

  hardware.firmware = [ pkgs.linux-firmware ];
  hardware.enableRedistributableFirmware = true;

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  time.timeZone = "Europe/Berlin";

  users = {
    mutableUsers = false;
    users.root = {
      openssh.authorizedKeys.keys = [ keys.nobe4_verdi ];
    };

    users.nobe4 = {
      isNormalUser = true;
      hashedPasswordFile = config.age.secrets.nobe4-password.path;
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;
    };
  };

  networking = {
    hostName = "bach";
    wireless = {
      enable = true;
      secretsFile = config.age.secrets.wifi-nwf-psk.path;
      networks.nwf = {
        pskRaw = "ext:psk";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    htop
  ];

  system.stateVersion = "25.05"; # Do not change
}
