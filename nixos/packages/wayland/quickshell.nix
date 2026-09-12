{
  config,
  ...
}:
{
  users.users.nobe4.packages = with config.pkgs; [ quickshell ];

  ln = [
    [
      "quickshell"
      "${config.home}/.config/quickshell"
    ]
  ];
}
