{
  config,
  lib,
  ...
}:
let
  cfge = config.environment;
  cfg = config.programs.zsh;
in
{
  options = {
    programs.zsh = {
      setOptions = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [
          "HIST_IGNORE_DUPS"
          "SHARE_HISTORY"
          "HIST_FCNTL_LOCK"
        ];
        example = [
          "EXTENDED_HISTORY"
          "RM_STAR_WAIT"
        ];
        description = ''
          Configure zsh options. See
          {manpage}`zshoptions(1)`.
        '';
      };
    };

  };

  config = lib.mkIf cfg.enable {
    environment.etc.zshrc.text = lib.mkAfter ''
      ${lib.optionalString (cfg.setOptions != [ ]) ''
        # Set zsh options.
        setopt ${builtins.concatStringsSep " " cfg.setOptions}
      ''}
    '';
  };
}
