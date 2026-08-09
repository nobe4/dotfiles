{
  pkgs,
  config,
  ...
}:
{
  users.users.nobe4.packages = with pkgs; [
    mako
    libnotify
  ];
  ln = with config; [
    [
      "mako"
      "${home}/.config/mako"
    ]
  ];
}
