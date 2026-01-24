{ pkgs, ... }:
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

    # Screenshot
    swappy
    slurp
    grim
    gpu-screen-recorder
  ];
}
