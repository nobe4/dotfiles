{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cmake
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
    pv # really useful for checking progress instead of cat or dd
  ];
}
