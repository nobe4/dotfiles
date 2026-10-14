{
  config,
  pkgs,
  ...
}:
let
  keys = import ../../packages/ssh_keys.nix;
in
{
  imports = [
    ./hardware-configuration.nix
    ./brcm

    "${
      fetchGit {
        url = "https://github.com/NixOS/nixos-hardware.git";
        rev = "60a624466c08787ee8303393b7d4752d1826f14f";
      }
    }/apple/t2"

    ../../utils/ln.nix

    ../../users/nobe4.nix

    ../../packages/shell
    ../../packages/i18n.nix
    ../../packages/system.nix
    ../../packages/network/mdns.nix
    ../../packages/network/mullvad/service.nix
    ../../packages/wayland/mini.nix
    ../../packages/kitty.nix
    ../../packages/bluetooth.nix
    ../../packages/media.nix

    ../../../private/nixos/hosts/brahms/configuration.nix
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-media-driver ];
  };

  # Repo goes into the store; symlink it to a predictable path.
  dotfiles = builtins.path {
    path = ../../..;
    name = "dotfiles";
  };

  ln = [
    [
      ""
      "${config.home}/.config/dotfiles"
    ]
  ];

  # Don't require a password for sudo for nobe4.
  # This is important for colmena apply to work.
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

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot = {
      enable = true;

      # macOS's boot is 100MB, so we need to limit the size.
      configurationLimit = 5;

      # on T2, EFI vars are blocked, so we can't confirm that the install was
      # successful. But it still installs the new version.
      graceful = true;
    };
    efi.efiSysMountPoint = "/boot";
  };

  users.users.nobe4 = {
    openssh.authorizedKeys.keys = [ keys.nobe4_verdi ];
  };
  services.openssh.enable = true;

  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };

  networking = {
    hostName = "brahms";

    networkmanager.enable = true;

    firewall = {
      allowedTCPPorts = [ 8080 ];
    };
  };

  console.keyMap = "colemak";

  services.logind.lidSwitch = "ignore";

  environment.systemPackages = with pkgs; [
    vim
    git
    htop
    kitty
    firefox
  ];

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
  system.stateVersion = "26.05"; # Did you read the comment?
}
