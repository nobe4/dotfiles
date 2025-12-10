#!/usr/bin/env zsh
# shellcheck shell=bash
# vim: foldmarker={,} foldmethod=marker

# Setup
export DOTFILE_FOLDER="${HOME:?}/dev/nobe4/dotfiles"
source "$DOTFILE_FOLDER/shell/utils.sh"

# Disable the global .zshrc and .zshenv files.
# This is especially important for macOS which likes to include its own into the
# PATH.
unsetopt GLOBAL_RCS

# PATH
PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="$DOTFILE_FOLDER/bin/commands:$DOTFILE_FOLDER/bin:$PATH"
PATH="$DOTFILE_FOLDER/private/bin:$DOTFILE_FOLDER/private/bin/commands:$PATH"
PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
PATH="$HOME/.local/kitty.app/bin:$PATH"

is_macos && { BREW_PREFIX="/opt/homebrew/" }

# macos Applications
is_macos && {
  if [[ ! "$PATH" == *Applications* ]]; then
    PATH="$PATH:/Applications:$HOME/Applications"
  fi

  # FZF
  if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
    PATH="$PATH:/usr/local/opt/fzf/bin"
    export FZF_DEFAULT_OPTS='--no-mouse'
  fi
}

# Go
PATH="$PATH:/usr/local/go/bin:$HOME/go:$HOME/go/bin"

# difftastic
export DFT_SYNTAX_HIGHLIGHT=off
export DFT_CONTEXT=1

FPATH="$DOTFILE_FOLDER/functions:$FPATH"
MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

export GPG_TTY=$(tty)

# Python
unset PYTHONHOME
unset PYTHONPATH
export PYTHONDONTWRITEBYTECODE=1

export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'

export FPATH
export MANPATH
export PATH
