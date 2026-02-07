# Wayland-related resources
{ pkgs, ... }:
{
  services.displayManager.ly.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;

    # This seems to be needed for steam
    # xwayland.enable = false;
  };

  users.users.nobe4.packages = with pkgs; [
    # Hyprland
    hyprcursor
    hyprlock
    hyprpicker
    hypridle

    wev

    wl-clipboard

    mako
    libnotify

    waybar
    rofi

    apple-cursor
    adwaita-icon-theme

    nwg-look # NOTE: need to run it once to set the default values
  ];

  ln = [
    [
      "$DOTFILE_FOLDER/rofi/"
      "$HOME/.config/rofi"
    ]
    [
      "$DOTFILE_FOLDER/hypr/"
      "$HOME/.config/hypr"
    ]
    [
      "$DOTFILE_FOLDER/waybar/"
      "$HOME/.config/waybar"
    ]
    [
      "$DOTFILE_FOLDER/uwsm/"
      "$HOME/.config/uwsm"
    ]
    [
      "$DOTFILE_FOLDER/mako"
      "$HOME/.config/mako"
    ]
  ];
}
