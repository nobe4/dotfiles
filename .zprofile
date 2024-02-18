#!/usr/bin/env zsh
# shellcheck shell=bash
# vim: foldmarker={,} foldmethod=marker

# Setup {
export DOTFILE_FOLDER="${XDG_CONFIG_HOME:-${HOME:?}/.config}/dotfiles"
source "$DOTFILE_FOLDER/utils.zsh"
# }

# PATH {
PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="$DOTFILE_FOLDER/bin/commands:$DOTFILE_FOLDER/bin:$PATH"
PATH="$DOTFILE_FOLDER/private/bin:$DOTFILE_FOLDER/private/bin/commands:$PATH"

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

# Go
PATH="$PATH:/usr/local/go/bin:$HOME/go:$HOME/go/bin"

export PATH
# }

# export TERM=xterm-256color
is_macos && export TERM=xterm-kitty

# difftastic
export DFT_SYNTAX_HIGHLIGHT=off
export DFT_CONTEXT=1

# Functions PATH {
FPATH="$DOTFILE_FOLDER/functions:$FPATH"

export FPATH
# }

# Man PATH {
MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
export MANPATH
# }

export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'
