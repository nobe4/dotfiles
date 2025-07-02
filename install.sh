#!/usr/bin/env zsh
# vim: foldmarker={,} foldmethod=marker

# This script installs all requirements.

# Setup {
export DOTFILE_FOLDER="${HOME:?}/dev/nobe4/dotfiles"
source "$DOTFILE_FOLDER/utils.zsh"
# }

mkdir -p "$HOME/.local/bin"

link "$DOTFILE_FOLDER/nixos/" "$HOME/.config/nixos"
link "$DOTFILE_FOLDER/rofi/" "$HOME/.config/rofi"
link "$DOTFILE_FOLDER/hypr/" "$HOME/.config/hypr"
link "$DOTFILE_FOLDER/waybar/" "$HOME/.config/waybar"
link "$DOTFILE_FOLDER/uwsm/" "$HOME/.config/uwsm"
link "$DOTFILE_FOLDER/.zshrc" "$HOME/.zshrc"
link "$DOTFILE_FOLDER/.zprofile" "$HOME/.zprofile"
link "$DOTFILE_FOLDER/.bashrc" "$HOME/.bashrc"
link "$DOTFILE_FOLDER/nvim/" "$HOME/.config/nvim"
link "$DOTFILE_FOLDER/.gitconfig" "$HOME/.gitconfig"
link "$DOTFILE_FOLDER/.gitignore_global" "$HOME/.gitignore_global"
link "$DOTFILE_FOLDER/.rubocop.yml" "$HOME/.rubocop.yml"
link "$DOTFILE_FOLDER/.pryrc" "$HOME/.pryrc"
link "$DOTFILE_FOLDER/kitty/" "$HOME/.config/kitty"
link "$DOTFILE_FOLDER/.ignore" "$HOME/.ignore"

# Making `jq` available for all process tho it's installed as `gojq`.
# This is somewhat easier than an alias or a function.
ln -s "${BREW_PREFIX}/bin/gojq" "${BREW_PREFIX}/bin/jq"

# ESPANSO_CONFIG="$(espanso path config)"
# trash "${ESPANSO_CONFIG}" || true
# link "$DOTFILE_FOLDER/espanso/" "${ESPANSO_CONFIG}"
# }

touch "$HOME/.z"

mkdir -p "$HOME/.config/vale"
link "$DOTFILE_FOLDER/.vale.ini" "$HOME/.config/vale/.vale.ini"
# vale sync

mkdir -p "$HOME/.config/gh"
link "$DOTFILE_FOLDER/gh-config.yml" "$HOME/.config/gh/config.yml"


is_macos && {
	# GPG
	mkdir -p "$HOME/.gnupg"
	echo "pinentry-program $BREW_PREFIX/bin/pinentry-mac" > "$HOME/.gnupg/gpg-agent.conf"
	echo 'use-agent' > "$HOME/.gnupg/gpg.conf"
	chmod 700 "$HOME/.gnupg"

	# hammerspoon
	link "$DOTFILE_FOLDER/hammerspoon/" "$HOME/.hammerspoon"
}

# Private {
./private/install.sh
# }
