{ pkgs, ... }:
{
  imports = [
    /etc/nixos/hardware-configuration.nix

    ../utils/allowed_unfree.nix
    ../utils/ln.nix

    ../users/nobe4.nix

    ../packages/system.nix
    ../packages/wayland.nix
    ../packages/gaming.nix
    ../packages/1password.nix
    ../packages/keyboard.nix
    ../packages/font
    ../packages/network.nix

    ../service/check_vitamines_availability.nix

    ../nix.nix
    ../dev.nix
    ../media.nix

  ];

  time.timeZone = "Europe/Berlin";

  networking.hostName = "verdi";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable Graphical stuff to happen.
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # See https://github.com/NixOS/nixpkgs/blob/b15c73d61ccd7f86995da13ef45f399db53351f4/nixos/modules/services/x11/display-managers/default.nix#L39-L61
  systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";

  allowedUnfree = [
    "apple_cursor"
  ];

  # Audio
  # See pavucontrol for advanced
  services.pipewire = {
    enable = true;

    wireplumber = {
      enable = true;
    };
  };

  users.users.nobe4 = {
    packages = with pkgs; [
      nix-search-tv

      # will need to find a way to do without
      # currently the scarlite has 2 separate output, which should be merged into one.
      # + how to integrate that in waybar
      pavucontrol
      playerctl # for media play-pause control

      gnupg
      pinentry-qt

      signal-desktop

      # needed for envsubst
      gettext
      chromium # Seems that `programs.chromium` doesn't get it done
    ];
  };

  # TODO: check why those are programs, and what benefits vs
  # users.users.<x>.packages.
  programs.firefox.enable = true;

  security.polkit.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # See https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "25.05"; # Do not change
}
