# Defines all dependencies for development work.
{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  users.users.nobe4.packages =
    with pkgs;
    [
      entr
      fzf
      fd

      git
      gh
      difftastic

      ripgrep
      universal-ctags

      tldr
      tree-sitter

      # Needed globally to run the copilot lsp
      nodejs

      # Needed globally to format devenv files
      nixd
      nixfmt

      xq

      gnupg

      # # YAML
      # yaml-language-server
      # yamlfmt
      # yamllint
      #
      # Web
      # vscode-langservers-extracted
      # emmet-language-server
    ]
    ++ [
      pkgs-unstable.github-copilot-cli
      pkgs-unstable.devenv
    ]
    ++ (import ./copy_paste.nix { inherit pkgs config; })
    ++ [ (import ./notify.nix { inherit pkgs config; }) ]
    ++ (import ./jq.nix { inherit pkgs; });

  programs.direnv = {
    enable = !pkgs.stdenv.isDarwin;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  environment.variables = {
    # TODO: use DOTFILES_DIR instead
    DOTFILE_FOLDER = "${config.dotfiles}";
    DEV_PATH = "${config.home}/dev";
    DFT_SYNTAX_HIGHLIGHT = "off";
    DFT_CONTEXT = "1";
    FZF_DEFAULT_COMMAND = "rg --files --follow";
    FZF_DEFAULT_OPTS = "--no-mouse --color=16,fg+:15,bg+:-1,gutter:0,hl:2,hl+:4,pointer:4,marker:10,prompt:7,info:8,spinner:5,header:4";
    PATH = [
      "${config.dotfiles}/bin/commands"
      "${config.dotfiles}/bin"
      "${config.dotfiles}/private/bin"
      "${config.dotfiles}/private/bin/commands"
      "${config.home}/go/bin"
    ]
    ++ lib.optionals isDarwin [
      "${config.home}/Applications"
    ]
    ++ [
      "$PATH"
    ];
  };

  ln = with config; [
    [
      "nvim"
      "${home}/.config/nvim"
    ]
    [
      ".gitconfig"
      "${home}/.gitconfig"
    ]
    [
      ".gitignore_global"
      "${home}/.gitignore_global"
    ]
    [
      ".pryrc"
      "${home}/.pryrc"
    ]
    [
      ".ignore"
      "${home}/.ignore"
    ]
    [
      ".ctags.d"
      "${home}/.ctags.d"
    ]
    [
      ".vale.ini"
      "${home}/.config/vale/.vale.ini"
    ]
    [
      "gh-config.yml"
      "${home}/.config/gh/config.yml"
    ]
  ];
}
