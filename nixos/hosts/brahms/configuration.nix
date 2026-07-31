{
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

    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/apple/t2"

    ../../utils/ln.nix

    ../../packages/mdns.nix

    ../../users/nobe4.nix
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

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  networking.hostName = "brahms";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "colemak";

  environment.systemPackages = with pkgs; [
    vim
    git
    htop
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
  system.stateVersion = "26.05"; # Did you read the comment?
}
