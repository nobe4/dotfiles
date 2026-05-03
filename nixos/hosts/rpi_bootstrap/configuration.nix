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
        ../../packages/mdns.nix
      ];

      sdImage.compressImage = false;
      image.fileName = "${config.networking.hostName}.img";

      users.users.root = {
        openssh.authorizedKeys.keys = [
          # TODO: how to manage ssh keys properly? one pre host, one per identity,
          # ...?
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIkBqUZ30Oh8l+Ifpb9ibWG4brDeC1a3cplV+h3e6/Ba"
        ];
        # This is a temporary root password that will be overidden later.
        password = "root";
      };

      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "prohibit-password";
          PasswordAuthentication = false;
        };
      };

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

      system.stateVersion = "25.05"; # Do not change
    };
}).config.system.build.sdImage
