#!/usr/bin/env zsh

if [ -n "$IS_LINUX" ]; then
	unsetopt BG_NICE
fi
