{
  config,
  ...
}:
{
  services.hypridle.enable = true;
  ln = with config; [
    [
      "hypr/hypridle.conf"
      "${home}/.config/hypr/hypridle.conf"
    ]
  ];
}
