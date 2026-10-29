{
  config,
  pkgs,
  ...
}:
let
  agenix = import ../../../packages/age.nix { inherit pkgs; };
in
{
  imports = [ agenix.module ];

  age = {
    identityPaths = [ "${config.home}/.ssh/id_ed25519" ];
    secrets.slack-mark-read = {
      file = ../../../secrets/wagner-slack-mark-read.age;
      owner = config.system.primaryUser;
      group = "staff";
    };
  };

  users.users.nobe4.packages = [ agenix.cli ];

  launchd.user.agents."fr.nobe4.slack-mark-read".serviceConfig = {
    ProgramArguments = [
      "/bin/zsh"
      "-lc"
      "${config.dotfiles}/bin/slack-mark-read < ${config.age.secrets.slack-mark-read.path}"
    ];
    RunAtLoad = true;
    StartInterval = 3600;
    StandardOutPath = "${config.home}/Library/Logs/fr.nobe4.slack-mark-read.log";
    StandardErrorPath = "${config.home}/Library/Logs/fr.nobe4.slack-mark-read.error.log";
  };
}
