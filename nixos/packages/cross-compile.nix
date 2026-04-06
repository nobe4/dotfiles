{ ... }:
{
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  nix.settings.extra-platforms = [
    "aarch64-linux"
    "arm-linux"
  ];

}
