{ config, ... }:
let
  port = 8012;
in
{
  age.secrets.drop-htpasswd.file = ../../../secrets/vangelis-drop-htpasswd.age;

  systemd.tmpfiles.rules = [
    "d /var/lib/drop 2750 nobe4 nginx -"
  ];

  services.nginx.virtualHosts.drop = {
    listen = [
      {
        addr = "127.0.0.1";
        inherit port;
      }
    ];
    root = "/var/lib/drop";
    extraConfig = ''
      disable_symlinks on;
    '';
    locations."/".extraConfig = ''
      autoindex on;
    '';
    locations."~ /\\.".extraConfig = ''
      return 404;
    '';
  };

  services.traefik.dynamicConfigOptions.http = {
    middlewares.drop-auth.basicAuth = {
      usersFile = "/run/credentials/traefik.service/htpasswd-drop";
      removeHeader = true;
    };
    routers.drop = {
      entryPoints = [ "https" ];
      rule = "Host(`drop.nobe4.fr`)";
      service = "drop";
      middlewares = [ "drop-auth" ];
      tls.certResolver = "letsencrypt";
    };
    services.drop.loadBalancer.servers = [
      { url = "http://127.0.0.1:${toString port}"; }
    ];
  };

  systemd.services.traefik = {
    restartTriggers = [ config.age.secrets.drop-htpasswd.file ];
    serviceConfig.LoadCredential = [
      "htpasswd-drop:${config.age.secrets.drop-htpasswd.path}"
    ];
  };
}
