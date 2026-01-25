{ pkgs, ... }:
{
  imports = [
    /etc/nixos/hardware-configuration.nix

    ../packages/allowed_unfree.nix

    ../nix.nix
    ../network.nix
    ../dev.nix
    ../media.nix
    ../gaming.nix

    ../services/1password.nix
    ../services/keyboard.nix
    ../font.nix
  ];

  time.timeZone = "Europe/Berlin";

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

  services = {
    # Audio

    # See pavucontrol for advanced
    pipewire = {
      enable = true;

      wireplumber = {
        enable = true;
      };
    };

    displayManager.ly.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;

  users.users.nobe4 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;

    packages = with pkgs; [
      hyprcursor
      hyprlock
      hyprpicker
      hypridle
      nix-search-tv
      wev

      wl-clipboard

      # Notifcations
      mako
      libnotify

      waybar
      rofi

      apple-cursor
      adwaita-icon-theme

      # will need to find a way to do without
      # currently the scarlite has 2 separate output, which should be merged into one.
      # + how to integrate that in waybar
      pavucontrol
      playerctl # for media play-pause control

      chromium # xbox-live doesn't support firefox

      nwg-look # NOTE: need to run it once to set the default values

      gnupg
      pinentry-qt

      signal-desktop

      # Espanso is currently not working on NixOS/Wayland:
      # https://github.com/espanso/espanso/issues/2313
      # https://github.com/NixOS/nixpkgs/pull/328890
      # espanso-wayland
    ];
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    neovim
    file
    tree
    lsof
    usbutils
    git
    unzip
    zip
    htop
    entr
  ];

  programs.firefox.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  environment.shells = with pkgs; [ zsh ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;

    # This seems to be needed for steam
    # xwayland.enable = false;
  };

  security.polkit.enable = true;

  # programs.mtr.enable = true;
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
