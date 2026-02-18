{ pkgs, ... }:
{
  packages = with pkgs; [
    bash-language-server
    shellcheck
    vale
    vale-ls
    marksman
    lua-language-server
  ];
}
