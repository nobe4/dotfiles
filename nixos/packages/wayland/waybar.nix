{
  pkgs,
  config,
  ...
}:
{
  users.users.nobe4.packages = with pkgs; [ waybar ];

  ln = with config; [
    [
      "waybar"
      "${home}/.config/waybar"
    ]
  ];
}
