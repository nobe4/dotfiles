{ pkgs, ... }:
let
  vnc-server = {
    addr = "127.0.0.1";
    port = 5900;
  };

  vnc-client = {
    addr = "0.0.0.0";
    port = 5901;
  };

  novnc = pkgs.novnc.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      ln -s $out/share/webapps/novnc/vnc.html $out/share/webapps/novnc/index.html
    '';
  });

in
{
  users.users.nobe4.packages = [
    pkgs.wayvnc
    novnc

    (pkgs.writeShellScriptBin "vnc" ''
      systemctl --user ''${1:?} vnc-server vnc-client
      echo 'see port ${toString vnc-client.port} on'
      ip a | grep 10.0.0 | awk '{ print $2; }'
    '')
  ];

  networking.firewall.allowedTCPPorts = [
    vnc-client.port
  ];

  systemd.user.services = {
    vnc-server = {
      description = "VNC server";
      serviceConfig = {
        ExecStart = ''
          ${pkgs.wayvnc}/bin/wayvnc \
            --render-cursor \
            ${vnc-server.addr} ${toString vnc-server.port}
        '';
      };
    };

    vnc-client = {
      description = "VNC client";
      path = [
        pkgs.procps
      ];
      serviceConfig = {
        ExecStart = ''
          ${novnc}/bin/novnc \
            --listen ${vnc-client.addr}:${toString vnc-client.port} \
            --vnc ${vnc-server.addr}:${toString vnc-server.port} \
            --file-only
        '';
      };
    };
  };
}
