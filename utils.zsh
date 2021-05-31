#!/usr/bin/env zsh

set -e

# List of utilities for the installation

# Check if shell is interactive
case $- in
  *i*) export IS_INTERACTIVE="1";;
  *) echo IS_SCRIPT="1";;
esac

function is_interactive {
	if [ -n "$IS_INTERACTIVE" ]; then
		return 0
	fi
	return 1
}

# Which OS is running
unameOut="$(uname -s)"
case "${unameOut}" in
	Linux*) export IS_LINUX="1";;
	Darwin*) export IS_MACOS="1";;
	*) exit 1
esac

function is_macos {
	if [ -n "$IS_MACOS" ]; then
		return 0
	fi
	return 1
}
function is_linux {
	if [ -n "$IS_LINUX" ]; then
		return 0
	fi
	return 1
}

function wait_until {
	read -s -k "?Press enter when $1..."
}
