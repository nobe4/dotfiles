# Defines all dependencies for development work.
{ pkgs, ... }:
{
  # TODO: how to ling `gojq` to `jq` for global use?
  # Old way:
  # # Making `jq` available for all process tho it's installed as `gojq`.
  # # This is somewhat easier than an alias or a function.
  # ln -s "${BREW_PREFIX}/bin/gojq" "${BREW_PREFIX}/bin/jq"

  users.users.nobe4.packages = with pkgs; [
    kitty

    entr
    fzf

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

  ln = [
    [
      "$DOTFILE_FOLDER/nvim/"
      "$HOME/.config/nvim"
    ]
    [
      "$DOTFILE_FOLDER/.gitconfig"
      "$HOME/.gitconfig"
    ]
    [
      "$DOTFILE_FOLDER/.gitignore_global"
      "$HOME/.gitignore_global"
    ]
    [
      "$DOTFILE_FOLDER/.pryrc"
      "$HOME/.pryrc"
    ]
    [
      "$DOTFILE_FOLDER/kitty/"
      "$HOME/.config/kitty"
    ]
    [
      "$DOTFILE_FOLDER/.ignore"
      "$HOME/.ignore"
    ]
    [
      "$DOTFILE_FOLDER/.ctags.d"
      "$HOME/.ctags.d"
    ]
    [
      "$DOTFILE_FOLDER/.vale.ini"
      "$HOME/.config/vale/.vale.ini"
    ]
    [
      "$DOTFILE_FOLDER/gh-config.yml"
      "$HOME/.config/gh/config.yml"
    ]
  ];
}
