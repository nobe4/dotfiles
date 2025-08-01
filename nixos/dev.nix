# Defines all dependencies for development work.
{ pkgs, ... }:
{
  # Required by devenv to update the nix store.
  nix.settings.trusted-users = [ "nobe4" ];

  users.users.nobe4.packages = with pkgs; [
    devenv

    # Eventually, most of those should live in the devenv.

    # Build tools
    gnumake
    gcc

    # C/C++
    clang-tools
    clang

    # Rust
    cargo

    # Go
    go
    gopls
    golangci-lint
    hugo

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
  ];
}
