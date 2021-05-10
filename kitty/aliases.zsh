#!/usr/bin/env zsh

export KITTY_CONFIG_DIRECTORY="$ZSH/kitty/"

if [ -n "$IS_MACOS" ]; then
	alias kitty='/Applications/kitty.app/Contents/MacOS/kitty'
fi
