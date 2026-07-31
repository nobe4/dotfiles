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
  imports = [ ./dotfiles.nix ];

  options.ln = lib.mkOption {
    type = with lib.types; listOf (listOf str);
    default = [ ];
    description = ''
      List of user symlinks to create as [ src, dst ] tuples.
      Use config.dotfiles and config.home for paths.

      E.g.
      ln = [
        [ "''${config.dotfiles}/src" "''${config.home}/dst" ]
      ]
    '';
  };

  config.system.userActivationScripts.ln.text = lib.concatMapStringsSep "\n" (
    tuple:
    let
      src = builtins.elemAt tuple 0;
      dst = builtins.elemAt tuple 1;
    in
    ''
      mkdir -p "$(dirname ${dst})"
      ln --verbose --force --symbolic --no-target-directory "${src}" "${dst}" >> /tmp/ln-logs 2>&1
    ''
  ) config.ln;

  options.ln-root = lib.mkOption {
    type = with lib.types; listOf (listOf str);
    default = [ ];
    description = ''
      List of root symlinks to create as [ src, dst ] tuples.
      Use config.dotfiles and config.home for paths.

      E.g.
      ln-root = [
        [ "''${config.dotfiles}/src" "/bin/dst" ]
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
