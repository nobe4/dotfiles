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
    default = "${config.home}/dev/nobe4/dotfiles";
    description = "Path to the dotfiles folder.";
  };
}
