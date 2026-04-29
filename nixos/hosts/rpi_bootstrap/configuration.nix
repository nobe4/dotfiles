{
  hostName ? throw "--argstr hostName is required",
  ssid ? throw "--argstr ssid is required",
  psk ? throw "--argstr psk is required",
  system ? "aarch64-linux",
}:
(import <nixpkgs/nixos> {
  inherit system;
  configuration =
    { config, ... }:
    {
      imports = [
        <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
        ../../users/nobe4.nix
      ];

      sdImage.compressImage = false;
      image.fileName = "${config.networking.hostName}.img";

      # TODO: temporary test
      users.users.nobe4.password = "n";

      services.openssh = {
        enable = true;
      };

      time.timeZone = "Europe/Berlin";
      networking = {
        inherit hostName;
        wireless = {
          enable = true;
          networks = {
            "${ssid}" = {
              pskRaw = "${psk}";
            };
          };
        };
      };
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

      # TODO: run `sudo nix-channel --update` at boot
      # environment.etc."nixos/configuration.nix" = {
      #   text = builtins.readFile ./configuration.nix;
      # };

      # # Lingering means that nobe4's systemd will start at boot
      # users.users.nobe4.linger = true;
      # # Test for auto-starting services
      # systemd.user = {
      #   services.startup-test =
      #     let
      #       script = pkgs.writeShellScript "startup-test" ''
      #         #!/bin/sh
      #         ${pkgs.coreutils}/bin/date >> /tmp/startup-time.log
      #       '';
      #     in
      #     {
      #       enable = true;
      #       description = "ensure that startup can run scripts";
      #       serviceConfig = {
      #         Type = "oneshot";
      #         ExecStart = script;
      #         RemainAfterExit = true;
      #       };
      #       wantedBy = [ "default.target" ];
      #     };
      # };

      system.stateVersion = "25.05"; # Do not change
    };
}).config.system.build.sdImage
