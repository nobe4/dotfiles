{
  config,
  lib,
  ...
}: let
  cfge = config.environment;
  cfg = config.programs.bash;

  bashAliases = builtins.concatStringsSep "\n" (
    lib.mapAttrsToList (k: v: "alias -- ${k}=${lib.escapeShellArg v}") (
      lib.filterAttrs (k: v: v != null) cfg.shellAliases
    )
  );
in {
  options = {
    programs.bash = {
      shellAliases = lib.mkOption {
        default = { };
        description = ''
          Set of aliases for bash shell, which overrides {option}`environment.shellAliases`.
          See {option}`environment.shellAliases` for an option format description.
        '';
        type = with lib.types; attrsOf (nullOr (either str path));
      };
    };
  };
  config = lib.mkIf cfg.enable {
    programs.bash = {
      # not sure if this line works?
      shellAliases = builtins.mapAttrs (name: lib.mkDefault) cfge.shellAliases;
      interactiveShellInit = ''
        # Load Custom Shell Aliases
        ${bashAliases}
      '';
    };
  };
}
