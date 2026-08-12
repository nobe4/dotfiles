#!/usr/bin/env zsh

source "$DOTFILE_FOLDER/private/.zprofile"

is_macos && {
	BREW_PREFIX="/opt/homebrew/"

	# Cache `brew shellenv` so we don't spawn brew on every login. Refresh when the
	# brew binary is newer than the cache.
	brew_cache="${XDG_CACHE_HOME:-$HOME/.cache}/brew-shellenv.zsh"
	if [[ ! -f $brew_cache || ${BREW_PREFIX}/bin/brew -nt $brew_cache ]]; then
		"${BREW_PREFIX}/bin/brew" shellenv > "$brew_cache"
	fi
	source "$brew_cache"
}

FPATH="$DOTFILE_FOLDER/functions:$FPATH"
