{
  config,
  pkgs,
  ...
}:
{
  imports = [
    (import ../../../packages/age.nix { inherit pkgs; }).module
    ./lisail.nix
  ];

  # nix-shell -p apacheHttpd --run 'htpasswd -nB <username>'
  age.secrets.lisail-htpasswd = {
    file = ../../../secrets/vangelis-lisail-htpasswd.age;
    path = "/var/lib/lisail/htpasswd";
  };

  users.users.nginx.extraGroups = [ "lisail" ];

  systemd.tmpfiles.rules = [
    "d /var/lib/lisail 2770 lisail lisail -"
  ];

  services.nginx = {
    enable = true;
    virtualHosts.lisail-maintenance = {
      listen = [
        {
          addr = "127.0.0.1";
          port = config.services.lisail.maintenancePort;
        }
      ];
      locations."/" = {
        root = "/var/lib/lisail";
        tryFiles = "/maintenance.html =503";
        extraConfig = ''
          add_header Cache-Control "no-store" always;
        '';
      };
    };
  };

  services.traefik = {
    enable = true;
    staticConfigOptions = {
      entryPoints = {
        http = {
          address = ":80";
          http.redirections.entryPoint = {
            to = "https";
            scheme = "https";
            permanent = true;
          };
        };
        https.address = ":443";
      };
      certificatesResolvers.letsencrypt.acme = {
        storage = "${config.services.traefik.dataDir}/acme.json";
        httpChallenge.entryPoint = "http";
      };
    };
    dynamicConfigOptions.http = {
      middlewares.lisail-auth.basicAuth = {
        usersFile = "/run/credentials/traefik.service/htpasswd";
        removeHeader = true;
      };
      middlewares.lisail-maintenance.errors = {
        status = [ "502-504" ];
        service = "lisail-maintenance";
        query = "/";
      };

      routers.lisail = {
        entryPoints = [ "https" ];
        rule = "Host(`lisail.org`)";
        service = "lisail";
        middlewares = [
          "lisail-auth"
          "lisail-maintenance"
        ];
        tls.certResolver = "letsencrypt";
      };
      services.lisail.loadBalancer.servers = [
        { url = "http://127.0.0.1:${toString config.services.lisail.port}"; }
      ];
      services.lisail-maintenance.loadBalancer.servers = [
        { url = "http://127.0.0.1:${toString config.services.lisail.maintenancePort}"; }
      ];
    };
  };

  systemd.services.traefik = {
    restartTriggers = [ config.age.secrets.lisail-htpasswd.file ];
    serviceConfig.LoadCredential = [
      "htpasswd:${config.age.secrets.lisail-htpasswd.path}"
    ];
  };
}
