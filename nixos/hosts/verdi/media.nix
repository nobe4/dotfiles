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
  ];

  ln = with config; [
    [
      "imv"
      "${home}/.config/imv"
    ]
  ];
}
