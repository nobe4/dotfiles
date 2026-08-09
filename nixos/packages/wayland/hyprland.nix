{
  pkgs,
  config,
  ...
}:
{
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

  users.users.nobe4.packages = with pkgs; [
    hyprcursor
    hyprpicker
    hyprpaper

    wl-clipboard

    # Theme
    adwaita-icon-theme
    nwg-look # NOTE: need to run it once to set the default values
  ];

  ln = with config; [
    [
      "hypr/hyprland.lua"
      "${home}/.config/hypr/hyprland.lua"
    ]
    [
      "hypr/hyprpaper.conf"
      "${home}/.config/hypr/hyprpaper.conf"
    ]
    [
      "uwsm"
      "${home}/.config/uwsm"
    ]
  ];
}
