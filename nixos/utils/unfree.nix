let
  stable = [
    "1password"
    "1password-cli"
    "1password-gui"
    "discord"
    "lutris"
    "steam"
    "steam-unwrapped"
    "winbox"
  ];
  unstable = [
    "github-copilot-cli"
  ];
  predicate = list: pkg: builtins.elem (pkg.pname or (builtins.parseDrvName pkg.name).name) list;
in
{
  stable = predicate stable;
  unstable = predicate unstable;
}
