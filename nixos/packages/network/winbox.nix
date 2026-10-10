# Define all things network related.
{ pkgs, ... }:
{
  users.users.nobe4.packages = with pkgs; [
    winbox4
  ];

  programs.winbox = {
    package = pkgs.winbox4;
    enable = true;
    openFirewall = true;
  };
}
