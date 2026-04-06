# Wayland-related resources
{ pkgs, ... }:
{
  # See https://github.com/NixOS/nixpkgs/blob/b15c73d61ccd7f86995da13ef45f399db53351f4/nixos/modules/services/x11/display-managers/default.nix#L39-L61
  systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
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
    (hyprsunset.overrideAttrs {
      # Waiting for a release that ships https://github.com/hyprwm/hyprsunset/pull/62
      version = "0f4e35a103b2f7408932bbc928823de6fee97b57";
      src = pkgs.fetchFromGitHub {
        owner = "hyprwm";
        repo = "hyprsunset";
        rev = "0f4e35a103b2f7408932bbc928823de6fee97b57";
        hash = "sha256-I31T8qA7ixC0QUUQnU6LaadqJ7Rx+WQ2nsMvZ7OfX+U=";
      };
    })

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
