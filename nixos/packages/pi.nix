{
  config,
  pkgs,
  ...
}:
let
  pi-coding-agent = pkgs.pi-coding-agent.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      substituteInPlace \
        "$out/lib/node_modules/pi-monorepo/dist/modes/interactive/components/assistant-message.js" \
        --replace-fail \
        "new Markdown(content.text.trim(), 1, 0, this.markdownTheme)" \
        "new Markdown(content.text.trim(), 0, 0, this.markdownTheme)"
    '';
  });
in
{
  users.users.nobe4.packages = [ pi-coding-agent ];

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
