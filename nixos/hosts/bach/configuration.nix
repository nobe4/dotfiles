{
  pkgs,
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

  # Lingering means that nobe4's systemd will start at boot
  users.users.nobe4.linger = true;
  # Test for auto-starting services
  systemd.user = {
    services.startup-test =
      let
        script = pkgs.writeShellScript "startup-test" ''
          #!/bin/sh
          ${pkgs.coreutils}/bin/date >> /tmp/startup-time.log
        '';
      in
      {
        enable = true;
        description = "ensure that startup can run scripts";
        serviceConfig = {
          Type = "oneshot";
          ExecStart = script;
          RemainAfterExit = true;
        };
        wantedBy = [ "default.target" ];
      };
  };

  system.stateVersion = "25.05"; # Do not change
}
