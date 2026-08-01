# Defines all dependencies for development work.
{
  config,
  pkgs,
  pkgs-unstable,
  ...
}:
{

  users.users.nobe4.packages =
    with pkgs;
    [
      (kitty.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          ../patches/kitty_bg_alpha.patch
        ];
      }))

      entr
      fzf
      fd

      git
      gh
      difftastic

      fzf
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
