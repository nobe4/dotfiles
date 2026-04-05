{
  options,
  ...
}:
{
  imports = [
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
    ../../users/nobe4.nix
  ];

  sdImage.compressImage = false;
  image.fileName = "${options.networking.hostName}.img";

  # TODO: temporary test before I install agenix. This is 'n', which is not my
  # real password.
  users.users.nobe4.hashedPassword = "$y$j9T$WNI82Lb01b1Nc4bm0dREM/$2vL558bdyoMMGgGQAPMlrpHUcv8O0KdOQlIxv0wxLwA";

  time.timeZone = "Europe/Berlin";
  networking.hostName = "bach";

  environment.etc."nixos/configuration.nix" = {
    text = builtins.readFile ./configuration.nix;
  };

  system.stateVersion = "25.05"; # Do not change
}
