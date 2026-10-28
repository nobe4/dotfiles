{ ... }:
{
  virtualisation.docker.enable = true;
  users.users.nobe4.extraGroups = [ "docker" ];
}
