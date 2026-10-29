{ config, ... }:
{
  launchd.user.agents."fr.nobe4.gh-not-sync.hourly".serviceConfig = {
    ProgramArguments = [
      "/bin/zsh"
      "-lc"
      "${config.dotfiles}/private/bin/ght not sync --refresh-strategy force --verbosity 4"
    ];
    StartInterval = 3600;
    StandardOutPath = "${config.home}/Library/Logs/fr.nobe4.gh-not-sync.hourly.log";
    StandardErrorPath = "${config.home}/Library/Logs/fr.nobe4.gh-not-sync.hourly.error.log";
  };
}
