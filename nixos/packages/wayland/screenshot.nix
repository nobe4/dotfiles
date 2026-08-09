{ pkgs, ... }:
{
  users.users.nobe4.packages = with pkgs; [
    swappy
    slurp
    grim
    gpu-screen-recorder
  ];
}
