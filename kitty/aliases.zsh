#!/usr/bin/env zsh

export KITTY_CONFIG_DIRECTORY="$DOTFILE_FOLDER/kitty/"

if [ -n "$IS_MACOS" ]; then
	alias kitty='/Applications/kitty.app/Contents/MacOS/kitty'
fi
