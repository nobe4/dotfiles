{
  config,
  lib,
  ...
}:
{
  options.home = lib.mkOption {
    type = lib.types.str;
    default = config.users.users.nobe4.home;
    description = "Path to the user's home folder.";
  };

  options.dotfiles = lib.mkOption {
    type = lib.types.str;
    default = "${config.home}/.config/dotfiles";
    description = ''
      Base path for dotfiles.
      Use the following to copy a to the nix store and use that path instead:

      dotfiles = builtins.path { path = ../../..; name = "dotfiles"; };
    '';
  };

  config.environment.variables = {
    # TODO: use DOTFILES_DIR instead
    DOTFILE_FOLDER = "${config.dotfiles}";
  };
}
