{
  pkgs,
  config,
  ...
}:
{
  # No display manager. Login on TTY, then run `hyprland-start`.
  services.getty.helpLine = "help: use hyprland-start";

  programs.hyprland.enable = true;

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
