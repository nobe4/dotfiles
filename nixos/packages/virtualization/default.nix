{ ... }:
{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "nobe4" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
