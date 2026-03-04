{ pkgs, ... }:
{
  packages = with pkgs; [
    bash-language-server
    shellcheck
    vale
    vale-ls
    marksman
    lua-language-server

    # Needed to install nvim-telescope/telescope-fzf-native.nvim
    # Assuming I'll only install it from this repo.
    gnumake
  ];
}
