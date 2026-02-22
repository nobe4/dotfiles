{ config, pkgs, ... }:
{
  users.users.nobe4.packages = [
    # TODO: find a better condition here, because wl-clipboard might be
    # independant of hyprland.

    (pkgs.writeShellScriptBin "copy" (
      if pkgs.stdenv.isDarwin then
        ''
          pbcopy < "$@"
        ''
      else if config.programs.hyprland.enable then
        ''
          wl-copy "$@"
        ''
      else
        ''
          echo "copy not supported"
          exit 1
        ''
    ))

    (pkgs.writeShellScriptBin "paste" (
      if pkgs.stdenv.isDarwin then
        ''
          pbpaste
        ''
      else if config.programs.hyprland.enable then
        ''
          wl-paste
        ''
      else
        ''
          echo "paste not supported"
          exit 1
        ''
    ))
  ];
}
