# Define all things gaming-related.
{ pkgs, ... }:
{
  allowedUnfree = [
    "steam-unwrapped"
    "steam"
    "lutris"
  ];

  users.users.nobe4.packages = with pkgs; [
    prismlauncher
    steam
    lutris
    # needed to run some windows game on linux
    # also see protondb.com
    gamescope
  ];
}
