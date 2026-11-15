{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.services.lisail = {
    port = lib.mkOption {
      type = lib.types.port;
      default = 8000;
      description = "Port used by the Lisail HTTP server.";
    };
    maintenancePort = lib.mkOption {
      type = lib.types.port;
      default = 8011;
      description = "Port used by the Lisail maintenance HTTP server.";
    };
  };

  config = {
    users.groups.lisail.members = [
      "nobe4"
      "tpoulet"
    ];

    users.users.lisail = {
      isSystemUser = true;
      group = "lisail";
      home = "/var/lib/lisail";
    };

    security.sudo.extraRules = [
      {
        groups = [ "lisail" ];
        runAs = "root";
        commands =
          map
            (command: {
              inherit command;
              options = [ "NOPASSWD" ];
            })
            [
              "/run/current-system/sw/bin/systemctl ^(start|stop|restart|reload|reset-failed) lisail([.]service)?$"
              "/run/current-system/sw/bin/systemctl ^--no-pager status lisail([.]service)?$"
              "/run/current-system/sw/bin/journalctl ^--no-pager --follow --unit lisail([.]service)?$"
            ];
      }
    ];

    systemd.services.lisail = {
      description = "Lisail HTTP server";
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.nix ];
      environment = {
        HOME = "/var/lib/lisail";
        NIX_PATH = "nixpkgs=${pkgs.path}";
        LISAIL_PORT = "${toString config.services.lisail.port}";
      };
      serviceConfig = {
        ExecStart = "/var/lib/lisail/lisail";
        User = "lisail";
        Group = "lisail";
        StateDirectory = "lisail";
        StateDirectoryMode = "2770";
        UMask = "0007";
        WorkingDirectory = "/var/lib/lisail";
        Restart = "on-failure";

        # Preserve the sandbox previously implied by DynamicUser.
        PrivateTmp = "disconnected";
        RemoveIPC = true;
        ProtectSystem = "strict";
        ProtectHome = "read-only";
        NoNewPrivileges = true;
        RestrictSUIDSGID = true;
      };
    };

    systemd.paths.lisail-restart = {
      wantedBy = [ "multi-user.target" ];
      after = [ "lisail.service" ];
      pathConfig.PathChanged = "/var/lib/lisail/lisail";
    };

    systemd.services.lisail-restart = {
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.systemd}/bin/systemctl restart lisail.service";
      };
    };
  };
}
