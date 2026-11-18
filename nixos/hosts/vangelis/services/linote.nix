{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.services.linote = {
    port = lib.mkOption {
      type = lib.types.port;
      default = 8002;
      description = "Port used by the linote HTTP server.";
    };
  };

  config = {
    age.secrets.linote-htpasswd.file = ../../../secrets/vangelis-linote-htpasswd.age;

    services.traefik.dynamicConfigOptions.http = {
      middlewares.linote-auth.basicAuth = {
        usersFile = "/run/credentials/traefik.service/htpasswd-linote";
        removeHeader = true;
      };
      routers.linote = {
        entryPoints = [ "https" ];
        rule = "Host(`linote.nobe4.fr`)";
        service = "linote";
        middlewares = [ "linote-auth" ];
        tls.certResolver = "letsencrypt";
      };
      services.linote.loadBalancer.servers = [
        { url = "http://localhost:${toString config.services.linote.port}"; }
      ];
    };

    systemd.services.traefik = {
      restartTriggers = [ config.age.secrets.linote-htpasswd.file ];
      serviceConfig.LoadCredential = [
        "htpasswd-linote:${config.age.secrets.linote-htpasswd.path}"
      ];
    };

    users.groups.linote.members = [ "nobe4" ];
    users.users.linote = {
      isSystemUser = true;
      group = "linote";
      home = "/var/lib/linote";
    };

    systemd.services.linote = {
      description = "Linote HTTP server";
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.nix ];
      environment = {
        HOME = "/var/lib/linote";
        NIX_PATH = "nixpkgs=${pkgs.path}";
        LINOTE_LISTEN_ADDR = "localhost:${toString config.services.linote.port}";
      };
      serviceConfig = {
        ExecStart = "/var/lib/linote/linote";
        User = "linote";
        Group = "linote";
        StateDirectory = "linote";
        StateDirectoryMode = "2770";
        UMask = "0007";
        WorkingDirectory = "/var/lib/linote";
        Restart = "on-failure";
      };
    };

    systemd.paths.linote-restart = {
      wantedBy = [ "multi-user.target" ];
      after = [ "linote.service" ];
      pathConfig.PathChanged = "/var/lib/linote/linote";
    };

    systemd.services.linote-restart = {
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.systemd}/bin/systemctl restart linote.service";
      };
    };
  };
}
