# Defines all nix-related options.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    }
    // lib.optionalAttrs (!isDarwin) { dates = "weekly"; }
    // lib.optionalAttrs isDarwin {
      interval = {
        Weekday = 7;
        Hour = 0;
        Minute = 0;
      };
    };
  };

  users.users.nobe4.packages = with pkgs; [
    nix-search-tv

    (import ./nix-rebuild.nix { inherit pkgs config; })
  ];

  ln-root =
    [ ]
    ++
      # nix-darwin ship an environment.darwinConfig that is enough
      (lib.optional (!isDarwin)
        # TODO: how to store some common paths in the config.
        # E.g. `DOTFILE_FOLDER`, `NIXOS_FOLDER`, ...
        [
          "/home/nobe4/dev/nobe4/dotfiles/nixos/hosts/${config.networking.hostName}/configuration.nix"
          "/etc/nixos/configuration.nix"
        ]
      );

}
