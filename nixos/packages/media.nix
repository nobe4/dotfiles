{ config, pkgs, ... }:
{
  users.users.nobe4.packages = with pkgs; [
    # Video
    vlc
    ffmpeg

    # Image
    gimp
    inkscape
    pngquant
    imv

    # Audio
    musescore

    # will need to find a way to do without
    # currently the scarlite has 2 separate output, which should be merged into one.
    # + how to integrate that in waybar
    pavucontrol
    playerctl # for media play-pause control
  ];

  ln = with config; [
    [
      "imv"
      "${home}/.config/imv"
    ]
  ];
}
