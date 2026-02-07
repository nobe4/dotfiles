{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cmake
    fd
    file
    git
    htop
    lsof
    moreutils
    neovim
    tree
    zip
    unzip
    usbutils
  ];
}
