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
in
{
  users.users.nobe4.packages = with pkgs; [
    wayvnc
    novnc

    (pkgs.writeShellScriptBin "vnc-start" ''
      systemctl --user start vnc-server
      systemctl --user start vnc-client
    '')
    (pkgs.writeShellScriptBin "vnc-stop" ''
      systemctl --user stop vnc-server
      systemctl --user stop vnc-client
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
            --show-performance \
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
          ${pkgs.novnc}/bin/novnc \
            --listen ${vnc-client.addr}:${toString vnc-client.port} \
            --vnc ${vnc-server.addr}:${toString vnc-server.port} \
            --file-only
        '';
      };
    };
  };
}
