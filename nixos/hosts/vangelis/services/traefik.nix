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
  age.secrets.lisail-htpasswd-admin = {
    file = ../../../secrets/vangelis-lisail-htpasswd-admin.age;
  };
  age.secrets.lisail-htpasswd-alpha = {
    file = ../../../secrets/vangelis-lisail-htpasswd-alpha.age;
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
      middlewares.lisail-auth-all.basicAuth = {
        usersFile = "/run/credentials/traefik.service/htpasswd-all";
        removeHeader = true;
      };
      middlewares.lisail-auth-admin.basicAuth = {
        usersFile = "/run/credentials/traefik.service/htpasswd-admin";
        removeHeader = true;
      };

      middlewares.lisail-maintenance.errors = {
        status = [ "502-504" ];
        service = "lisail-maintenance";
        query = "/";
      };

      routers.lisail = {
        entryPoints = [ "https" ];
        rule = "Host(`lisail.org`) && !PathPrefix(`/admin`)";
        service = "lisail";
        middlewares = [
          "lisail-auth-all"
          "lisail-maintenance"
        ];
        tls.certResolver = "letsencrypt";
      };

      routers.lisail-admin = {
        entryPoints = [ "https" ];
        rule = "Host(`lisail.org`) && PathPrefix(`/admin`)";
        service = "lisail";
        middlewares = [
          "lisail-auth-admin"
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

  # TODO: this will all go once we have a proper auth system. So it's fine if
  # it's a bit dirty.
  # BasicAuth accepts one usersFile, so general routes need a combined file
  # for admin and alpha. /admin* uses only the admin file.
  # systemd mounts credentials read-only. This service generates htpasswd-all
  # first so LoadCredential can copy it into Traefik's directory at startup.
  systemd.services.traefik-htpasswd = {
    requiredBy = [ "traefik.service" ];
    before = [ "traefik.service" ];
    partOf = [ "traefik.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      RuntimeDirectory = "traefik-htpasswd";
      RuntimeDirectoryMode = "0700";
      UMask = "0077";
    };
    script = ''
      ${pkgs.gawk}/bin/awk '{ print }' \
        "${config.age.secrets.lisail-htpasswd-admin.path}" \
        "${config.age.secrets.lisail-htpasswd-alpha.path}" > /run/traefik-htpasswd/htpasswd-all
      test -s /run/traefik-htpasswd/htpasswd-all
    '';
  };

  systemd.services.traefik = {
    restartTriggers = [
      config.age.secrets.lisail-htpasswd-admin.file
      config.age.secrets.lisail-htpasswd-alpha.file
    ];
    serviceConfig.LoadCredential = [
      "htpasswd-admin:${config.age.secrets.lisail-htpasswd-admin.path}"
      "htpasswd-all:/run/traefik-htpasswd/htpasswd-all"
    ];
  };
}
