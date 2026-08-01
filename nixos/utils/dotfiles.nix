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
    # TODO: this should really be '$home/.config/dotfiles' and the only
    # entrypoint that matters is then this, instead of the full path to the file.
    default = "${config.home}/.config/dotfiles";
    description = "Path to the dotfiles folder.";
  };
}
