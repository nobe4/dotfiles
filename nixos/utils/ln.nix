# Collect all the link tuples and link them.
#
# This uses a system.userActivationScripts to access files outside of
# /nix/store.
{
  config,
  lib,
  ...
}:
{
  options.ln = lib.mkOption {
    type = with lib.types; listOf (listOf str);
    default = [ ];
    description = ''
      List of user symlinks to create as [ src, dst ] tuples.
      $HOME and $DOTFILE_FOLDER are available.

      E.g.
      ln = [
        [ "src" "$HOME/dst" ]
      ]
    '';
  };

  config.system.userActivationScripts.ln.text = lib.concatMapStringsSep "\n" (
    tuple:
    let
      src = builtins.elemAt tuple 0;
      dst = builtins.elemAt tuple 1;
    in
    # TODO: DOTFILE_FOLDER should be a nix variable
    ''
      DOTFILE_FOLDER=$HOME/dev/nobe4/dotfiles
      mkdir -p "$(dirname ${dst})"
      ln --verbose --force --symbolic --no-target-directory "${src}" "${dst}" >> /tmp/ln-logs 2>&1
    ''
  ) config.ln;

  options.ln-root = lib.mkOption {
    type = with lib.types; listOf (listOf str);
    default = [ ];
    description = ''
      List of root symlinks to create as [ src, dst ] tuples.
      $HOME is available.

      E.g.
      ln-root = [
        [ "src" "/bin/dst" ]
      ]
    '';
  };

  config.system.activationScripts.ln-root.text = lib.concatMapStringsSep "\n" (
    tuple:
    let
      src = builtins.elemAt tuple 0;
      dst = builtins.elemAt tuple 1;
    in
    ''
      mkdir -p "$(dirname ${dst})"
      ln --verbose --force --symbolic --no-target-directory "${src}" "${dst}" >> /tmp/ln-root-logs 2>&1
    ''
  ) config.ln-root;
}
