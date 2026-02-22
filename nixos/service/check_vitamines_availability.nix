{ pkgs, config, ... }:
let
  notify = import ../packages/notify.nix { inherit pkgs config; };
in
{
  systemd.user = {
    services.check-if-vitamines-are-available = {
      enable = true;
      description = "check if vitamines are available";
      path = [
        pkgs.bash
        pkgs.curl
        notify
      ];

      serviceConfig = {
        Type = ''oneshot'';
        ExecStart = ''
          ${pkgs.bash}/bin/bash -c /home/nobe4/dev/nobe4/dotfiles/bin/check_if_vitamines_are_available.sh
        '';
      };
    };

    timers.check-if-vitamines-are-available = {
      enable = true;
      after = [ "network.target" ];
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnBootSec = "15min";
        OnUnitActiveSec = "1h";
        Persistent = true;
      };
    };
  };
}
