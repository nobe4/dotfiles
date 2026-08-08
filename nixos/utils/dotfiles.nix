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

  # TODO: see note in ln.nix
  options.dotfiles = lib.mkOption {
    type = lib.types.coercedTo lib.types.path (p: "${p}") lib.types.str;
    default = "${config.home}/.config/dotfiles";
    description = ''
      Base path for dotfiles.
      A string (e.g. "/etc/dotfiles") keeps symlinks pointing to a local repo.
      A nix path (e.g. ../../.) copies files into the store.
    '';
  };
}
