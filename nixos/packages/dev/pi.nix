{
  config,
  pkgs-unstable,
  ...
}:
{
  users.users.nobe4.packages = [ pkgs-unstable.pi-coding-agent ];

  ln = with config; [
    [
      "pi/agent/extensions"
      "${home}/.pi/agent/extensions"
    ]
    [
      "pi/agent/skills"
      "${home}/.pi/agent/skills"
    ]
    [
      "pi/agent/themes"
      "${home}/.pi/agent/themes"
    ]
    [
      "pi/agent/settings.json"
      "${home}/.pi/agent/settings.json"
    ]
  ];

  environment.variables.PI_SKIP_VERSION_CHECK = "1";
}
