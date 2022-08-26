#!/usr/bin/env zsh
# shellcheck shell=bash
# vim: foldmarker={,} foldmethod=marker

# Setup {
export DOTFILE_FOLDER="$HOME/.dot"
source "$DOTFILE_FOLDER/utils.zsh"
# }

# PATH {
PATH="$DOTFILE_FOLDER/bin:$HOME/.local/bin:$DOTFILE_FOLDER/private/bin:$PATH"

# macos Applications
is_macos && {
  if [[ ! "$PATH" == *Applications* ]]; then
    PATH="$PATH:/Applications:$HOME/Applications"
  fi
}

# FZF
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  PATH="$PATH:/usr/local/opt/fzf/bin"
fi

# Macvim
is_macos && {
  PATH="/Applications/MacVim.app/Contents/bin:$PATH"
}

# Go
# Same as `which go`
PATH="$PATH:/usr/local/go/bin:$HOME/go:$HOME/go/bin"

# Haskell
PATH="$PATH:$HOME/.cabal/bin:$HOME/.ghcup/bin"

# Shims
PATH="$HOME/.rbenv/shims:$PATH"
PATH="$HOME/.nodenv/shims:$PATH"
PATH="$HOME/.pyenv/shims:$PATH"

# LLVM
PATH="/usr/local/opt/llvm/bin:$PATH"

export PATH
# }

# Man PATH {
MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

export MANPATH
# }
