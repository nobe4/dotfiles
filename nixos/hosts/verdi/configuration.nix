{ pkgs, ... }:
let
  agenix = import ../../packages/age.nix { inherit pkgs; };
in
{
  imports = [
    ./hardware-configuration.nix

    ../../utils/ln.nix

    ../../users/nobe4.nix

    ../../packages/nix
    ../../packages/shell
    ../../packages/system.nix
    ../../packages/wayland.nix
    ../../packages/gaming.nix
    ../../packages/1password.nix
    ../../packages/i18n.nix
    ../../packages/network.nix
    ../../packages/vnc
    ../../packages/cross-compile.nix
    ../../packages/virtualization
    ../../packages/mdns.nix
    ../../packages/dev.nix
    ../../packages/kitty.nix
    ../../packages/i2c.nix

    agenix.module

    ../../service/check_vitamines_availability.nix

    ./media.nix
  ];

  networking.hostName = "verdi";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  console.keyMap = "us";

  # Required to flash a qmk keyboard.
  hardware.keyboard.qmk.enable = true;

  # Enable Graphical stuff to happen.
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  # Audio
  # See pavucontrol for advanced
  services.pipewire = {
    enable = true;
  };

  users.users.nobe4 = {
    packages = with pkgs; [
      # will need to find a way to do without
      # currently the scarlite has 2 separate output, which should be merged into one.
      # + how to integrate that in waybar
      pavucontrol
      playerctl # for media play-pause control

      pinentry-qt

      signal-desktop
      discord

      # needed for envsubst
      gettext
      chromium # Seems that `programs.chromium` doesn't get it done

      anki

      age
      agenix.cli

      (import ../../packages/deck.nix pkgs)
    ];
  };

  # TODO: this might benefits from some refactoring, but using `ln` is not
  # possible anymore due to it being a reference to the repo's root only.
  # Bootstrap: point ~/.config/dotfiles at the repo checkout.
  system.userActivationScripts.dotfiles-link.text = ''
    ln --verbose --force --symbolic --no-target-directory \
      "/home/nobe4/dev/nobe4/dotfiles" \
      "/home/nobe4/.config/dotfiles" >> /tmp/ln-logs 2>&1
  '';

  # TODO: check why those are programs, and what benefits vs
  # users.users.<x>.packages.
  programs.firefox = {
    enable = true;

    preferences = {
      # Rendering extensions on a scaled wayland seems to cause the popup to
      # distort. Disabling this fixed the view.
      "widget.wayland.fractional-scale.enabled" = false;
    };
  };

  security.polkit.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  # See https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion
  system.stateVersion = "25.05"; # Do not change
}
