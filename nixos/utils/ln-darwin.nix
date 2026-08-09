# Collect all the link tuples and link them.
# Special case for darwin
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
      List of user symlinks as [ rel, dst ] tuples.
      rel is relative to the dotfiles repo root.

      E.g.
      ln = [
        [ "nvim" "''${config.home}/.config/nvim" ]
      ]
    '';
  };

  options.ln-root = lib.mkOption {
    type = with lib.types; listOf (listOf str);
    default = [ ];
    description = ''
      List of root symlinks as [ rel, dst ] tuples.
      rel is relative to the dotfiles repo root.

      E.g.
      ln-root = [
        [ "bin/foo" "/usr/local/bin/foo" ]
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
          rel = builtins.elemAt tuple 0;
          dst = builtins.elemAt tuple 1;
          src = "${config.dotfiles}/${rel}";
        in
        ''
          # Need to override HOME just for this execution, and
          # we cannot do `X=a Y=b ln ...` because of https://www.shellcheck.net/wiki/SC2097
          (
            HOME=${config.home}
            mkdir -p "$(dirname ${dst})"
            if [ -d "${dst}" ] && [ ! -L "${dst}" ]; then
              rm -rf "${dst}"
            fi
            ln --verbose --force --symbolic --no-target-directory "${src}" "${dst}" 1>&2
          )
        ''
      ) (config.ln ++ config.ln-root)
    )
  );
}
