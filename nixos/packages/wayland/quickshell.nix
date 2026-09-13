{
  pkgs,
  config,
  ...
}:
{
  users.users.nobe4.packages = with pkgs; [ quickshell ];

  services.upower.enable = true;

  ln = [
    [
      "quickshell"
      "${config.home}/.config/quickshell"
    ]
  ];
}
