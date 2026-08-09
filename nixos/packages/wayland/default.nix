# All Wayland-related resources
{
  pkgs,
  ...
}:
{
  imports = [
    ../font

    ./hyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./launcher.nix
    ./notification.nix
    ./screenshot.nix
    ./waybar.nix
  ];

  # TODO: to move elsewhere.
  users.users.nobe4.packages = with pkgs; [
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

    # Debug
    wev
  ];
}
