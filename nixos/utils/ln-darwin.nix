# Collect all the link tuples and link them.
# Special case for darwin
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

  # nix-darwin doesn't support extra activationScripts like nixos, so we need
  # to piggy-back on an existing script and append to the end of it.
  # See https://github.com/nix-darwin/nix-darwin/issues/663
  config.system.activationScripts.postActivation.text = (
    lib.mkAfter (
      lib.concatMapStringsSep "\n" (
        tuple:
        let
          src = builtins.elemAt tuple 0;
          dst = builtins.elemAt tuple 1;
        in
        ''
          # Need to override HOME and DOTFILE_FOLDER just for this execution, and
          # we cannot do `X=a Y=b ln ...` because of https://www.shellcheck.net/wiki/SC2097
          (
            HOME=/Users/nobe4
            DOTFILE_FOLDER=$HOME/dev/nobe4/dotfiles
            mkdir -p "$(dirname ${dst})"
            ln --verbose --force --symbolic --no-target-directory "${src}" "${dst}" 1>&2
          )
        ''
      ) (config.ln ++ config.ln-root)
    )
  );
}
