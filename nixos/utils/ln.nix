# Collect all the link tuples and link them.
#
# Note that if config.dotfiles is a nix path (and not a string), things will be
# linked from the store, and not from the local path.
# TODO: this really should be refactored to only link the ~/.config/dotfiles
# from the store, the rest uses ~/.config/dotfiles.
{
  config,
  lib,
  ...
}:
let
  mkLinks =
    logFile: tuples:
    lib.concatMapStringsSep "\n" (
      tuple:
      let
        rel = builtins.elemAt tuple 0;
        dst = builtins.elemAt tuple 1;
        src = "${config.dotfiles}/${rel}";
      in
      ''
        mkdir -p "$(dirname ${dst})"
        if [ -d "${dst}" ] && [ ! -L "${dst}" ]; then
          rm -rf "${dst}"
        fi
        ln --verbose --force --symbolic --no-target-directory "${src}" "${dst}" >> /tmp/${logFile} 2>&1
      ''
    ) tuples;
in
{
  imports = [ ./dotfiles.nix ];

  options.ln = lib.mkOption {
    type = with lib.types; listOf (listOf str);
    default = [ ];
    description = ''
      List of user symlinks as [ rel, dst ] tuples.
      'rel' is relative to the dotfiles repo root.

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
      'rel' is relative to the dotfiles repo root.

      E.g.
      ln-root = [
        [ "bin/foo" "/usr/local/bin/foo" ]
      ]
    '';
  };

  config.system = {
    userActivationScripts.ln.text = mkLinks "ln-logs" config.ln;
    activationScripts.ln-root.text = mkLinks "ln-root-logs" config.ln-root;
  };
}
