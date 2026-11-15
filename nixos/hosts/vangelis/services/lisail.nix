{ pkgs, lisailPort, ... }:
{
  users.groups.lisail.members = [
    "nobe4"
    "tpoulet"
  ];
  users.users.lisail = {
    isSystemUser = true;
    group = "lisail";
    home = "/var/lib/lisail";
  };

  systemd.services.lisail = {
    description = "Temporary Lisail HTTP server";
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.nix ];
    environment = {
      HOME = "/var/lib/lisail";
      NIX_PATH = "nixpkgs=${pkgs.path}";
      LISAIL_PORT = "${toString lisailPort}";
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
}
