{ pkgs, ... }:
{
  packages = with pkgs; [
    git
    nixfmt
    nixd
    bash-language-server
    shellcheck
    vale
    vale-ls
    marksman
    lua-language-server
  ];
}
