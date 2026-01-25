# Defines all dependencies for development work.
{ pkgs, ... }:
{
  # Required by devenv to update the nix store.
  nix.settings.trusted-users = [ "nobe4" ];

  # TODO: how to ling `gojq` to `jq` for global use?
  # Old way:
  # # Making `jq` available for all process tho it's installed as `gojq`.
  # # This is somewhat easier than an alias or a function.
  # ln -s "${BREW_PREFIX}/bin/gojq" "${BREW_PREFIX}/bin/jq"

  users.users.nobe4.packages = with pkgs; [
    kitty

    difftastic

    gh

    fzf
    ripgrep

    direnv
    devenv

    tldr
    gojq

    pv

    universal-ctags

    # Eventually, most of those should live in the devenv.

    # Build tools
    gnumake
    gcc

    # Go
    go
    gopls
    golangci-lint

    # Prose
    vale
    vale-ls

    # Lua
    lua-language-server

    # YAML
    yaml-language-server
    yamlfmt
    yamllint

    # Python
    python314
    black

    # Bash
    shellcheck
    bash-language-server

    # Nix
    nixd
    nixfmt-rfc-style

    # Nodejs
    nodejs_24

    marksman
  ];
}
