{ ... }:
{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      domain = true;
      addresses = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };
}
