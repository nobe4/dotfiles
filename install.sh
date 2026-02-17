#!/usr/bin/env zsh
# vim: foldmarker={,} foldmethod=marker

# This script installs all requirements.

# Setup {
export DOTFILE_FOLDER="${HOME:?}/dev/nobe4/dotfiles"
source "$DOTFILE_FOLDER/shell/utils.sh"
# }

# TODO: port and verify this
# is_macos && {
# 	# GPG
# 	mkdir -p "$HOME/.gnupg"
# 	echo "pinentry-program $BREW_PREFIX/bin/pinentry-mac" > "$HOME/.gnupg/gpg-agent.conf"
# 	echo 'use-agent' > "$HOME/.gnupg/gpg.conf"
# 	chmod 700 "$HOME/.gnupg"
# }
# Only linking the config, to keep the other files alive
# link "$DOTFILE_FOLDER/.gnupg/gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"

# Private {
./private/install.sh
# }
