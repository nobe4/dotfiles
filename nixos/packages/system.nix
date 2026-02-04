{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cmake
    entr
    fd
    file
    fzf
    git
    htop
    lsof
    moreutils
    neovim
    tree
    unzip
    usbutils
    zip
  ];
}
