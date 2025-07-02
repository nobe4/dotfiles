{ lib, pkgs, ... }:

{
  imports = [ /etc/nixos/hardware-configuration.nix ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable Graphical stuff to happen.
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  time.timeZone = "Europe/Berlin";

  # TODO: link to fix
  systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP =
    "X-NIXOS-SYSTEMD-AWARE";

  # Some packages aren't free, but I still want them
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam-unwrapped"
      "steam"
      "apple_cursor"
      "1password"
      "1password-cli"
      "1password-gui"
    ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  services = {
    # Audio

    # See pavucontrol for advanced
    pipewire = {
      enable = true;

      wireplumber = { enable = true; };
    };

    displayManager.ly.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;

  users.users.nobe4 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;

    packages = with pkgs; [
      steam
      kitty
      vlc

      hyprcursor
      hyprlock
      hyprpicker
      hypridle

      wl-clipboard # clipboard
      slurp # get screen coordinate
      swappy # image edition
      pngquant # png compression
      grim # screenshot

      # TODO: https://github.com/emersion/mako/blob/master/doc/mako.5.scd
      mako # wayland notification manager
      waybar # wayland status bar
      rofi
      wev # Wayland event viewer, for debugging

      apple-cursor

      # will need to find a way to do without
      # currently the scarlite has 2 separate output, which should be merged into one.
      # + how to integrate that in waybar
      pavucontrol
      playerctl # for media play-pause control

      chromium # xbox-live doesn't support firefox

      # TODO: find an alternative.
      # used to set theme to dark
      # https://github.com/nwg-piotr/nwg-look

      gnumake
      gcc
      clang
      mise
      fzf
      ripgrep
      gnupg
      pinentry-tty

      # Rust
      cargo

      # Go
      go
      gopls
      golangci-lint

      # Prose
      vale
      vale-ls

      # Lua
      lua-language-server

      # YAML
      yaml-language-server
      yamlfmt
      yamllint

      # Python
      black

      # Bash
      shellcheck
      bash-language-server

      # Nix
      nixd
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

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "nobe4" ];
  };

  security.polkit.enable = true;

  fonts.packages = with pkgs; [ hack-font font-awesome ];

  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  networking = {
    hostName = "verdi";

    # TODO: nixos comes with baked-in iptable rules, which I may want to change later.
    firewall = { allowedTCPPorts = [ 8080 ]; };

    wireless.iwd = {
      # Do the config with iwctl
      enable = true;
      settings = { Settings.AutoConnect = true; };
    };
  };

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # See https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "25.05"; # Do not change
}
