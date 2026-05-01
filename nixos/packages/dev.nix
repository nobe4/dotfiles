# Defines all dependencies for development work.
{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  allowedUnstableUnfree = [
    "github-copilot-cli"
  ];

  users.users.nobe4.packages =
    with pkgs;
    [
      kitty

      entr
      fzf
      fd

      git
      difftastic
      gh

      fzf
      ripgrep
      pv
      universal-ctags

      devenv

      tldr
      tree-sitter

      # Needed globally to run the copilot lsp
      nodejs

      tree-sitter

      # Needed globally to run the copilot lsp
      nodejs

      # Needed globally to format devenv files
      nixd
      nixfmt

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
    ]
    ++ (import ./copy_paste.nix { inherit pkgs config; })
    ++ [ (import ./notify.nix { inherit pkgs config; }) ]
    ++ (import ./jq.nix { inherit pkgs; });

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  ln = with config; [
    [
      "${dotfiles}/nvim/"
      "${home}/.config/nvim"
    ]
    [
      "${dotfiles}/.gitconfig"
      "${home}/.gitconfig"
    ]
    [
      "${dotfiles}/.gitignore_global"
      "${home}/.gitignore_global"
    ]
    [
      "${dotfiles}/.pryrc"
      "${home}/.pryrc"
    ]
    [
      "${dotfiles}/kitty/"
      "${home}/.config/kitty"
    ]
    [
      "${dotfiles}/.ignore"
      "${home}/.ignore"
    ]
    [
      "${dotfiles}/.ctags.d"
      "${home}/.ctags.d"
    ]
    [
      "${dotfiles}/.vale.ini"
      "${home}/.config/vale/.vale.ini"
    ]
    [
      "${dotfiles}/gh-config.yml"
      "${home}/.config/gh/config.yml"
    ]
  ];
}
