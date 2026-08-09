{
  pkgs,
  config,
  ...
}:
{
  users.users.nobe4.packages = with pkgs; [ rofi ];
  ln = with config; [
    [
      "rofi"
      "${home}/.config/rofi"
    ]
  ];
}
