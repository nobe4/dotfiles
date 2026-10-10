{
  pkgs,
  ...
}:
{
  users.users.nobe4.packages = with pkgs; [
    libnotify
  ];
}
