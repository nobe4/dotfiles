{
  config,
  ...
}:
{
  programs.hyprlock.enable = true;
  ln = with config; [
    [
      "hypr/hyprlock.conf"
      "${home}/.config/hypr/hyprlock.conf"
    ]
  ];
}
