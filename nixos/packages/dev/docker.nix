{ ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };
  users.users.nobe4.extraGroups = [ "docker" ];
}
