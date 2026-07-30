#!/usr/bin/env zsh
# shellcheck shell=bash
# vim: foldmarker={,} foldmethod=marker

# Setup
export DOTFILE_FOLDER="${XDG_CONFIG_HOME:-${HOME:?}/.config}/dotfiles"

export DEV_PATH="${HOME:?}/dev"

# PATH
PATH="/usr/local/sbin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="/usr/bin:$PATH"
PATH="$DOTFILE_FOLDER/bin/commands:$DOTFILE_FOLDER/bin:$PATH"
PATH="$DOTFILE_FOLDER/private/bin:$DOTFILE_FOLDER/private/bin/commands:$PATH"
PATH="$HOME/.local/kitty.app/bin:$PATH"

# macos Applications
is_macos && {
	if [[ ! "$PATH" == *Applications* ]]; then
		PATH="$PATH:/Applications:$HOME/Applications"
	fi

	BREW_PREFIX="/opt/homebrew/"

	# Cache `brew shellenv` so we don't spawn brew on every login. Refresh when the
	# brew binary is newer than the cache.
	brew_cache="${XDG_CACHE_HOME:-$HOME/.cache}/brew-shellenv.zsh"
	if [[ ! -f $brew_cache || ${BREW_PREFIX}/bin/brew -nt $brew_cache ]]; then
		"${BREW_PREFIX}/bin/brew" shellenv > "$brew_cache"
	fi
	source "$brew_cache"
}

# FZF
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
	PATH="$PATH:/usr/local/opt/fzf/bin"
fi
export FZF_DEFAULT_COMMAND="rg --files --follow"
export FZF_DEFAULT_OPTS='--no-mouse'

# Go
PATH="$PATH:/usr/local/go/bin:$HOME/go:$HOME/go/bin"

# difftastic
export DFT_SYNTAX_HIGHLIGHT=off
export DFT_CONTEXT=1

FPATH="$DOTFILE_FOLDER/functions:$FPATH"
MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

source "$DOTFILE_FOLDER/private/.zprofile"

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
