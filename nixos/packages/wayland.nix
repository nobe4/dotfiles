# Wayland-related resources
{
  config,
  pkgs,
  ...
}:
{
  imports = [ ./font ];

  # See https://github.com/NixOS/nixpkgs/blob/b15c73d61ccd7f86995da13ef45f399db53351f4/nixos/modules/services/x11/display-managers/default.nix#L39-L61
  systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
  # TODO: see if this can be removed in favor of
  # start-hyprland on boot
  services.displayManager.ly.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;

    # This seems to be needed for steam
    # xwayland.enable = false;
  };

  services.hypridle.enable = true;
  programs.hyprlock.enable = true;

  users.users.nobe4.packages = with pkgs; [
    hyprcursor
    hyprpicker
    hyprpaper

    waybar

    # Screenshot
    swappy
    slurp
    grim
    gpu-screen-recorder

    # (hyprsunset.overrideAttrs {
    #   # Waiting for a release that ships https://github.com/hyprwm/hyprsunset/pull/62
    #   version = "0f4e35a103b2f7408932bbc928823de6fee97b57";
    #   src = pkgs.fetchFromGitHub {
    #     owner = "hyprwm";
    #     repo = "hyprsunset";
    #     rev = "0f4e35a103b2f7408932bbc928823de6fee97b57";
    #     hash = "sha256-I31T8qA7ixC0QUUQnU6LaadqJ7Rx+WQ2nsMvZ7OfX+U=";
    #   };
    # })

    wev

    wl-clipboard

    mako
    libnotify

    rofi

    # apple-cursor
    adwaita-icon-theme

    nwg-look # NOTE: need to run it once to set the default values
  ];

  ln = with config; [
    [
      "rofi"
      "${home}/.config/rofi"
    ]
    [
      "hypr"
      "${home}/.config/hypr"
    ]
    [
      "waybar"
      "${home}/.config/waybar"
    ]
    [
      "uwsm"
      "${home}/.config/uwsm"
    ]
    [
      "mako"
      "${home}/.config/mako"
    ]
    [
      "imv"
      "${home}/.config/imv"
    ]
  ];
}
