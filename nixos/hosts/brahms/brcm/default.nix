{ pkgs, ... }:
{
  # https://wiki.t2linux.org/guides/wifi-bluetooth/
  # https://wiki.t2linux.org/distributions/nixos/installation/#wi-fi-and-bluetooth-setup
  # Generated with method 2
  hardware.firmware = [
    (pkgs.stdenvNoCC.mkDerivation (final: {
      name = "brcm-firmware";
      src = ./firmware.tar;
      dontUnpack = true;
      installPhase = ''
        mkdir -p $out/lib/firmware/brcm
        tar -xf ${final.src} -C $out/lib/firmware/brcm
      '';
    }))
  ];
}
