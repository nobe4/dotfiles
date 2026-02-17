# Defines all dependencies for development work.
{ pkgs, ... }:
{
  users.users.nobe4.packages = with pkgs; [
    kitty

    entr
    fzf

    git
    difftastic
    gh

    fzf
    ripgrep
    pv
    universal-ctags

    direnv
    devenv

    tldr
    gojq
    yq-go # Doesn't support all that gojq do, but is usefull for non-json languages

    nodejs # needed globally to run the copilot lsp

    # # Build tools
    # gnumake
    # gcc
    #
    # # Go
    # go
    # gopls
    # golangci-lint
    #
    # # YAML
    # yaml-language-server
    # yamlfmt
    # yamllint
  ];

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

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

  ln-root = [
    [
      "${pkgs.gojq}/bin/gojq"
      "/usr/bin/jq"
    ]
  ];
}
