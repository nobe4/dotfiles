{ pkgs, ... }:
{
  hardware.i2c.enable = true;
  users.users.nobe4 = {
    extraGroups = [ "i2c" ];
    packages = with pkgs; [
      ddcutil
    ];
  };
}
