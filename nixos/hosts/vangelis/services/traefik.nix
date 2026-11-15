{
  config,
  pkgs,
  lisailPort,
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

      routers.lisail = {
        entryPoints = [ "https" ];
        rule = "Host(`lisail.org`)";
        service = "lisail";
        middlewares = [ "lisail-auth" ];
        tls.certResolver = "letsencrypt";
      };
      services.lisail.loadBalancer.servers = [
        { url = "http://127.0.0.1:${toString lisailPort}"; }
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
