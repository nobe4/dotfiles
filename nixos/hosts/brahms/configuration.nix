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
    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/apple/t2"

    ../../utils/ln.nix

    ../../users/nobe4.nix
  ];

  # TODO: move to a module with the import.
  # macos t2 specific
  hardware.firmware = [
    (pkgs.stdenvNoCC.mkDerivation (final: {
      name = "brcm-firmware";
      src = ./firmware.tar;
      dontUnpack = true;
      installPhase = ''
        mkdir -p $out/lib/firmware/brcm
        tar -xf ${final.src} -C $out/lib/firmware/brcm
      '';
    }))
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  # Prevent a nixos-switch to stop those services, loosing connections from an
  # ssh build.
  systemd.services = {
    NetworkManager.stopIfChanged = false;
    dbus-broker.stopIfChanged = false;
  };

  # TODO: end move

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
    wget
    git
    htop
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.11"; # Did you read the comment?
}
